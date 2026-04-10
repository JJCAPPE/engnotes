#!/usr/bin/env python3
"""
Projectile Motion Lab Analysis + LaTeX Show-Work Generator

Edit only the USER INPUT section, then run:
    python projectile_lab_report.py

Outputs:
- summary CSV files
- PNG plots
- a LaTeX file with formulas, substitutions, and uncertainty work

Implements the equations from the BU PY211 projectile-motion lab handout.
"""

from __future__ import annotations

import csv
import math
import shutil
import subprocess
from dataclasses import dataclass
from pathlib import Path
from typing import Callable, Iterable

import matplotlib.pyplot as plt
import numpy as np


# ============================================================
# USER INPUT — replace these values with your own measurements
# ============================================================
USER_INPUT = {
    "g_m_s2": 9.81,
    "output_dir": "projectile_lab_output",
    # Use "from_vertical" if the launcher angles you recorded are measured from vertical.
    # Use "from_horizontal" if your recorded angles are already from horizontal.
    "angle_input_mode": "from_vertical",
    # Use "sem" for standard error of the mean, or "std" for standard deviation.
    "measured_range_uncertainty_mode": "sem",
    # If True, the script will try to compile the .tex file into a PDF using pdflatex.
    "compile_latex_pdf_if_available": True,
    # Calibration shot at theta = 0 degrees (horizontal launch)
    "theta0_trial": {
        "h_m": 1.015,
        "dh_m": 0.005,
        "ranges_m": [1.84, 1.83, 1.81, 1.78, 1.82],
    },
    # All nonzero-angle trials
    "angle_trials": [
        {"angle_deg": 10.0, "dangle_deg": 0.5, "h_m": 1.035, "dh_m": 0.005, "ranges_m": [2.015, 2.005, 2.010]},
        {"angle_deg": 15.0, "dangle_deg": 0.5, "h_m": 1.040, "dh_m": 0.005, "ranges_m": [2.070, 2.060, 2.075]},
        {"angle_deg": 20.0, "dangle_deg": 0.5, "h_m": 1.050, "dh_m": 0.005, "ranges_m": [2.180, 2.205, 2.185]},
        {"angle_deg": 25.0, "dangle_deg": 0.5, "h_m": 1.070, "dh_m": 0.005, "ranges_m": [2.295, 2.270, 2.300]},
        {"angle_deg": 30.0, "dangle_deg": 0.5, "h_m": 1.080, "dh_m": 0.005, "ranges_m": [2.340, 2.320, 2.330]},
        {"angle_deg": 35.0, "dangle_deg": 0.5, "h_m": 1.090, "dh_m": 0.005, "ranges_m": [2.350, 2.330, 2.350]},
    ],
}


# ============================================================
# Core math helpers
# ============================================================
@dataclass
class ShotStats:
    n: int
    mean: float
    std: float
    uncertainty: float
    values: list[float]


@dataclass
class CalibrationResult:
    h_m: float
    dh_m: float
    range_stats: ShotStats
    v0_m_s: float
    dv0_m_s: float


@dataclass
class AngleResult:
    angle_input_deg: float
    angle_horizontal_deg: float
    dangle_deg: float
    angle_horizontal_rad: float
    dangle_rad: float
    h_m: float
    dh_m: float
    range_stats: ShotStats
    rcalc_m: float
    drcalc_m: float
    residual_m: float
    residual_unc_m: float
    z_score: float
    partial_dR_dv: float
    partial_dR_dh: float
    partial_dR_dtheta: float


def fmt(x: float, digits: int = 6) -> str:
    if isinstance(x, (int, np.integer)):
        return str(int(x))
    if not np.isfinite(x):
        return str(x)
    if x == 0:
        return "0"
    ax = abs(x)
    if ax >= 1e4 or ax < 1e-4:
        return f"{x:.{digits-1}e}"
    return f"{x:.{digits}g}"


def latex_num(x: float, digits: int = 6) -> str:
    s = fmt(x, digits)
    return s.replace("e", r"\\times 10^{") + ("}" if "e" in s else "") if False else s


