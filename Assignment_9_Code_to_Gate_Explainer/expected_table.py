import csv

rows = [(a, b, a if a > b else b) for a in range(16) for b in range(16)]

with open("expected_table.csv", "w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["a", "b", "c_expected"])
    w.writerows(rows)

print(f"{len(rows)} rows written to expected_table.csv")
print("a=b rows (c equals both):", [r for r in rows if r[0] == r[1]][:3], "...")
