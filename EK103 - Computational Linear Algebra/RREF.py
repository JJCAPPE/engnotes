import numpy as np
from fractions import Fraction

def print_matrix(matrix, message=""):
    """Print matrix with fractions in a readable format"""
    if message:
        print(message)
    
    for row in matrix:
        print("[", end=" ")
        for i, val in enumerate(row):
            # Convert to fraction for exact representation
            frac = Fraction(val).limit_denominator()
            if i < len(row) - 1:
                print(f"{frac}", end=" ")
            else:
                print(f"{frac}", end="")
        print(" ]")
    print()

def fraction_to_latex(frac):
    """Convert fraction to LaTeX format using \frac{}{} notation"""
    if frac.denominator == 1:
        return str(frac.numerator)
    else:
        return f"\\frac{{{frac.numerator}}}{{{frac.denominator}}}"

def matrix_to_latex(matrix):
    """Convert matrix to LaTeX format with proper fraction formatting"""
    latex = "\\begin{bmatrix}\n"
    for row in matrix:
        for i, val in enumerate(row):
            frac = Fraction(val).limit_denominator()
            latex += f"\t{fraction_to_latex(frac)}"
            if i < len(row) - 1:
                latex += " & "
        latex += " \\\\\n"
    latex += "\\end{bmatrix}"
    return latex

def format_operation(op_type, details):
    """Format operation for LaTeX with proper fraction formatting"""
    if op_type == "swap":
        i, j = details
        return f"R_{i+1} \\leftrightarrow R_{j+1}"
    elif op_type == "scale":
        i, factor = details
        frac = Fraction(factor).limit_denominator()
        return f"R_{i+1} = {fraction_to_latex(frac)} R_{i+1}"
    elif op_type == "eliminate":
        i, j, factor = details
        frac = Fraction(factor).limit_denominator()
        if frac < 0:
            # Handle negative factors more clearly
            return f"R_{i+1} = R_{i+1} + {fraction_to_latex(abs(frac))} R_{j+1}"
        else:
            return f"R_{i+1} = R_{i+1} - {fraction_to_latex(frac)} R_{j+1}"
    return ""

def row_echelon_form(matrix, show_steps=True, collect_latex=False):
    """Convert a matrix to Row Echelon Form (REF) with step-by-step output"""
    A = np.array(matrix, dtype=float)
    m, n = A.shape
    
    if show_steps:
        print_matrix(A, "Starting matrix:")
    
    # For LaTeX output
    latex_steps = []
    if collect_latex:
        latex_steps.append(matrix_to_latex(A))
    
    # Keep track of operations for demonstration
    h = 0  # Row index
    k = 0  # Column index
    
    while h < m and k < n:
        # Find the pivot in this column
        pivot_row = -1
        for i in range(h, m):
            if abs(A[i, k]) > 1e-10:  # Non-zero element
                pivot_row = i
                break
        
        if pivot_row == -1:
            # No pivot in this column, move to next column
            k += 1
            continue
        
        # Swap rows if needed
        if pivot_row != h:
            A[[h, pivot_row]] = A[[pivot_row, h]]
            if show_steps:
                print_matrix(A, f"R_{h+1} <-> R_{pivot_row+1}")
            if collect_latex:
                latex_steps.append(format_operation("swap", (h, pivot_row)))
                latex_steps.append(matrix_to_latex(A))
        
        # Scale the pivot row
        pivot = A[h, k]
        if abs(pivot - 1.0) > 1e-10:  # If pivot is not 1
            A[h] = A[h] / pivot
            if show_steps:
                print_matrix(A, f"R_{h+1} = R_{h+1} / {Fraction(pivot).limit_denominator()}")
            if collect_latex:
                latex_steps.append(format_operation("scale", (h, 1/pivot)))
                latex_steps.append(matrix_to_latex(A))
        
        # Eliminate below
        for i in range(h + 1, m):
            factor = A[i, k]
            if abs(factor) > 1e-10:  # Non-zero factor
                A[i] = A[i] - factor * A[h]
                if show_steps:
                    print_matrix(A, f"R_{i+1} = R_{i+1} - {Fraction(factor).limit_denominator()} * R_{h+1}")
                if collect_latex:
                    latex_steps.append(format_operation("eliminate", (i, h, factor)))
                    latex_steps.append(matrix_to_latex(A))
        
        h += 1
        k += 1
    
    if collect_latex:
        return A, latex_steps
    return A

def reduced_row_echelon_form(matrix, show_steps=True, collect_latex=False):
    """Convert a matrix to Reduced Row Echelon Form (RREF) with step-by-step output"""
    # First get to REF
    if collect_latex:
        A, latex_steps = row_echelon_form(matrix, show_steps, collect_latex)
    else:
        A = row_echelon_form(matrix, show_steps)
        latex_steps = []
    
    m, n = A.shape
    
    # Find pivot positions
    pivot_positions = []
    for i in range(m):
        # Skip zero rows
        if np.all(abs(A[i]) < 1e-10):
            continue
        
        # Find the first non-zero element in the row
        for j in range(n):
            if abs(A[i, j] - 1.0) < 1e-10:  # Found a pivot (value = 1)
                pivot_positions.append((i, j))
                break
    
    # Back-substitution to get zeros above pivots
    for row_idx, col_idx in reversed(pivot_positions):
        # Eliminate above
        for i in range(row_idx):
            factor = A[i, col_idx]
            if abs(factor) > 1e-10:  # Non-zero factor
                A[i] = A[i] - factor * A[row_idx]
                if show_steps:
                    print_matrix(A, f"R_{i+1} = R_{i+1} - {Fraction(factor).limit_denominator()} * R_{row_idx+1}")
                if collect_latex:
                    latex_steps.append(format_operation("eliminate", (i, row_idx, factor)))
                    latex_steps.append(matrix_to_latex(A))
    
    if collect_latex:
        return A, latex_steps
    return A

def generate_latex_output(steps):
    """Generate LaTeX output from the collected steps"""
    if len(steps) < 2:
        return "\\[\n" + steps[0] + "\n\\]"
    
    latex = "\\[\n"
    latex += steps[0]
    
    for i in range(1, len(steps), 2):
        if i+1 < len(steps):
            latex += f"\n\\xrightarrow{{{steps[i]}}}\n"
            latex += steps[i+1]
    
    latex += "\n\\]"
    return latex

# Define the matrix
matrix = [
    [3, 2, 5, -5],
    [0, 4, -2, 8],
    [2, 0, 4, -6]
]

# Get REF with LaTeX steps
ref_matrix, ref_latex_steps = row_echelon_form(matrix, show_steps=True, collect_latex=True)
print("\nFinal REF:")
print_matrix(ref_matrix)

# Get RREF with LaTeX steps (starting from the original matrix)
rref_matrix, rref_latex_steps = reduced_row_echelon_form(matrix, show_steps=True, collect_latex=True)
print("\nFinal RREF:")
print_matrix(rref_matrix)

# Generate and print LaTeX output for REF
print("\nLaTeX for REF:")
print(generate_latex_output(ref_latex_steps))

# Generate and print LaTeX output for RREF
print("\nLaTeX for RREF:")
print(generate_latex_output(rref_latex_steps))