def latex_scientific(x: float, digits: int = 6) -> str:
    if x == 0:
        return "0"
    s = f"{x:.{digits-1}e}"
    mantissa, exp = s.split("e")
    return rf"{mantissa}\\times 10^{{{int(exp)}}}"


def latex_fmt(x: float, digits: int = 6) -> str:
    ax = abs(x)
    if x == 0:
        return "0"
    if ax >= 1e4 or ax < 1e-4:
        return latex_scientific(x, digits)
    return f"{x:.{digits}g}"


def to_horizontal_deg(angle_deg: float, mode: str) -> float:
    if mode == "from_horizontal":
        return angle_deg
    if mode == "from_vertical":
        return 90.0 - angle_deg
    raise ValueError("angle_input_mode must be 'from_horizontal' or 'from_vertical'.")


def compute_stats(values: Iterable[float], uncertainty_mode: str = "sem") -> ShotStats:
    vals = np.array(list(values), dtype=float)
    if vals.size == 0:
        raise ValueError("Each trial must contain at least one range value.")
    n = int(vals.size)
    mean = float(np.mean(vals))
    std = float(np.std(vals, ddof=1)) if n > 1 else 0.0
    if uncertainty_mode == "sem":
        unc = std / math.sqrt(n) if n > 1 else 0.0
    elif uncertainty_mode == "std":
        unc = std
    else:
        raise ValueError("measured_range_uncertainty_mode must be 'sem' or 'std'.")
    return ShotStats(n=n, mean=mean, std=std, uncertainty=unc, values=vals.tolist())


def v0_from_horizontal_range(r_mean: float, h: float, g: float) -> float:
    return r_mean * math.sqrt(g / (2.0 * h))


def dv0_propagated(r_mean: float, dr_mean: float, h: float, dh: float, g: float) -> float:
    v0 = v0_from_horizontal_range(r_mean, h, g)
    if r_mean == 0 or h == 0:
        return 0.0
    rel2 = (dr_mean / r_mean) ** 2 + 0.25 * (dh / h) ** 2
    return abs(v0) * math.sqrt(rel2)


def projectile_range(v0: float, theta_rad: float, h: float, g: float) -> float:
    root_arg = math.sin(theta_rad) ** 2 + 2.0 * g * h / (v0 ** 2)
    if root_arg < 0:
        raise ValueError("Unphysical parameters: square-root argument became negative.")
    return (v0 ** 2 * math.cos(theta_rad) / g) * (
        math.sin(theta_rad) + math.sqrt(root_arg)
    )


def central_difference(f: Callable[[float], float], x: float, dx: float) -> float:
    dx = abs(dx)
    if dx == 0:
        dx = max(1e-8, 1e-6 * max(1.0, abs(x)))
    return (f(x + dx) - f(x - dx)) / (2.0 * dx)


def analyze_calibration(user_input: dict) -> CalibrationResult:
    g = float(user_input["g_m_s2"])
    theta0 = user_input["theta0_trial"]
    stats = compute_stats(theta0["ranges_m"], user_input["measured_range_uncertainty_mode"])
    h = float(theta0["h_m"])
    dh = float(theta0["dh_m"])
    v0 = v0_from_horizontal_range(stats.mean, h, g)
    dv0 = dv0_propagated(stats.mean, stats.uncertainty, h, dh, g)
    return CalibrationResult(h_m=h, dh_m=dh, range_stats=stats, v0_m_s=v0, dv0_m_s=dv0)


