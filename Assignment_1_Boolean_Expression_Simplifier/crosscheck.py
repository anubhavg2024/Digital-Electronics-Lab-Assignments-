from sympy import symbols
from sympy.logic.boolalg import SOPform, POSform

A, B, C, D, E = symbols('A B C D E')
minterms = [0, 1, 4, 5, 16, 17, 20, 21, 26, 27, 30, 31]

print("SOP:", SOPform([A, B, C, D, E], minterms))
print("POS:", POSform([A, B, C, D, E], minterms))
