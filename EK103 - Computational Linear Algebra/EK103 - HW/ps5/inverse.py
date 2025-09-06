import numpy as np

def inverse_matrix(matrix):
    try:
        inv_matrix = np.linalg.inv(matrix)
        return inv_matrix
    except np.linalg.LinAlgError:
        return "The matrix is singular and cannot be inverted."

if __name__ == "__main__":
    # Example usage
    matrix = np.array([[1,0,2], [2,-1 ,3],[4,1,8]])
    print("Original matrix:")
    print(matrix)
    
    result = inverse_matrix(matrix)
    print("Inverse of the matrix:")
    print(result)
