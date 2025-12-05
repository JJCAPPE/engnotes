import cmath, math

def phase_deg(z):
    return math.degrees(cmath.phase(z))

# Source: 8 cos(2 t - 40°)  =>  Vs = 8∠-40° (peak)
V = 8 * math.cos(math.radians(-40)) + 8 * math.sin(math.radians(-40)) * 1j

print("V:", V, "abs:", abs(V), "phase:", phase_deg(V))
w = 2

Z1 = 1                          
Z2 = 2                          
ZL = 1j * w * 3                 
ZC = 1 / (1j * w * 0.25)        

# Parallel of ZL and (Z2 + ZC)
Z_parallel = (ZL * (Z2 + ZC)) / (ZL + Z2 + ZC)

print("Z_parallel:", Z_parallel, "abs:", abs(Z_parallel), "phase:", phase_deg(Z_parallel))

Z_total = Z1 + Z_parallel

print("Z_total:", Z_total, "abs:", abs(Z_total), "phase:", phase_deg(Z_total))

I_source = V / Z_total          # source / R1 current (same through R1)

print("I_source:", I_source, "abs:", abs(I_source), "phase:", phase_deg(I_source))

V_R1 = I_source * Z1            # voltage across 1 Ω

print("V_R1:", V_R1, "abs:", abs(V_R1), "phase:", phase_deg(V_R1))

V_par = V - V_R1                # voltage across parallel branch

print("V_par:", V_par, "abs:", abs(V_par), "phase:", phase_deg(V_par))

# Branch currents
I_L = V_par / ZL

print("I_L:", I_L, "abs:", abs(I_L), "phase:", phase_deg(I_L))

I_R2C = V_par / (Z2 + ZC)

print("I_R2C:", I_R2C, "abs:", abs(I_R2C), "phase:", phase_deg(I_R2C))

# Voltages across R2 and C
V_R2 = I_R2C * Z2

print("V_R2:", V_R2, "abs:", abs(V_R2), "phase:", phase_deg(V_R2))

V_C  = I_R2C * ZC

print("V_C:", V_C, "abs:", abs(V_C), "phase:", phase_deg(V_C))

# Average powers (using peak values → factor 1/2)
P_R1 = 0.5 * abs(V_R1)**2 / Z1
P_R2 = 0.5 * abs(V_R2)**2 / Z2
P_L  = 0.0
P_C  = 0.0

print("P_R1 =", P_R1, "W")
print("P_R2 =", P_R2, "W")
print("P_L  =", P_L,  "W")
print("P_C  =", P_C,  "W")
