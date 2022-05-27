import argparse

from typing import List


def print_hypotheses(hypotheses: List[List[float]]) -> None:
    print("Hyp#Q10#Q20#Q30#Q40#Q50#Q60#Q70#Q80#Q90")

    for hypothesis_number, hypothesis in enumerate(hypotheses, start=1):
        quantiles = [str(hypothesis[(int(x / 10 * len(hypothesis))) - 1]) for x in range(1, 10)]

        print("{:03d}#{}".format(hypothesis_number, "#".join(quantiles)))


def read_hypotheses_from_file(file_path: str) -> List[List[float]]:
    with open(file_path, "r") as file:
        hypotheses = []

        for line in file:
            hypothesis = sorted(float(x) for x in line.strip().split(" "))
            hypotheses.append(hypothesis)

    return hypotheses


def load_args() -> str:
    parser = argparse.ArgumentParser()

    hypotheses_file_arg = "hypothesis_file"

    parser.add_argument(hypotheses_file_arg)

    args = parser.parse_args()

    hypotheses_file = getattr(args, hypotheses_file_arg, "")

    return hypotheses_file


def main():
    hypotheses_file = load_args()
    hypotheses = read_hypotheses_from_file(hypotheses_file)
    print_hypotheses(hypotheses)


if __name__ == "__main__":
    main()
