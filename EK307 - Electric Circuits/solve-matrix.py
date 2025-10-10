import numpy as np


def solve_3x3_system(A, b):
    """
    Solve a 3x3 linear system Ax = b

    Parameters:
    A: 3x3 coefficient matrix
    b: 3x1 right-hand side vector

    Returns:
    x: solution vector
    """

    # Method 1: Using NumPy's linear algebra solver
    try:
        x_numpy = np.linalg.solve(A, b)
        print("Solution using NumPy:")
        print(f"x = {x_numpy}")
        print(f"Verification: Ax = {np.dot(A, x_numpy)}")
        print(f"Target b = {b}")
        print(f"Error: {np.linalg.norm(np.dot(A, x_numpy) - b):.2e}\n")
        return x_numpy
    except np.linalg.LinAlgError:
        print("Matrix is singular - no unique solution exists")
        return None


def solve_3x3_cramer(A, b):
    """
    Solve 3x3 system using Cramer's rule
    """
    det_A = np.linalg.det(A)

    if abs(det_A) < 1e-10:
        print("Matrix is singular - cannot use Cramer's rule")
        return None

    # Create matrices for Cramer's rule
    A1 = A.copy()
    A1[:, 0] = b  # Replace first column with b

    A2 = A.copy()
    A2[:, 1] = b  # Replace second column with b

    A3 = A.copy()
    A3[:, 2] = b  # Replace third column with b

    x = np.array(
        [
            np.linalg.det(A1) / det_A,
            np.linalg.det(A2) / det_A,
            np.linalg.det(A3) / det_A,
        ]
    )

    print("Solution using Cramer's rule:")
    print(f"x = {x}")
    print(f"Verification: Ax = {np.dot(A, x)}")
    print(f"Error: {np.linalg.norm(np.dot(A, x) - b):.2e}\n")

    return x


def solve_3x3_inverse(A, b):
    """
    Solve 3x3 system using matrix inverse: x = A^(-1) * b
    """
    try:
        A_inv = np.linalg.inv(A)
        x = np.dot(A_inv, b)

        print("Solution using matrix inverse:")
        print(f"x = {x}")
        print(f"Verification: Ax = {np.dot(A, x)}")
        print(f"Error: {np.linalg.norm(np.dot(A, x) - b):.2e}\n")

        return x
    except np.linalg.LinAlgError:
        print("Matrix is singular - inverse does not exist")
        return None


# Example usage
if __name__ == "__main__":
    # Example 1: Well-conditioned system
    print("=" * 50)
    print("EXAMPLE 1: Well-conditioned system")
    print("=" * 50)

    A1 = np.array([[5, 0, -3], [-1, 1, 0], [-10, -5, 19]], dtype=float)

    b1 = np.array([0, 40, 0], dtype=float)

    print("Matrix A:")
    print(A1)
    print(f"Vector b: {b1}")
    print()

    # Solve using different methods
    x1 = solve_3x3_system(A1, b1)
    x2 = solve_3x3_cramer(A1, b1)
    x3 = solve_3x3_inverse(A1, b1)