def analyze_angles(user_input: dict, calib: CalibrationResult) -> list[AngleResult]:
    g = float(user_input["g_m_s2"])
    mode = user_input["angle_input_mode"]
    out: list[AngleResult] = []

    for trial in user_input["angle_trials"]:
        stats = compute_stats(trial["ranges_m"], user_input["measured_range_uncertainty_mode"])
        angle_in = float(trial["angle_deg"])
        dangle_deg = float(trial["dangle_deg"])
        angle_h_deg = to_horizontal_deg(angle_in, mode)
        theta = math.radians(angle_h_deg)
        dtheta = math.radians(dangle_deg)
        h = float(trial["h_m"])
        dh = float(trial["dh_m"])

        rcalc = projectile_range(calib.v0_m_s, theta, h, g)

        dR_dv = central_difference(lambda vv: projectile_range(vv, theta, h, g), calib.v0_m_s, max(1e-6, 1e-6 * calib.v0_m_s))
        dR_dh = central_difference(lambda hh: projectile_range(calib.v0_m_s, theta, hh, g), h, max(1e-8, 1e-6 * max(1.0, abs(h))))
        dR_dtheta = central_difference(lambda th: projectile_range(calib.v0_m_s, th, h, g), theta, max(1e-8, 1e-6 * max(1.0, abs(theta))))

        drcalc = math.sqrt((dR_dv * calib.dv0_m_s) ** 2 + (dR_dh * dh) ** 2 + (dR_dtheta * dtheta) ** 2)
        residual = stats.mean - rcalc
        residual_unc = math.sqrt(stats.uncertainty ** 2 + drcalc ** 2)
        z_score = residual / residual_unc if residual_unc != 0 else float("nan")

        out.append(
            AngleResult(
                angle_input_deg=angle_in,
                angle_horizontal_deg=angle_h_deg,
                dangle_deg=dangle_deg,
                angle_horizontal_rad=theta,
                dangle_rad=dtheta,
                h_m=h,
                dh_m=dh,
                range_stats=stats,
                rcalc_m=rcalc,
                drcalc_m=drcalc,
                residual_m=residual,
                residual_unc_m=residual_unc,
                z_score=z_score,
                partial_dR_dv=dR_dv,
                partial_dR_dh=dR_dh,
                partial_dR_dtheta=dR_dtheta,
            )
        )
    return out


# ============================================================
# Output helpers
# ============================================================

def write_csv(path: Path, rows: list[dict]) -> None:
    if not rows:
        return
    with path.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=list(rows[0].keys()))
        writer.writeheader()
        writer.writerows(rows)


def make_output_tables(calib: CalibrationResult, angles: list[AngleResult], out_dir: Path) -> None:
    calib_rows = [
        {
            "theta_deg": 0.0,
            "h_m": calib.h_m,
            "dh_m": calib.dh_m,
            "n": calib.range_stats.n,
            "Rbar_meas_m": calib.range_stats.mean,
            "s_R_m": calib.range_stats.std,
            "dRbar_meas_m": calib.range_stats.uncertainty,
            "v0_calc_m_s": calib.v0_m_s,
            "dv0_calc_m_s": calib.dv0_m_s,
        }
    ]
    angle_rows = []
    for a in angles:
        angle_rows.append(
            {
                "angle_input_deg": a.angle_input_deg,
                "angle_horizontal_deg": a.angle_horizontal_deg,
                "dangle_deg": a.dangle_deg,
                "h_m": a.h_m,
                "dh_m": a.dh_m,
                "n": a.range_stats.n,
                "Rbar_meas_m": a.range_stats.mean,
                "s_R_m": a.range_stats.std,
                "dRbar_meas_m": a.range_stats.uncertainty,
                "Rcalc_m": a.rcalc_m,
                "dRcalc_m": a.drcalc_m,
                "residual_m": a.residual_m,
                "residual_unc_m": a.residual_unc_m,
                "z_score": a.z_score,
            }
        )
    write_csv(out_dir / "table1_calibration.csv", calib_rows)
    write_csv(out_dir / "table2_angles.csv", angle_rows)


def plot_histogram(values: list[float], title: str, xlabel: str, out_path: Path) -> None:
    fig, ax = plt.subplots(figsize=(7, 4.5))
    ax.hist(values, bins="auto", edgecolor="black")
    ax.set_title(title)
    ax.set_xlabel(xlabel)
    ax.set_ylabel("Count")
    fig.tight_layout()
    fig.savefig(out_path, dpi=220)
    plt.close(fig)


