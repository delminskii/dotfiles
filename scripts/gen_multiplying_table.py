#!/usr/bin/env python3

import csv
from pathlib import Path
from random import randint, choice


def main():
    SAMPLES_PER_BEGUNOK, N_BEGUNOKS = 20, 25
    ANSWER_WIDTH = 8
    OUTPUT_FILES_DIR = Path(__file__).parent / "begunoks"
    OUTPUT_FILES_DIR.mkdir(exist_ok=True)

    with (OUTPUT_FILES_DIR / "begunoks.csv").resolve().open(
        "w", newline=str()
    ) as fp:
        writer = csv.writer(fp)
        for i in range(SAMPLES_PER_BEGUNOK):
            row = []
            for j in range(N_BEGUNOKS):
                a, b = randint(2, 10), randint(11, 100)
                row.append(
                    f"{i+1}) {a}×{b}={' '*ANSWER_WIDTH}"
                    if randint(0, 3)
                    else f"{i+1}) {a*b}:{a}={' '*ANSWER_WIDTH}"
                )
            writer.writerow(row)


if __name__ == "__main__":
    main()
