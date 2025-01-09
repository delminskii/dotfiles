#!/usr/bin/env python3

import csv
from pathlib import Path
from random import randint


def main():
    SAMPLES_PER_BEGUNOK, N_BEGUNOKS = 38, 10
    OUTPUT_FILES_DIR = Path(__file__).parent / "begunoks"
    OUTPUT_FILES_DIR.mkdir(exist_ok=True)

    with (OUTPUT_FILES_DIR / "begunoks.csv").resolve().open(
        "w", newline=str()
    ) as fp:
        writer = csv.writer(fp)
        for i in range(SAMPLES_PER_BEGUNOK):
            row = []
            for j in range(N_BEGUNOKS):
                a, b = randint(1, 10), randint(1, 10)
                row.append(
                    f"{i+1}) {a}*{b}=   "
                    if randint(0, 2)
                    else f"{i+1}) {a*b}:{a}=   ",
                )
            writer.writerow(row)


if __name__ == "__main__":
    main()