def make_plots(calib: CalibrationResult, angles: list[AngleResult], out_dir: Path) -> None:
    plot_histogram(
        calib.range_stats.values,
        title=r"$\theta = 0^\circ$ range distribution",
        xlabel="Range (m)",
        out_path=out_dir / "calibration_range_distribution.png",
    )

    for a in angles:
        safe_angle = str(a.angle_input_deg).replace(".", "p")
        plot_histogram(
            a.range_stats.values,
            title=rf"Measured range distribution, input angle = {a.angle_input_deg:g}$^\circ$",
            xlabel="Range (m)",
            out_path=out_dir / f"range_distribution_angle_{safe_angle}.png",
        )

    xs = np.array([a.angle_input_deg for a in angles], dtype=float)
    y_meas = np.array([a.range_stats.mean for a in angles], dtype=float)
    dy_meas = np.array([a.range_stats.uncertainty for a in angles], dtype=float)
    y_calc = np.array([a.rcalc_m for a in angles], dtype=float)
    dy_calc = np.array([a.drcalc_m for a in angles], dtype=float)
    residuals = np.array([a.residual_m for a in angles], dtype=float)
    dres = np.array([a.residual_unc_m for a in angles], dtype=float)

    fig, ax = plt.subplots(figsize=(8, 5))
    ax.errorbar(xs, y_meas, yerr=dy_meas, fmt="o", capsize=4, label="Measured")
    ax.errorbar(xs, y_calc, yerr=dy_calc, fmt="s", capsize=4, label="Calculated")
    ax.set_xlabel("Input angle (deg)")
    ax.set_ylabel("Range (m)")
    ax.set_title("Measured vs calculated range")
    ax.legend()
    fig.tight_layout()
    fig.savefig(out_dir / "measured_vs_calculated_range.png", dpi=220)
    plt.close(fig)

    fig, ax = plt.subplots(figsize=(8, 5))
    ax.errorbar(xs, residuals, yerr=dres, fmt="o", capsize=4)
    ax.axhline(0.0, linewidth=1)
    ax.set_xlabel("Input angle (deg)")
    ax.set_ylabel(r"$\overline{R}_{\mathrm{meas}} - R_{\mathrm{calc}}$ (m)")
    ax.set_title("Residuals with combined uncertainty")
    fig.tight_layout()
    fig.savefig(out_dir / "residuals_vs_angle.png", dpi=220)
    plt.close(fig)


def latex_escape_text(s: str) -> str:
    replacements = {
        "_": r"\_",
        "%": r"\%",
        "&": r"\&",
        "#": r"\#",
        "$": r"\$",
        "{": r"\{",
        "}": r"\}",
    }
    out = s
    for k, v in replacements.items():
        out = out.replace(k, v)
    return out


def list_to_latex_sum(values: list[float], digits: int = 6) -> str:
    return " + ".join(latex_fmt(v, digits) for v in values)


def list_to_latex_var(values: list[float], mean: float, digits: int = 6) -> str:
    return " + ".join(rf"({latex_fmt(v, digits)} - {latex_fmt(mean, digits)})^2" for v in values)


