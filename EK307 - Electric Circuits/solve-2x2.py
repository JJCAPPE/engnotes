import argparse
import sys
from typing import Sequence

import numpy as np


def parse_resistance_value(token: str) -> float:
    """
    Parse a resistance token that may include a 'k' suffix for kilo-ohms.

    Examples: '10' -> 10.0, '10k' -> 10000.0, '-2k' -> -2000.0
    """

    text = str(token).strip()
    # Strip optional ohm annotations (Ω, ohm)
    text = (
        text.replace("Ω", "").replace("ohm", "").replace("Ohm", "").replace("OHM", "")
    )

    lower_text = text.lower()
    if lower_text.endswith("k"):
        number_part = text[:-1]
        return float(number_part) * 1e3

    return float(text)


def solve_2x2_system(
    A_entries: Sequence[float], b_entries: Sequence[float]
) -> np.ndarray:
    """
    Solve a 2x2 linear system A x = b for node voltages [Vx, Vy].

    A is provided as resistances (ohms) and converted internally to conductances (siemens).
    b contains the independent sources (currents).

    Parameters
    ----------
    A_entries: Sequence[float]
        Four numbers in row-major order [a11, a12, a21, a22].
    b_entries: Sequence[float]
        Two numbers [b1, b2].

    Returns
    -------
    np.ndarray
        Solution vector [Vx, Vy].

        python "/Users/giacomo/Documents/Engineering/Notes/EK307 - Electric Circuits/solve-2x2.py" --g 3 1 1 4 --b 2 3 --plain --precision 4
    """

    # Interpret inputs as resistances and convert to conductances (entrywise reciprocal)
    resistances_matrix = np.asarray(A_entries, dtype=float).reshape(2, 2)

    if np.any(np.isclose(resistances_matrix, 0.0)):
        raise ValueError(
            "Resistance entries must be non-zero to compute conductances (1/R)."
        )

    coefficient_matrix = 1.0 / resistances_matrix
    right_hand_side = np.asarray(b_entries, dtype=float).reshape(
        2,
    )

    determinant = float(np.linalg.det(coefficient_matrix))
    if abs(determinant) < 1e-12:
        raise np.linalg.LinAlgError(
            "Matrix is singular or ill-conditioned (determinant approximately zero)."
        )

    solution = np.linalg.solve(coefficient_matrix, right_hand_side)
    return solution


def main() -> None:
    parser = argparse.ArgumentParser(
        description=(
            "Solve 2x2 system A x = b for node voltages [Vx, Vy]. "
            "Provide A as resistances (ohms) in row-major order; the script uses A=1/R internally."
        )
    )

    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument(
        "--A",
        nargs=4,
        type=str,
        metavar=("R11", "R12", "R21", "R22"),
        help=(
            "Matrix A entries as resistances (ohms) in row-major order. "
            "Supports 'k' suffix (e.g., 10k for 10 kΩ)."
        ),
    )
    group.add_argument(
        "--R",
        nargs=4,
        type=str,
        metavar=("R11", "R12", "R21", "R22"),
        help=(
            "Alias for --A (resistances) in row-major order. "
            "Supports 'k' suffix (e.g., 10k for 10 kΩ)."
        ),
    )
    # Back-compat: allow --g but treat as resistances now
    group.add_argument(
        "--g",
        nargs=4,
        type=str,
        metavar=("R11", "R12", "R21", "R22"),
        help=(
            "(Alias) Resistances in row-major order. Equivalent to --A. "
            "Supports 'k' suffix (e.g., 10k for 10 kΩ)."
        ),
    )

    parser.add_argument(
        "--b",
        nargs=2,
        type=float,
        required=True,
        metavar=("b1", "b2"),
        help="Right-hand side vector b (currents).",
    )
    parser.add_argument(
        "--precision",
        type=int,
        default=6,
        help="Number of digits after the decimal when printing results.",
    )
    parser.add_argument(
        "--plain",
        action="store_true",
        help="Print only Vx Vy on one line (no extra information).",
    )

    args = parser.parse_args()

    A_tokens = (
        args.A
        if args.A is not None
        else (args.R if getattr(args, "R", None) is not None else args.g)
    )
    # Convert tokens (possibly like '10k') to numeric ohms
    A_entries = [parse_resistance_value(token) for token in A_tokens]
    b_entries = args.b

    try:
        solution = solve_2x2_system(A_entries, b_entries)
    except np.linalg.LinAlgError as error:
        print(f"Error: {error}", file=sys.stderr)
        sys.exit(1)

    Vx, Vy = solution[0], solution[1]

    if args.plain:
        print(f"{Vx:.{args.precision}f} {Vy:.{args.precision}f}")
        return

    np.set_printoptions(precision=args.precision, suppress=False)

    resistances_matrix = np.asarray(A_entries, dtype=float).reshape(2, 2)
    coefficient_matrix = 1.0 / resistances_matrix
    right_hand_side = np.asarray(b_entries, dtype=float).reshape(
        2,
    )

    residual = coefficient_matrix @ solution - right_hand_side
    determinant = float(np.linalg.det(coefficient_matrix))

    print("R (ohms), provided:")
    print(resistances_matrix)
    print("A = 1/R (conductances, siemens):")
    print(coefficient_matrix)
    print(f"b (currents): {right_hand_side}")
    print(
        f"Solution [Vx, Vy] (volts): [{Vx:.{args.precision}f}, {Vy:.{args.precision}f}]"
    )
    print(f"Residual (Ax - b): {residual}")
    print(f"det(A): {determinant:.{args.precision}g}")


if __name__ == "__main__":
    main()
