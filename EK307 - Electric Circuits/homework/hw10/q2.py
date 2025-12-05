import cmath
import math

def phase_deg(z: complex) -> float:
    return math.degrees(cmath.phase(z))

# Source and element values
Vs = 165.0  # 165∠0° V
Z4 = 4.0          # 4 Ω resistor
Zc = -3j          # -j3 Ω capacitor
Zl = 2j           # j2 Ω inductor
Z5 = 5.0          # 5 Ω resistor

# -----------------------------
# 1) Thevenin impedance Z_th
# -----------------------------
# Seen from Z_L terminals with source killed (voltage source -> short)
# Z_th = 4 || [ -j3 + (5 || j2) ]

Z5_par_Zl = Z5 * Zl / (Z5 + Zl)
Z_series = Zc + Z5_par_Zl
Zth = 1 / (1/Z4 + 1/Z_series)

print("Z_th =", Zth,
      "|Z_th| =", abs(Zth),
      "∠Z_th =", phase_deg(Zth), "deg")

Rth = Zth.real
Xth = Zth.imag

# Optimum load for max power:
ZL_opt = Zth.conjugate()
print("Z_L (for max power) = Z_th* =", ZL_opt)

# -----------------------------
# 2) Thevenin voltage V_th
# -----------------------------
# Open-circuit at Z_L, so we just solve for node voltage at B.
# Nodes: A (source node) is fixed at Vs, unknowns: VB (load node), VC (right-top node)

VA = Vs + 0j

# Nodal equations with Z_L open:
# (VB - VA)/4 + (VB - VC)/Zc = 0
# (VC - VA)/Zl + (VC - VB)/Zc + VC/Z5 = 0

a11 = 1/Z4 + 1/Zc
a12 = -1/Zc
a21 = -1/Zc
a22 = 1/Zl + 1/Zc + 1/Z5

b1 = VA / Z4
b2 = VA / Zl

det = a11 * a22 - a12 * a21
VB = (b1 * a22 - b2 * a12) / det   # This is V_th
Vth = VB

print("V_th =", Vth,
      "|V_th| =", abs(Vth),
      "∠V_th =", phase_deg(Vth), "deg")

# -----------------------------
# 3) Maximum power to Z_L
# -----------------------------
# For Z_L = Z_th*:
# P_max = |V_th|^2 / (4 * R_th)

Pmax = abs(Vth)**2 / (4 * Rth)

print("R_th =", Rth, "X_th =", Xth)
print("P_max (to Z_L) =", Pmax, "watts")