def generate_latex(calib: CalibrationResult, angles: list[AngleResult], user_input: dict, out_dir: Path) -> None:
    mode = user_input["angle_input_mode"]
    uncertainty_mode = user_input["measured_range_uncertainty_mode"]
    unc_symbol = r"\delta \overline{R}" if uncertainty_mode == "sem" else r"\delta R"
    unc_formula = r"\delta \overline{R} = \dfrac{s_R}{\sqrt{n}}" if uncertainty_mode == "sem" else r"\delta R = s_R"

    lines: list[str] = []
    add = lines.append

    add(r"\documentclass[11pt]{article}")
    add(r"\usepackage[margin=0.7in]{geometry}")
    add(r"\usepackage{amsmath,amssymb,booktabs,array,longtable}")
    add(r"\setlength{\parindent}{0pt}")
    add(r"\setlength{\arraycolsep}{4pt}")
    add(r"\allowdisplaybreaks")
    add(r"\begin{document}")
    add(r"\scriptsize")
    add(r"\[")
    add(r"\textbf{Projectile Motion Lab Calculations}")
    add(r"\]")

    # Table 1
    add(r"\[")
    add(r"\begin{array}{cccccccc}")
    add(r"\toprule")
    add(r"\theta(^\circ) & h(\mathrm{m}) & \overline{R}_{\mathrm{meas}}(\mathrm{m}) & " + unc_symbol + r"(\mathrm{m}) & v_0(\mathrm{m/s}) & \delta v_0(\mathrm{m/s}) & n & s_R(\mathrm{m})\\")
    add(r"\midrule")
    add(
        rf"0 & {latex_fmt(calib.h_m)} & {latex_fmt(calib.range_stats.mean)} & {latex_fmt(calib.range_stats.uncertainty)} & {latex_fmt(calib.v0_m_s)} & {latex_fmt(calib.dv0_m_s)} & {calib.range_stats.n} & {latex_fmt(calib.range_stats.std)} \\")
    add(r"\bottomrule")
    add(r"\end{array}")
    add(r"\]")

    # Calibration work
    vals0 = calib.range_stats.values
    add(r"\[")
    add(rf"\overline{{R}}_0 = \frac{{1}}{{{calib.range_stats.n}}}\left({list_to_latex_sum(vals0)}\right) = {latex_fmt(calib.range_stats.mean)}\ \mathrm{{m}}")
    add(r"\]")
    add(r"\[")
    add(
        rf"s_{{R,0}} = \sqrt{{\frac{{1}}{{{calib.range_stats.n - 1}}}\left({list_to_latex_var(vals0, calib.range_stats.mean)}\right)}} = {latex_fmt(calib.range_stats.std)}\ \mathrm{{m}}"
    )
    add(r"\]")
    add(r"\[")
    add(rf"{unc_formula} = {latex_fmt(calib.range_stats.uncertainty)}\ \mathrm{{m}}")
    add(r"\]")
    add(r"\[")
    add(r"v_0 = \overline{R}_0\sqrt{\frac{g}{2h}}")
    add(r"\]")
    add(r"\[")
    add(
        rf"v_0 = ({latex_fmt(calib.range_stats.mean)})\sqrt{{\frac{{{latex_fmt(user_input['g_m_s2'])}}}{{2({latex_fmt(calib.h_m)})}}}} = {latex_fmt(calib.v0_m_s)}\ \mathrm{{m/s}}"
    )
    add(r"\]")
    add(r"\[")
    add(r"\delta v_0 = v_0\sqrt{\left(\frac{\delta \overline{R}_0}{\overline{R}_0}\right)^2 + \frac{1}{4}\left(\frac{\delta h}{h}\right)^2}")
    add(r"\]")
    add(r"\[")
    add(
        rf"\delta v_0 = ({latex_fmt(calib.v0_m_s)})\sqrt{{\left(\frac{{{latex_fmt(calib.range_stats.uncertainty)}}}{{{latex_fmt(calib.range_stats.mean)}}}\right)^2 + \frac{{1}}{{4}}\left(\frac{{{latex_fmt(calib.dh_m)}}}{{{latex_fmt(calib.h_m)}}}\right)^2}} = {latex_fmt(calib.dv0_m_s)}\ \mathrm{{m/s}}"
    )
    add(r"\]")

    # Table 2
    add(r"\[")
    add(r"\begin{array}{cccccccccc}")
    add(r"\toprule")
    input_angle_label = r"\theta_{\mathrm{in}}(^\circ)"
    horiz_angle_label = r"\theta_{\mathrm{h}}(^\circ)"
    add(
        input_angle_label
        + r" & "
        + horiz_angle_label
        + r" & h(\mathrm{m}) & \overline{R}_{\mathrm{meas}}(\mathrm{m}) & "
        + unc_symbol
        + r"(\mathrm{m}) & R_{\mathrm{calc}}(\mathrm{m}) & \delta R_{\mathrm{calc}}(\mathrm{m}) & \Delta(\mathrm{m}) & z & n\\"
    )
    add(r"\midrule")
    for a in angles:
        add(
            rf"{latex_fmt(a.angle_input_deg)} & {latex_fmt(a.angle_horizontal_deg)} & {latex_fmt(a.h_m)} & {latex_fmt(a.range_stats.mean)} & {latex_fmt(a.range_stats.uncertainty)} & {latex_fmt(a.rcalc_m)} & {latex_fmt(a.drcalc_m)} & {latex_fmt(a.residual_m)} & {latex_fmt(a.z_score)} & {a.range_stats.n} \\")
    add(r"\bottomrule")
    add(r"\end{array}")
    add(r"\]")

    if mode == "from_vertical":
        add(r"\[")
        add(r"\theta_{\mathrm{h}} = 90^{\circ} - \theta_{\mathrm{in}}")
        add(r"\]")

    for i, a in enumerate(angles, start=1):
        vals = a.range_stats.values
        add(r"\[")
        add(rf"\textbf{{Trial {i}}}")
        add(r"\]")
        if mode == "from_vertical":
            add(r"\[")
            add(
                rf"\theta_{{\mathrm{{h}},{i}}} = 90^\circ - {latex_fmt(a.angle_input_deg)}^\circ = {latex_fmt(a.angle_horizontal_deg)}^\circ"
            )
            add(r"\]")
        add(r"\[")
        add(rf"\overline{{R}}_{{\mathrm{{meas}},{i}}} = \frac{{1}}{{{a.range_stats.n}}}\left({list_to_latex_sum(vals)}\right) = {latex_fmt(a.range_stats.mean)}\ \mathrm{{m}}")
        add(r"\]")
        add(r"\[")
        add(
            rf"s_{{R,{i}}} = \sqrt{{\frac{{1}}{{{a.range_stats.n - 1}}}\left({list_to_latex_var(vals, a.range_stats.mean)}\right)}} = {latex_fmt(a.range_stats.std)}\ \mathrm{{m}}"
        )
        add(r"\]")
        add(r"\[")
        add(rf"{unc_formula} = {latex_fmt(a.range_stats.uncertainty)}\ \mathrm{{m}}")
        add(r"\]")
        add(r"\[")
        add(r"R_{\mathrm{calc}} = \frac{v_0^2\cos\theta}{g}\left(\sin\theta + \sqrt{\sin^2\theta + \frac{2gh}{v_0^2}}\right)")
        add(r"\]")
        add(r"\[")
        add(
            rf"R_{{\mathrm{{calc}},{i}}} = \frac{{({latex_fmt(calib.v0_m_s)})^2\cos({latex_fmt(a.angle_horizontal_deg)}^\circ)}}{{{latex_fmt(user_input['g_m_s2'])}}}\left(\sin({latex_fmt(a.angle_horizontal_deg)}^\circ) + \sqrt{{\sin^2({latex_fmt(a.angle_horizontal_deg)}^\circ) + \frac{{2({latex_fmt(user_input['g_m_s2'])})({latex_fmt(a.h_m)})}}{{({latex_fmt(calib.v0_m_s)})^2}}}}\right) = {latex_fmt(a.rcalc_m)}\ \mathrm{{m}}"
        )
        add(r"\]")
        add(r"\[")
        add(r"\delta R_{\mathrm{calc}} = \sqrt{\left(\frac{\partial R}{\partial v_0}\delta v_0\right)^2 + \left(\frac{\partial R}{\partial h}\delta h\right)^2 + \left(\frac{\partial R}{\partial \theta}\delta \theta\right)^2}")
        add(r"\]")
        add(r"\[")
        add(
            rf"\frac{{\partial R}}{{\partial v_0}} = {latex_fmt(a.partial_dR_dv)}\ \frac{{\mathrm{{m}}}}{{\mathrm{{m/s}}}},\quad \frac{{\partial R}}{{\partial h}} = {latex_fmt(a.partial_dR_dh)}\ ,\quad \frac{{\partial R}}{{\partial \theta}} = {latex_fmt(a.partial_dR_dtheta)}\ \frac{{\mathrm{{m}}}}{{\mathrm{{rad}}}}"
        )
        add(r"\]")
        add(r"\[")
        add(
            rf"\delta R_{{\mathrm{{calc}},{i}}} = \sqrt{{({latex_fmt(a.partial_dR_dv)}\cdot {latex_fmt(calib.dv0_m_s)})^2 + ({latex_fmt(a.partial_dR_dh)}\cdot {latex_fmt(a.dh_m)})^2 + ({latex_fmt(a.partial_dR_dtheta)}\cdot {latex_fmt(a.dangle_rad)})^2}} = {latex_fmt(a.drcalc_m)}\ \mathrm{{m}}"
        )
        add(r"\]")
        add(r"\[")
        add(
            rf"\Delta_i = \overline{{R}}_{{\mathrm{{meas}},{i}}} - R_{{\mathrm{{calc}},{i}}} = {latex_fmt(a.range_stats.mean)} - {latex_fmt(a.rcalc_m)} = {latex_fmt(a.residual_m)}\ \mathrm{{m}}"
        )
        add(r"\]")
        add(r"\[")
        add(
            rf"\delta \Delta_i = \sqrt{{({latex_fmt(a.range_stats.uncertainty)})^2 + ({latex_fmt(a.drcalc_m)})^2}} = {latex_fmt(a.residual_unc_m)}\ \mathrm{{m}}"
        )
        add(r"\]")
        add(r"\[")
        add(
            rf"z_i = \frac{{\Delta_i}}{{\delta \Delta_i}} = \frac{{{latex_fmt(a.residual_m)}}}{{{latex_fmt(a.residual_unc_m)}}} = {latex_fmt(a.z_score)}"
        )
        add(r"\]")

    add(r"\end{document}")

    tex_path = out_dir / "projectile_lab_show_work.tex"
    tex_path.write_text("\n".join(lines), encoding="utf-8")

    if user_input.get("compile_latex_pdf_if_available", False) and shutil.which("pdflatex"):
        try:
            subprocess.run(
                ["pdflatex", "-interaction=nonstopmode", "-halt-on-error", tex_path.name],
                cwd=out_dir,
                check=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                text=True,
            )
        except subprocess.CalledProcessError as e:
            print("Warning: pdflatex compilation failed. The .tex file was still created.")
            print(e.stdout)


