"""
PY 211 Lab 3 — weighted LS for Hooke's law, printed report + publication-style graph.
"""

from __future__ import annotations

import math
from dataclasses import dataclass
import sys
from pathlib import Path
from typing import Optional, Sequence, Union

try:
    import matplotlib.pyplot as plt
except ImportError:  # pragma: no cover - optional until user installs matplotlib
    plt = None  # type: ignore[misc, assignment]

# ---------------------------------------------------------------------------
# Enter your data below (edit and save, then run the script)
# ---------------------------------------------------------------------------

# Mass of each hanger + added mass, in kilograms
MASSES_KG = [
    0.010, 
    0.020,
    0.050,
    0.100,
    0.200,
]

# Measured spring extension for each mass (same order), in meters
EXTENSIONS_M = [
    3*10**-3,
    7*10**-3,
    19*10**-3,
    40*10**-3,
    80*10**-3,
]

# Uncertainty on each extension (m). Use one number for all if equal:
#   DELTA_EXTENSION_M = 0.001
# or list per point:
DELTA_EXTENSION_M: Union[float, Sequence[float]] = 0.001

# Local gravitational acceleration (m/s^2); use your lab value if given
G_MS2 = 9.80665

# If False, x = mass (kg) and B = g/k. If True, x = weight in N (m*g) and B = 1/k
USE_FORCE_AS_X = False

# Figure output (None = only show interactive window)
FIGURE_OUTPUT: Optional[Union[str, Path]] = Path(__file__).with_suffix("").name + "_graph.png"

# Display the plot window when running as __main__
SHOW_PLOT = True


@dataclass
class WeightedFitResult:
    """Best-fit y = A + B*x with weighted least squares (lab handout)."""

    A: float
    delta_A: float
    B: float
    delta_B: float
    k: float
    delta_k: float
    g_used: float
    sum_w: float
    denom: float
    chi2_reduced: Optional[float]


@dataclass
class SpringAnalysis:
    """Fit result plus the (x, y, δy) series used for the regression and graph."""

    result: WeightedFitResult
    x: list[float]
    y: list[float]
    delta_y: list[float]


def _as_delta_list(delta: Union[float, Sequence[float]], n: int) -> list[float]:
    if isinstance(delta, (int, float)):
        return [float(delta)] * n
    d = [float(x) for x in delta]
    if len(d) != n:
        raise ValueError(
            f"DELTA_EXTENSION_M: expected length {n} or a scalar, got {len(d)} values"
        )
    return d


def weighted_linear_fit(
    x: Sequence[float],
    y: Sequence[float],
    delta_y: Sequence[float],
) -> tuple[float, float, float, float, float, float, float]:
    """
    Weighted LS for y = A + B x with w_i = 1/δ_i² (uncertainties on y only).

    Returns (A, delta_A, B, delta_B, sum_w, denom, chi_squared)
    where chi_squared = Σ w_i (y_i - A - B x_i)².
    """
    n = len(x)
    if len(y) != n:
        raise ValueError("x and y must have the same length")
    if len(delta_y) != n:
        raise ValueError("delta_y must match length of x and y")

    w = [1.0 / (dy * dy) for dy in delta_y]
    sw = sum(w)
    swx = sum(w[i] * x[i] for i in range(n))
    swy = sum(w[i] * y[i] for i in range(n))
    swx2 = sum(w[i] * x[i] * x[i] for i in range(n))
    swxy = sum(w[i] * x[i] * y[i] for i in range(n))

    denom = sw * swx2 - swx * swx
    if abs(denom) < 1e-30:
        raise ValueError("Degenerate fit: check that x values are not all identical")

    A = (swx2 * swy - swx * swxy) / denom
    B = (sw * swxy - swx * swy) / denom

    delta_A = math.sqrt(swx2 / denom)
    delta_B = math.sqrt(sw / denom)

    chi2 = sum(
        w[i] * (y[i] - A - B * x[i]) ** 2 for i in range(n)
    )

    return A, delta_A, B, delta_B, sw, denom, chi2


