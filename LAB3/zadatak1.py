import argparse

from collections import defaultdict
from dataclasses import dataclass
from typing import DefaultDict


class MatrixMultiplicationError(Exception):
    def __init__(self):
        super().__init__("Column and row number mismatch")


class InvalidMatrixFormatting(Exception):
    def __init__(self):
        super().__init__("Invalid matrix formatting")


class InvalidMatrixCount(Exception):
    def __init__(self):
        super().__init__("Invalid matrix count")


@dataclass
class Matrix:
    row_count: int
    column_count: int
    elements: DefaultDict


def print_matrix(matrix_name: str, matrix: Matrix) -> None:
    print("{}:".format(matrix_name))
    for i in range(matrix.row_count):
        row_text = []
        for j in range(matrix.column_count):
            row_text.append("{:6.2f}".format(matrix.elements[(i, j)]))

        print(" ".join(row_text))

    print()


def multiply_matrices(matrix_1: Matrix, matrix_2: Matrix) -> Matrix:
    if matrix_1.column_count != matrix_2.row_count:
        raise MatrixMultiplicationError()

    output_matrix_elements = defaultdict(lambda: 0)

    for i in range(matrix_1.row_count):
        for j in range(matrix_2.column_count):
            for k in range(matrix_2.row_count):
                output_matrix_elements[(i, j)] += matrix_1.elements[(i, k)] * matrix_2.elements[(k, j)]

    return Matrix(matrix_1.row_count, matrix_2.column_count, output_matrix_elements)


def write_matrix_to_file(matrix: Matrix, file_path: str) -> None:
    with open(file_path, "w") as file:
        file.write("{} {}\n".format(matrix.row_count, matrix.column_count))

        for i in range(matrix.row_count):
            for j in range(matrix.column_count):
                element = matrix.elements[(i, j)]
                if element != 0:
                    file.write("{} {} {:.2f}\n".format(i, j, element))


def read_matrices_from_file(file_path: str):
    with open(file_path, "r") as file:
        first_line = True
        elements = defaultdict(lambda: 0)

        for line_count, line in enumerate(file, start=1):
            line = line.strip()

            if not line:
                yield Matrix(m, n, elements)
                first_line = True
                elements = defaultdict(lambda: 0)
                continue

            if first_line:
                m, n = line.split(" ")
                m = int(m)
                n = int(n)
                first_line = False
                continue

            if len(line.split(" ")) != 3:
                raise InvalidMatrixFormatting()

            row_index, column_index, element = line.split(" ")
            row_index = int(row_index)
            column_index = int(column_index)
            element = int(element)

            if row_index >= m or column_index >= n:
                raise InvalidMatrixFormatting()

            elements[(row_index, column_index)] = element

        yield Matrix(m, n, elements)


def load_args() -> (str, str):
    parser = argparse.ArgumentParser()

    input_file_arg = "input_file"
    output_file_arg = "output_file"

    parser.add_argument(input_file_arg)
    parser.add_argument(output_file_arg)

    args = parser.parse_args()

    input_file = getattr(args, input_file_arg, "")
    output_file = getattr(args, output_file_arg, "")

    return input_file, output_file


def main():
    input_file, output_file = load_args()

    matrices = [matrix for matrix in read_matrices_from_file(input_file)]
    if len(matrices) != 2:
        raise InvalidMatrixCount()

    new_matrix = multiply_matrices(matrices[0], matrices[1])

    print_matrix("A", matrices[0])
    print_matrix("B", matrices[1])
    print_matrix("A*B", new_matrix)

    write_matrix_to_file(new_matrix, output_file)


if __name__ == "__main__":
    main()