def print_console_summary(calib: CalibrationResult, angles: list[AngleResult]) -> None:
    print("=" * 72)
    print("Calibration (theta = 0 deg)")
    print("=" * 72)
    print(f"Rbar_meas = {fmt(calib.range_stats.mean)} m")
    print(f"s_R       = {fmt(calib.range_stats.std)} m")
    print(f"dRbar     = {fmt(calib.range_stats.uncertainty)} m")
    print(f"v0        = {fmt(calib.v0_m_s)} m/s")
    print(f"dv0       = {fmt(calib.dv0_m_s)} m/s")
    print()
    print("=" * 72)
    print("Angle trials")
    print("=" * 72)
    for a in angles:
        print(
            f"angle_in={fmt(a.angle_input_deg):>6} deg | angle_h={fmt(a.angle_horizontal_deg):>6} deg | "
            f"Rbar={fmt(a.range_stats.mean):>8} m | dR={fmt(a.range_stats.uncertainty):>8} m | "
            f"Rcalc={fmt(a.rcalc_m):>8} m | dRcalc={fmt(a.drcalc_m):>8} m | z={fmt(a.z_score):>8}"
        )


def main() -> None:
    out_dir = Path(USER_INPUT["output_dir"]).expanduser().resolve()
    out_dir.mkdir(parents=True, exist_ok=True)

    calib = analyze_calibration(USER_INPUT)
    angles = analyze_angles(USER_INPUT, calib)

    make_output_tables(calib, angles, out_dir)
    make_plots(calib, angles, out_dir)
    generate_latex(calib, angles, USER_INPUT, out_dir)
    print_console_summary(calib, angles)
    print()
    print(f"Saved outputs to: {out_dir}")
    print("Files:")
    for p in sorted(out_dir.iterdir()):
        print(f"  - {p.name}")


if __name__ == "__main__":
    main()