def analyze_spring(
    masses_kg: Sequence[float],
    extensions_m: Sequence[float],
    delta_extension_m: Union[float, Sequence[float]],
    g_ms2: float = G_MS2,
    use_force_as_x: bool = USE_FORCE_AS_X,
) -> SpringAnalysis:
    """
    Fit extension vs mass (or vs weight) and return k ± δk.

    use_force_as_x=False: x = m, B = g/k  →  k = g/B, δk = g δB / B²
    use_force_as_x=True:  x = mg (N), B = 1/k  →  k = 1/B, δk = δB / B²
    """
    m = [float(v) for v in masses_kg]
    y = [float(v) for v in extensions_m]
    dy = _as_delta_list(delta_extension_m, len(m))

    if use_force_as_x:
        x = [mass * g_ms2 for mass in m]
        # Uncertainty on F = m g: assume δm negligible → δF ≈ 0 on x; lab treats x exact
    else:
        x = m

    A, dA, B, dB, sw, denom, chi2 = weighted_linear_fit(x, y, dy)

    nu = len(x) - 2  # degrees of freedom
    chi2_red = (chi2 / nu) if nu > 0 else None

    if use_force_as_x:
        if abs(B) < 1e-30:
            raise ValueError("Slope B is ~0; cannot compute k = 1/B")
        k = 1.0 / B
        delta_k = dB / (B * B)
    else:
        if abs(B) < 1e-30:
            raise ValueError("Slope B is ~0; cannot compute k = g/B")
        k = g_ms2 / B
        delta_k = g_ms2 * dB / (B * B)

    fit = WeightedFitResult(
        A=A,
        delta_A=dA,
        B=B,
        delta_B=dB,
        k=k,
        delta_k=delta_k,
        g_used=g_ms2,
        sum_w=sw,
        denom=denom,
        chi2_reduced=chi2_red,
    )
    return SpringAnalysis(result=fit, x=list(x), y=y, delta_y=dy)


def _apply_lab_plot_style() -> None:
    """Serif fonts, readable type, light grid — typical instructional lab figure."""
    plt.rcParams.update(
        {
            "figure.dpi": 120,
            "savefig.dpi": 300,
            "font.family": "serif",
            "font.serif": ["DejaVu Serif", "Times New Roman", "Nimbus Roman", "serif"],
            "mathtext.fontset": "dejavuserif",
            "font.size": 11,
            "axes.labelsize": 12,
            "axes.titlesize": 13,
            "legend.fontsize": 10,
            "xtick.labelsize": 10,
            "ytick.labelsize": 10,
            "axes.linewidth": 0.9,
            "grid.linewidth": 0.6,
            "grid.alpha": 0.35,
            "lines.linewidth": 1.4,
            "errorbar.capsize": 3,
        }
    )


