from sympy import symbols, Matrix, pprint

# Define the symbol p
p = symbols('p')

# Construct the augmented matrix [A | b]
augmented_matrix = Matrix([
    [3, 0, 1, 5],
    [-5, 1, 1, -2],
    [8, -1, 0, 7],
    [-1, -2, 0, 11]
])

# Compute the RREF of the augmented matrix
rref_matrix, pivots = augmented_matrix.rref(simplify=True)

# Display the RREF
print("Reduced Row Echelon Form (RREF):")
pprint(rref_matrix)

# Check consistency: Ensure no row of the form [0 0 0 | c] (c ≠ 0)
# If consistent, extract the solution
if rref_matrix[3, 3] != 0 and rref_matrix.row(3)[:-1] == [0, 0, 0]:
    print("\nSystem is inconsistent for this value of p.")
else:
    print("\nConsistent system. Solution:")
    x1 = rref_matrix[0, 3]
    x2 = rref_matrix[1, 3]
    x3 = rref_matrix[2, 3]
    print(f"x1 = {x1}")
    print(f"x2 = {x2}")
    print(f"x3 = {x3}")