def plot_spring_analysis(
    analysis: SpringAnalysis,
    use_force_as_x: bool = USE_FORCE_AS_X,
    title: str = "Hooke's law: extension vs load (weighted least-squares fit)",
    save_path: Optional[Union[str, Path]] = None,
    show: bool = True,
):
    """
    Scatter with y error bars and weighted LS line y = A + B x.

    Horizontal error bars omitted (mass / weight taken exact, per lab model).
    Requires matplotlib (`pip install matplotlib` in your venv).
    """
    if plt is None:
        raise ImportError(
            "Plotting needs matplotlib. Install with:  pip install matplotlib"
        )
    _apply_lab_plot_style()
    r = analysis.result
    x = [float(v) for v in analysis.x]
    y = [float(v) for v in analysis.y]
    dy = [float(v) for v in analysis.delta_y]

    if len(x) < 2:
        raise ValueError("Need at least two points to plot a meaningful fit.")

    fig, ax = plt.subplots(figsize=(6.5, 4.25), constrained_layout=True)

    xmin, xmax = min(x), max(x)
    x_pad = 0.06 * (xmax - xmin + 1e-12)
    x_lo, x_hi = xmin - x_pad, xmax + x_pad
    n_line = 200
    x_line = [x_lo + (x_hi - x_lo) * i / (n_line - 1) for i in range(n_line)]
    y_line = [r.A + r.B * xv for xv in x_line]

    ax.plot(
        x_line,
        y_line,
        color="#c0392b",
        linestyle="-",
        linewidth=1.8,
        zorder=2,
        label="Weighted LS fit",
    )

    (_, caps, _) = ax.errorbar(
        x,
        y,
        yerr=dy,
        fmt="o",
        color="#1a5276",
        ecolor="#2c3e50",
        elinewidth=1.0,
        capsize=3.5,
        capthick=1.0,
        markersize=6,
        markerfacecolor="#5dade2",
        markeredgecolor="#1a5276",
        markeredgewidth=1.0,
        zorder=3,
        label="Data",
    )
    for c in caps:
        c.set_markeredgewidth(1.0)

    if use_force_as_x:
        ax.set_xlabel(r"Weight $F = mg$ (N)")
    else:
        ax.set_xlabel(r"Mass $m$ (kg)")
    ax.set_ylabel(r"Spring extension $\Delta x$ (m)")

    ax.set_title(title, pad=10)
    ax.grid(True, which="major", linestyle="--", alpha=0.45)
    ax.minorticks_on()
    ax.grid(True, which="minor", linestyle=":", alpha=0.22)

    xunit = "N" if use_force_as_x else "kg"
    eq_text = (
        r"$\Delta x = A + B\,x$"
        + "\n"
        + rf"$A = ({r.A:.4g} \pm {r.delta_A:.4g})\ \mathrm{{m}}$"
        + "\n"
        + rf"$B = ({r.B:.4g} \pm {r.delta_B:.4g})\ \mathrm{{m/{xunit}}}$"
        + "\n"
        + rf"$k = ({r.k:.4g} \pm {r.delta_k:.4g})\ \mathrm{{N/m}}$"
    )
    if r.chi2_reduced is not None:
        eq_text += f"\n$\\chi^2/(N-2) = {r.chi2_reduced:.2f}$"

    ax.text(
        0.03,
        0.97,
        eq_text,
        transform=ax.transAxes,
        fontsize=9.5,
        verticalalignment="top",
        horizontalalignment="left",
        bbox=dict(boxstyle="round,pad=0.45", facecolor="white", edgecolor="#7f8c8d", alpha=0.92),
        family="serif",
    )

    leg = ax.legend(loc="lower right", frameon=True, fancybox=False, edgecolor="#bdc3c7")
    leg.get_frame().set_linewidth(0.8)
    leg.get_frame().set_alpha(0.95)

    for spine in ax.spines.values():
        spine.set_linewidth(0.9)

    if save_path is not None:
        p = Path(save_path)
        fig.savefig(p, bbox_inches="tight", facecolor="white", edgecolor="none")

    if show:
        plt.show()
    elif save_path is not None:
        plt.close(fig)
    return fig


def print_report(r: WeightedFitResult, use_force: bool) -> None:
    xname = "F (N)" if use_force else "m (kg)"
    print()
    print("Weighted least-squares fit:  extension = A + B × " + xname)
    print("-" * 60)
    print(f"  A = ({r.A:.6g} ± {r.delta_A:.6g}) m")
    print(f"  B = ({r.B:.6g} ± {r.delta_B:.6g}) m / ({'N' if use_force else 'kg'})")
    print(f"  g used = {r.g_used:.5f} m/s²")
    print()
    if use_force:
        print("  B = 1/k  →  k = 1/B")
    else:
        print("  B = g/k  →  k = g/B")
    print(f"  k = ({r.k:.5g} ± {r.delta_k:.5g}) N/m")
    print("    (final result form: k_best ± δk)")
    print("-" * 60)
    if r.chi2_reduced is not None:
        print(f"  χ²/(N−2) = {r.chi2_reduced:.3f}  (near 1 suggests uncertainties are consistent)")
    print()


def main() -> None:
    if len(MASSES_KG) != len(EXTENSIONS_M):
        raise SystemExit(
            "Edit MASSES_KG and EXTENSIONS_M so they have the same number of points."
        )

    analysis = analyze_spring(
        MASSES_KG,
        EXTENSIONS_M,
        DELTA_EXTENSION_M,
        g_ms2=G_MS2,
        use_force_as_x=USE_FORCE_AS_X,
    )
    print_report(analysis.result, USE_FORCE_AS_X)
    try:
        plot_spring_analysis(
            analysis,
            use_force_as_x=USE_FORCE_AS_X,
            save_path=FIGURE_OUTPUT,
            show=SHOW_PLOT,
        )
    except ImportError as exc:
        print(exc, file=sys.stderr)
        if FIGURE_OUTPUT:
            print(
                "Figure not saved (install matplotlib).",
                file=sys.stderr,
            )


if __name__ == "__main__":
    main()
