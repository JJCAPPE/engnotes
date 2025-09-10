#import "../jsk-lecnotes/lib.typ": *
#import "@preview/cetz:0.3.1": canvas, draw

#show: template.with(
  title: [EK307: Circuits],
  short_title: "EK307",
  description: [
    Lecture notes for Circuits (EK307)
  ],
  date: datetime.today(),
  authors: (
    (
      name: "Giacomo Cappelletto",
    ),
  ),

  bibliography_file: none,
  paper_size: "a4",
  cols: 1,
  text_font: "STIX Two Text",
  code_font: "DejaVu Sans Mono",
  accent: "#DC143C",
  h1-prefix: "Chapter",
  colortab: false,
)

= Current, Voltage, Charge and Power

== Variables and Fundamental Quantities

#definition("Electric Charge")[
  Charge is a fundamental property of matter that determines electromagnetic interaction. It comes in two types (positive and negative) and is conserved in all physical processes. Important facts:

  - Unit: coulomb (C). The elementary charge carried by an electron has magnitude $e = 1.602 times 10^(-19) "C"$.
  - Conservation of charge: In any isolated system, the algebraic sum of charge remains constant.
]

#definition("Electric Current")[
  Current measures the rate at which charge flows past a reference point in a circuit:
  $ i(t) = (d q(t))/(d t) $
  where $q(t)$ is the algebraic charge that has crossed the reference. Key points:

  - Unit: ampere (A) with $1 "A" = 1 "C/s"$.
  - Current direction follows the _conventional_ positive-charge flow from higher to lower potential; electron flow is opposite.
  - If a reference direction is chosen, a negative value of $i(t)$ indicates actual flow opposite to that reference.
]

#definition("Transferred Charge over an Interval")[
  The algebraic charge transferred between $t_0$ and $t$ is
  $ q(t) - q(t_0) = integral_(t_0)^t i(tau) d tau $
  and, equivalently, $i(t) = (d q(t))/(d t)$.
]

#note("DC vs AC Current")[
  DC (direct current) means the current maintains one direction over time (its sign does not change). AC (alternating current) changes direction periodically.
]

#example("From q(t) to i(t)")[
  Suppose the transferred charge is piecewise linear (in μC)
  $
    q(t) = cases(
      0 & "if" t < 0,
      30 t & "if" 0 <= t < 1,
      30 - 30 (t - 1) & "if" 1 <= t < 2,
      -30 + 15 (t - 2) & "if" 2 <= t < 4,
      0 & "if" t >= 4
    )
  $
  with $t$ in seconds. Find $i(t)$ and comment on current direction.

  *Solution:*
  Differentiate $q(t)$ on each interval (and convert to amperes by μC/s = μA):
  $
    i(t) = cases(
      0 & "if" t < 0,
      30 mu"A" & "if" 0 <= t < 1,
      -30 mu"A" & "if" 1 <= t < 2,
      15 mu"A" & "if" 2 <= t < 4,
      0 & "if" t >= 4
    )
  $
  Intervals with negative slope give negative current, meaning actual flow opposite to the chosen reference direction during $1 <= t < 2$.
]

#figure(
  canvas(length: 2cm, {
    import draw: *

    // Charge function q(t) plot with proper scaling
    let width = 5
    let height = 3

    // Draw axes
    line((0, 0), (width, 0), stroke: 1pt + black, name: "x-axis")
    line((0, -1.5), (0, 1.5), stroke: 1pt + black, name: "y-axis")

    // Axis ticks and labels
    for i in range(0, 6) {
      line((i * width / 5, -0.05), (i * width / 5, 0.05), stroke: 0.8pt)
      content((i * width / 5, -0.2), text(9pt)[#str(i)])
    }

    // Y-axis ticks (for μC values: -30, 0, 30)
    line((-0.05, -1.5), (0.05, -1.5), stroke: 0.8pt)
    content((-0.3, -1.5), text(9pt)[-30])
    line((-0.05, 0), (0.05, 0), stroke: 0.8pt)
    content((-0.3, 0), text(9pt)[0])
    line((-0.05, 1.5), (0.05, 1.5), stroke: 0.8pt)
    content((-0.3, 1.5), text(9pt)[30])

    // Plot q(t) piecewise function (scaling: 30μC = 1.5 units)
    line((0, 0), (width / 5, 1.5), stroke: 2pt + blue) // 0 to 30 over t=0 to 1
    line((width / 5, 1.5), (2 * width / 5, 0), stroke: 2pt + blue) // 30 to 0 over t=1 to 2
    line((2 * width / 5, 0), (4 * width / 5, -1.5), stroke: 2pt + blue) // 0 to -30 over t=2 to 4
    line((4 * width / 5, -1.5), (width, -1.5), stroke: 2pt + blue) // flat at -30

    // Add transition points
    circle((0, 0), radius: 0.04, fill: blue)
    circle((width / 5, 1.5), radius: 0.04, fill: blue)
    circle((2 * width / 5, 0), radius: 0.04, fill: blue)
    circle((4 * width / 5, -1.5), radius: 0.04, fill: blue)

    // Axis labels
    content((width / 2, -0.5), text(11pt)[*t* (s)])
    content((-0.8, 0.8), text(11pt)[*q(t)* (μC)])
  }),
  caption: [Piecewise linear charge function q(t)],
) <charge-plot>

#figure(
  canvas(length: 2cm, {
    import draw: *

    // Current function i(t) plot with proper scaling
    let width = 5
    let height = 3

    // Draw axes
    line((0, 0), (width, 0), stroke: 1pt + black, name: "x-axis")
    line((0, -1.5), (0, 1.5), stroke: 1pt + black, name: "y-axis")

    // Axis ticks and labels
    for i in range(0, 6) {
      line((i * width / 5, -0.05), (i * width / 5, 0.05), stroke: 0.8pt)
      content((i * width / 5, -0.2), text(9pt)[#str(i)])
    }

    // Y-axis ticks (for μA values: -30, -15, 0, 15, 30)
    line((-0.05, -1.5), (0.05, -1.5), stroke: 0.8pt)
    content((-0.35, -1.5), text(9pt)[-30])
    line((-0.05, -0.75), (0.05, -0.75), stroke: 0.8pt)
    content((-0.35, -0.75), text(9pt)[-15])
    line((-0.05, 0), (0.05, 0), stroke: 0.8pt)
    content((-0.3, 0), text(9pt)[0])
    line((-0.05, 0.75), (0.05, 0.75), stroke: 0.8pt)
    content((-0.35, 0.75), text(9pt)[15])
    line((-0.05, 1.5), (0.05, 1.5), stroke: 0.8pt)
    content((-0.35, 1.5), text(9pt)[30])

    // Plot i(t) piecewise function (scaling: 30μA = 1.5 units)
    // Horizontal segments for each interval
    line((0, 1.5), (width / 5, 1.5), stroke: 2pt + red) // 30μA from t=0 to 1
    line((width / 5, -1.5), (2 * width / 5, -1.5), stroke: 2pt + red) // -30μA from t=1 to 2
    line((2 * width / 5, 0.75), (4 * width / 5, 0.75), stroke: 2pt + red) // 15μA from t=2 to 4
    line((4 * width / 5, 0), (width, 0), stroke: 2pt + red) // 0μA from t=4 onwards

    // Vertical transitions (dashed lines showing discontinuities)
    line((0, 0), (0, 1.5), stroke: (dash: "dashed", paint: red, thickness: 1pt))
    line((width / 5, 1.5), (width / 5, -1.5), stroke: (dash: "dashed", paint: red, thickness: 1pt))
    line((2 * width / 5, -1.5), (2 * width / 5, 0.75), stroke: (dash: "dashed", paint: red, thickness: 1pt))
    line((4 * width / 5, 0.75), (4 * width / 5, 0), stroke: (dash: "dashed", paint: red, thickness: 1pt))

    // Add filled circles at start points, empty at end points for step function
    circle((0, 1.5), radius: 0.04, fill: red)
    circle((width / 5, 1.5), radius: 0.04, stroke: red + 1pt, fill: white)
    circle((width / 5, -1.5), radius: 0.04, fill: red)
    circle((2 * width / 5, -1.5), radius: 0.04, stroke: red + 1pt, fill: white)
    circle((2 * width / 5, 0.75), radius: 0.04, fill: red)
    circle((4 * width / 5, 0.75), radius: 0.04, stroke: red + 1pt, fill: white)
    circle((4 * width / 5, 0), radius: 0.04, fill: red)

    // Axis labels
    content((width / 2, -0.5), text(11pt)[*t* (s)])
    content((-0.8, 0.8), text(11pt)[*i(t)* (μA)])
  }),
  caption: [Piecewise constant current function i(t) = dq/dt],
) <current-plot>

== Voltage (Potential Difference)

#definition("Voltage")[
  Voltage is the change in potential energy per unit charge between two points:
  $ v(t) = (d w)/(d q), quad 1 "V" = 1 "J/C" $
  Properties and usage:

  - Voltage is always measured _between_ two points and is a relative quantity; a reference point ("ground") is often chosen to report node voltages.
  - A "voltage drop" is the potential decrease across an element following a specified reference polarity.
]

== Resistance and Conductance

#definition("Resistance and Ohm's Law")[
  Resistance models opposition to the flow of charge. For an ohmic element,
  $ v = i R quad "or" quad i = G v $
  where $R$ is resistance in ohms (Ω) and $G = 1/R$ is conductance in siemens (S). In the $i$–$v$ plane the slope is $(d i)/(d v) = G$ (a straight line through the origin for an ideal resistor).
]

== Power and Energy

#definition("Instantaneous Power")[
  Electrical power is the rate of change of energy with respect to time:
  $ p(t) = (d w)/(d t) = (d w)/(d q) (d q)/(d t) = v(t) i(t) $
  For a resistor using Ohm's law,
  $ #iboxed($p = v i = i^2 R = v^2/R$) $
  Under the passive sign convention, $p > 0$ indicates the element absorbs power, while $p < 0$ indicates it delivers power.
]

#definition("Passive Sign Convention")[
  By conservation of energy, the power absorbed by all elements in a system is equal to the power delivered by the other elements. Therefore
  $$sum_i^n p_i = 0$$
]

== Circuit Elements

Circuit elements are the building blocks of electrical circuits. They fall into two main categories:

#definition("Passive Elements")[
  Passive elements can only absorb or store energy - they cannot generate energy. Examples include:

  - *Resistors*: Convert electrical energy to heat (always absorb power)
  - *Capacitors*: Store energy in electric fields
  - *Inductors*: Store energy in magnetic fields

  Under the passive sign convention, passive elements have $p ≥ 0$ when current enters the positive terminal.
]

#definition("Active Elements")[
  Active elements can supply energy to a circuit. The primary active elements are:

  - *Voltage Sources*: Maintain a specified voltage across their terminals
  - *Current Sources*: Maintain a specified current through them

  Active elements can have $p < 0$ (delivering power) under the passive sign convention.
]

== Independent Sources

Independent sources provide a specified voltage or current that does not depend on other circuit variables.

=== Voltage Sources

#figure(
  canvas(length: 1.2cm, {
    import draw: *

    // Ideal voltage source
    let vs_pos = (0, 1)
    circle(vs_pos, radius: 0.4, stroke: 2.5pt + black)
    content(vs_pos, text(10pt)[*V*])
    content((vs_pos.at(0) - 0.2, vs_pos.at(1)), text(9pt)[*+*])
    content((vs_pos.at(0) + 0.2, vs_pos.at(1)), text(9pt)[*-*])
    line((-0.8, vs_pos.at(1)), (vs_pos.at(0) - 0.4, vs_pos.at(1)), stroke: 2.5pt + black)
    line((vs_pos.at(0) + 0.4, vs_pos.at(1)), (0.8, vs_pos.at(1)), stroke: 2.5pt + black)
    content((0, 0.2), text(11pt)[*Ideal*])

    // Real voltage source
    let real_vs_pos = (3, 1)
    circle(real_vs_pos, radius: 0.4, stroke: 2.5pt + black)
    content(real_vs_pos, text(10pt)[*V*])
    content((real_vs_pos.at(0) - 0.2, real_vs_pos.at(1)), text(9pt)[*+*])
    content((real_vs_pos.at(0) + 0.2, real_vs_pos.at(1)), text(9pt)[*-*])

    // Internal resistance
    let r_zigzag = (
      (real_vs_pos.at(0) + 0.5, real_vs_pos.at(1)),
      (real_vs_pos.at(0) + 0.7, real_vs_pos.at(1) + 0.1),
      (real_vs_pos.at(0) + 0.9, real_vs_pos.at(1) - 0.1),
      (real_vs_pos.at(0) + 1.1, real_vs_pos.at(1)),
    )
    for i in range(r_zigzag.len() - 1) {
      line(r_zigzag.at(i), r_zigzag.at(i + 1), stroke: 2pt + black)
    }
    content((real_vs_pos.at(0) + 0.8, real_vs_pos.at(1) + 0.3), text(8pt)[*R*])

    line((2.2, real_vs_pos.at(1)), (real_vs_pos.at(0) - 0.4, real_vs_pos.at(1)), stroke: 2.5pt + black)
    line((real_vs_pos.at(0) + 1.1, real_vs_pos.at(1)), (3.8, real_vs_pos.at(1)), stroke: 2.5pt + black)
    content((3, 0.2), text(11pt)[*Real*])
  }),
  caption: [Ideal vs Real Voltage Sources],
) <voltage-sources>

#definition("Ideal Voltage Source")[
  An ideal voltage source maintains a constant voltage $V_s$ across its terminals regardless of the current flowing through it. Key properties:

  - Terminal voltage is always $V_s$ (independent of current)
  - Can supply unlimited current if needed
  - Internal resistance $R_s = 0$
  - *Open circuit*: $V = V_s$, $I = 0$
  - *Short circuit*: $V = 0$, $I = ∞$ (not physically realizable)
]

#definition("Real Voltage Source")[
  A real voltage source has internal resistance $R_s$ in series with an ideal voltage source. Properties:

  - Terminal voltage: $V = V_s - I R_s$
  - *Open circuit*: $V = V_s$, $I = 0$
  - *Short circuit*: $V = 0$, $I = V_s/R_s$
  - Maximum power transfer occurs when load resistance equals $R_s$
]

=== Current Sources

#figure(
  canvas(length: 1.2cm, {
    import draw: *

    // Ideal current source
    let is_pos = (0, 1)
    circle(is_pos, radius: 0.4, stroke: 2.5pt + black)
    content(is_pos, text(10pt)[*I*])
    line((-0.8, is_pos.at(1)), (is_pos.at(0) - 0.4, is_pos.at(1)), stroke: 2.5pt + black)
    line((is_pos.at(0) + 0.4, is_pos.at(1)), (0.8, is_pos.at(1)), stroke: 2.5pt + black)
    // Current arrow through source
    line((-0.15, is_pos.at(1)), (0.15, is_pos.at(1)), mark: (end: ">", stroke: blue + 1.5pt), stroke: blue + 1.5pt)
    content((0, 0.2), text(11pt)[*Ideal*])

    // Real current source
    let real_is_pos = (3, 1)
    circle(real_is_pos, radius: 0.4, stroke: 2.5pt + black)
    content(real_is_pos, text(10pt)[*I*])

    // Parallel resistance (above the source)
    line(
      (real_is_pos.at(0) - 0.4, real_is_pos.at(1)),
      (real_is_pos.at(0) - 0.4, real_is_pos.at(1) + 0.6),
      stroke: 2pt + black,
    )
    let r_zigzag = (
      (real_is_pos.at(0) - 0.3, real_is_pos.at(1) + 0.6),
      (real_is_pos.at(0) - 0.1, real_is_pos.at(1) + 0.75),
      (real_is_pos.at(0) + 0.1, real_is_pos.at(1) + 0.45),
      (real_is_pos.at(0) + 0.3, real_is_pos.at(1) + 0.6),
    )
    for i in range(r_zigzag.len() - 1) {
      line(r_zigzag.at(i), r_zigzag.at(i + 1), stroke: 2pt + black)
    }
    line(
      (real_is_pos.at(0) + 0.4, real_is_pos.at(1) + 0.6),
      (real_is_pos.at(0) + 0.4, real_is_pos.at(1)),
      stroke: 2pt + black,
    )
    content((real_is_pos.at(0), real_is_pos.at(1) + 0.9), text(8pt)[*R*])

    line((2.2, real_is_pos.at(1)), (real_is_pos.at(0) - 0.4, real_is_pos.at(1)), stroke: 2.5pt + black)
    line((real_is_pos.at(0) + 0.4, real_is_pos.at(1)), (3.8, real_is_pos.at(1)), stroke: 2.5pt + black)
    // Current arrow through source
    line(
      (real_is_pos.at(0) - 0.15, real_is_pos.at(1)),
      (real_is_pos.at(0) + 0.15, real_is_pos.at(1)),
      mark: (end: ">", stroke: blue + 1.5pt),
      stroke: blue + 1.5pt,
    )
    content((3, 0.2), text(11pt)[*Real*])
  }),
  caption: [Ideal vs Real Current Sources],
) <current-sources>

#definition("Ideal Current Source")[
  An ideal current source maintains a constant current $I_s$ through it regardless of the voltage across its terminals. Key properties:

  - Current is always $I_s$ (independent of voltage)
  - Can develop unlimited voltage if needed
  - Internal resistance $R_s = ∞$
  - *Open circuit*: $I = 0$, $V = ∞$ (not physically realizable)
  - *Short circuit*: $I = I_s$, $V = 0$
]

#definition("Real Current Source")[
  A real current source has internal resistance $R_s$ in parallel with an ideal current source. Properties:

  - Terminal current: $I = I_s - V/R_s$
  - *Open circuit*: $I = 0$, $V = I_s R_s$
  - *Short circuit*: $I = I_s$, $V = 0$
  - Norton equivalent circuit representation
]

== Dependent Sources

Dependent (controlled) sources have outputs that depend on other voltages or currents in the circuit. They are essential for modeling active devices like transistors and operational amplifiers.

#figure(
  canvas(length: 1cm, {
    import draw: *

    // VCVS (diamond symbol with +/- polarity)
    let vcvs_pos = (1, 2)
    line((vcvs_pos.at(0) - 0.3, vcvs_pos.at(1)), (vcvs_pos.at(0), vcvs_pos.at(1) + 0.3), stroke: 2.5pt + black)
    line((vcvs_pos.at(0), vcvs_pos.at(1) + 0.3), (vcvs_pos.at(0) + 0.3, vcvs_pos.at(1)), stroke: 2.5pt + black)
    line((vcvs_pos.at(0) + 0.3, vcvs_pos.at(1)), (vcvs_pos.at(0), vcvs_pos.at(1) - 0.3), stroke: 2.5pt + black)
    line((vcvs_pos.at(0), vcvs_pos.at(1) - 0.3), (vcvs_pos.at(0) - 0.3, vcvs_pos.at(1)), stroke: 2.5pt + black)
    // Voltage polarity markings
    content((vcvs_pos.at(0) - 0.15, vcvs_pos.at(1)), text(10pt, fill: red)[*+*])
    content((vcvs_pos.at(0) + 0.15, vcvs_pos.at(1)), text(10pt, fill: red)[*-*])
    content((vcvs_pos.at(0), vcvs_pos.at(1) + 0.4), text(8pt)[*μv*])
    content((vcvs_pos.at(0), vcvs_pos.at(1) - 0.6), text(9pt)[*VCVS*])

    // CCCS (diamond symbol with current arrow)
    let cccs_pos = (3.5, 2)
    line((cccs_pos.at(0) - 0.3, cccs_pos.at(1)), (cccs_pos.at(0), cccs_pos.at(1) + 0.3), stroke: 2.5pt + black)
    line((cccs_pos.at(0), cccs_pos.at(1) + 0.3), (cccs_pos.at(0) + 0.3, cccs_pos.at(1)), stroke: 2.5pt + black)
    line((cccs_pos.at(0) + 0.3, cccs_pos.at(1)), (cccs_pos.at(0), cccs_pos.at(1) - 0.3), stroke: 2.5pt + black)
    line((cccs_pos.at(0), cccs_pos.at(1) - 0.3), (cccs_pos.at(0) - 0.3, cccs_pos.at(1)), stroke: 2.5pt + black)
    // Current arrow
    line(
      (cccs_pos.at(0) - 0.15, cccs_pos.at(1)),
      (cccs_pos.at(0) + 0.15, cccs_pos.at(1)),
      mark: (end: ">", stroke: blue + 2pt),
      stroke: blue + 2pt,
    )
    content((cccs_pos.at(0), cccs_pos.at(1) + 0.4), text(8pt)[*βi*])
    content((cccs_pos.at(0), cccs_pos.at(1) - 0.6), text(9pt)[*CCCS*])

    // VCCS (diamond symbol with current arrow)
    let vccs_pos = (1, 0.5)
    line((vccs_pos.at(0) - 0.3, vccs_pos.at(1)), (vccs_pos.at(0), vccs_pos.at(1) + 0.3), stroke: 2.5pt + black)
    line((vccs_pos.at(0), vccs_pos.at(1) + 0.3), (vccs_pos.at(0) + 0.3, vccs_pos.at(1)), stroke: 2.5pt + black)
    line((vccs_pos.at(0) + 0.3, vccs_pos.at(1)), (vccs_pos.at(0), vccs_pos.at(1) - 0.3), stroke: 2.5pt + black)
    line((vccs_pos.at(0), vccs_pos.at(1) - 0.3), (vccs_pos.at(0) - 0.3, vccs_pos.at(1)), stroke: 2.5pt + black)
    // Current arrow
    line(
      (vccs_pos.at(0) - 0.15, vccs_pos.at(1)),
      (vccs_pos.at(0) + 0.15, vccs_pos.at(1)),
      mark: (end: ">", stroke: blue + 2pt),
      stroke: blue + 2pt,
    )
    content((vccs_pos.at(0), vccs_pos.at(1) + 0.4), text(8pt)[*gv*])
    content((vccs_pos.at(0), vccs_pos.at(1) - 0.6), text(9pt)[*VCCS*])

    // CCVS (diamond symbol with +/- polarity)
    let ccvs_pos = (3.5, 0.5)
    line((ccvs_pos.at(0) - 0.3, ccvs_pos.at(1)), (ccvs_pos.at(0), ccvs_pos.at(1) + 0.3), stroke: 2.5pt + black)
    line((ccvs_pos.at(0), ccvs_pos.at(1) + 0.3), (ccvs_pos.at(0) + 0.3, ccvs_pos.at(1)), stroke: 2.5pt + black)
    line((ccvs_pos.at(0) + 0.3, ccvs_pos.at(1)), (ccvs_pos.at(0), ccvs_pos.at(1) - 0.3), stroke: 2.5pt + black)
    line((ccvs_pos.at(0), ccvs_pos.at(1) - 0.3), (ccvs_pos.at(0) - 0.3, ccvs_pos.at(1)), stroke: 2.5pt + black)
    // Voltage polarity markings
    content((ccvs_pos.at(0) - 0.15, ccvs_pos.at(1)), text(10pt, fill: red)[*+*])
    content((ccvs_pos.at(0) + 0.15, ccvs_pos.at(1)), text(10pt, fill: red)[*-*])
    content((ccvs_pos.at(0), ccvs_pos.at(1) + 0.4), text(8pt)[*ri*])
    content((ccvs_pos.at(0), ccvs_pos.at(1) - 0.6), text(9pt)[*CCVS*])
  }),
  caption: [Four types of dependent sources (diamond symbols)],
) <dependent-sources>

#definition("Voltage Controlled Voltage Source (VCVS)")[
  Output voltage depends on a controlling voltage elsewhere in the circuit:
  $ v_"out" = μ v_"control" $
  where $μ$ is the voltage gain (dimensionless). Used to model voltage amplifiers.
]

#definition("Current Controlled Current Source (CCCS)")[
  Output current depends on a controlling current elsewhere in the circuit:
  $ i_"out" = β i_"control" $
  where $β$ is the current gain (dimensionless). Used to model current amplifiers like BJTs.
]

#definition("Voltage Controlled Current Source (VCCS)")[
  Output current depends on a controlling voltage elsewhere in the circuit:
  $ i_"out" = g v_"control" $
  where $g$ is the transconductance (units: S = A/V). Used to model devices like FETs.
]

#definition("Current Controlled Voltage Source (CCVS)")[
  Output voltage depends on a controlling current elsewhere in the circuit:
  $ v_"out" = r i_"control" $
  where $r$ is the transresistance (units: Ω = V/A). Less commonly used in practice.
]

#example("Power Calculation with Dependent Sources")[
  Consider a circuit with a CCCS where $β = 0.6$ and the controlling current is $i_"control" = 3"A"$.

  If the dependent source has 5V across its terminals:
  - Output current: $i_"out" = β i_"control" = 0.6 × 3"A" = 1.8"A"$
  - Power delivered: $p = v i = 5"V" × 1.8"A" = 9"W"$

  This demonstrates that dependent sources can deliver power to a circuit, making them active elements.
]

== Understanding the Passive Sign Convention

The passive sign convention (PSC) is crucial for determining whether a circuit element absorbs or delivers power. The key insight is that *both current direction and voltage polarity are reference choices* - we can choose them arbitrarily, but the power calculation depends on how we choose them relative to each other.

#figure(
  grid(
    columns: 2,
    column-gutter: 2em,
    row-gutter: 1.5em,

    // Case a: i right, +v left (PSC satisfied)
    [*a.* #canvas(length: 0.8cm, {
        import draw: *

        // Clean resistor symbol
        let zigzag = ((0, 0), (0.2, 0.15), (0.4, -0.15), (0.6, 0.15), (0.8, -0.15), (1, 0))
        for i in range(zigzag.len() - 1) { line(zigzag.at(i), zigzag.at(i + 1), stroke: 2.5pt + black) }

        // Connecting wires
        line((-0.4, 0), (0, 0), stroke: 2.5pt + black)
        line((1, 0), (1.4, 0), stroke: 2.5pt + black)

        // Current arrow (right direction)
        line((-0.3, 0.05), (-0.15, 0.05), mark: (end: ">", stroke: blue + 2pt), stroke: blue + 2pt)
        content((-0.22, 0.25), text(11pt, fill: blue)[*i*])

        // Voltage polarity (+v left)
        content((-0.05, 0.25), text(11pt, fill: red)[*+*])
        content((0.5, 0.35), text(11pt, fill: red)[*v*])
        content((1.05, 0.25), text(11pt, fill: red)[*-*])
      })],

    // Case b: i right, +v right (PSC not satisfied)
    [*b.* #canvas(length: 0.8cm, {
        import draw: *

        // Clean resistor symbol
        let zigzag = ((0, 0), (0.2, 0.15), (0.4, -0.15), (0.6, 0.15), (0.8, -0.15), (1, 0))
        for i in range(zigzag.len() - 1) { line(zigzag.at(i), zigzag.at(i + 1), stroke: 2.5pt + black) }

        // Connecting wires
        line((-0.4, 0), (0, 0), stroke: 2.5pt + black)
        line((1, 0), (1.4, 0), stroke: 2.5pt + black)

        // Current arrow (right direction)
        line((-0.3, 0.05), (-0.15, 0.05), mark: (end: ">", stroke: blue + 2pt), stroke: blue + 2pt)
        content((-0.22, 0.25), text(11pt, fill: blue)[*i*])

        // Voltage polarity (+v right)
        content((-0.05, 0.25), text(11pt, fill: red)[*-*])
        content((0.5, 0.35), text(11pt, fill: red)[*v*])
        content((1.05, 0.25), text(11pt, fill: red)[*+*])
      })],

    // Case c: i left, +v left (PSC not satisfied)
    [*c.* #canvas(length: 0.8cm, {
        import draw: *

        // Clean resistor symbol
        let zigzag = ((0, 0), (0.2, 0.15), (0.4, -0.15), (0.6, 0.15), (0.8, -0.15), (1, 0))
        for i in range(zigzag.len() - 1) { line(zigzag.at(i), zigzag.at(i + 1), stroke: 2.5pt + black) }

        // Connecting wires
        line((-0.4, 0), (0, 0), stroke: 2.5pt + black)
        line((1, 0), (1.4, 0), stroke: 2.5pt + black)

        // Current arrow (left direction)
        line((1.3, 0.05), (1.15, 0.05), mark: (end: ">", stroke: blue + 2pt), stroke: blue + 2pt)
        content((1.22, 0.25), text(11pt, fill: blue)[*i*])

        // Voltage polarity (+v left)
        content((-0.05, 0.25), text(11pt, fill: red)[*+*])
        content((0.5, 0.35), text(11pt, fill: red)[*v*])
        content((1.05, 0.25), text(11pt, fill: red)[*-*])
      })],

    // Case d: i left, +v right (PSC satisfied)
    [*d.* #canvas(length: 0.8cm, {
        import draw: *

        // Clean resistor symbol
        let zigzag = ((0, 0), (0.2, 0.15), (0.4, -0.15), (0.6, 0.15), (0.8, -0.15), (1, 0))
        for i in range(zigzag.len() - 1) { line(zigzag.at(i), zigzag.at(i + 1), stroke: 2.5pt + black) }

        // Connecting wires
        line((-0.4, 0), (0, 0), stroke: 2.5pt + black)
        line((1, 0), (1.4, 0), stroke: 2.5pt + black)

        // Current arrow (left direction)
        line((1.3, 0.05), (1.15, 0.05), mark: (end: ">", stroke: blue + 2pt), stroke: blue + 2pt)
        content((1.22, 0.25), text(11pt, fill: blue)[*i*])

        // Voltage polarity (+v right)
        content((-0.05, 0.25), text(11pt, fill: red)[*-*])
        content((0.5, 0.35), text(11pt, fill: red)[*v*])
        content((1.05, 0.25), text(11pt, fill: red)[*+*])
      })],
  ),
  caption: [Four possible combinations of current direction and voltage polarity references],
) <passive-sign-cases>

#note("Power Calculations for Each Case")[
  The power absorbed by each resistor depends on the relative orientation of current and voltage:

  *Cases a & d (PSC satisfied):* Current enters the positive terminal
  - Power: $p = +v i$ (positive = absorbing power)

  *Cases b & c (PSC not satisfied):* Current enters the negative terminal
  - Power: $p = -v i$ (can be positive or negative depending on actual values)

  *Key insight:*
  - If $p > 0$: Element absorbs power (acts like a load)
  - If $p < 0$: Element delivers power (acts like a source)

  The passive sign convention simply provides a consistent framework for determining the sign of power calculations based on our chosen reference directions.
]

#figure(
  canvas(length: 1.2cm, {
    import draw: *

    // Define circuit component positions
    let battery_pos = (0, 1)
    let r1_pos = (2.5, 1)
    let r2_pos = (5, 1)

    // Battery symbol (two parallel lines, different heights)
    line(
      (battery_pos.at(0) - 0.1, battery_pos.at(1) - 0.4),
      (battery_pos.at(0) - 0.1, battery_pos.at(1) + 0.4),
      stroke: 3pt + black,
    )
    line(
      (battery_pos.at(0) + 0.1, battery_pos.at(1) - 0.2),
      (battery_pos.at(0) + 0.1, battery_pos.at(1) + 0.2),
      stroke: 3pt + black,
    )
    content((battery_pos.at(0), battery_pos.at(1) - 0.7), text(11pt)[*12V*])
    content((battery_pos.at(0) - 0.25, battery_pos.at(1)), text(12pt)[*+*])
    content((battery_pos.at(0) + 0.25, battery_pos.at(1)), text(12pt)[*-*])

    // R1: 6Ω resistor with clean zigzag pattern
    let r1_zigzag = (
      (r1_pos.at(0) - 0.4, r1_pos.at(1)),
      (r1_pos.at(0) - 0.2, r1_pos.at(1) + 0.15),
      (r1_pos.at(0), r1_pos.at(1) - 0.15),
      (r1_pos.at(0) + 0.2, r1_pos.at(1) + 0.15),
      (r1_pos.at(0) + 0.4, r1_pos.at(1)),
    )
    for i in range(r1_zigzag.len() - 1) {
      line(r1_zigzag.at(i), r1_zigzag.at(i + 1), stroke: 2.5pt + black)
    }
    content((r1_pos.at(0), r1_pos.at(1) - 0.4), text(10pt)[*6Ω*])

    // Voltage polarity for R1 (+18V)
    content((r1_pos.at(0) - 0.5, r1_pos.at(1) + 0.15), text(9pt, fill: red)[*+*])
    content((r1_pos.at(0) + 0.5, r1_pos.at(1) + 0.15), text(9pt, fill: red)[*-*])
    content((r1_pos.at(0), r1_pos.at(1) + 0.4), text(9pt, fill: red)[*18V*])

    // R2: 2Ω resistor with clean zigzag pattern
    let r2_zigzag = (
      (r2_pos.at(0) - 0.4, r2_pos.at(1)),
      (r2_pos.at(0) - 0.2, r2_pos.at(1) + 0.15),
      (r2_pos.at(0), r2_pos.at(1) - 0.15),
      (r2_pos.at(0) + 0.2, r2_pos.at(1) + 0.15),
      (r2_pos.at(0) + 0.4, r2_pos.at(1)),
    )
    for i in range(r2_zigzag.len() - 1) {
      line(r2_zigzag.at(i), r2_zigzag.at(i + 1), stroke: 2.5pt + black)
    }
    content((r2_pos.at(0), r2_pos.at(1) - 0.4), text(10pt)[*2Ω*])

    // Flipped voltage polarity for R2 (-6V)
    content((r2_pos.at(0) - 0.5, r2_pos.at(1) + 0.15), text(9pt, fill: red)[*-*])
    content((r2_pos.at(0) + 0.5, r2_pos.at(1) + 0.15), text(9pt, fill: red)[*+*])
    content((r2_pos.at(0), r2_pos.at(1) + 0.4), text(9pt, fill: red)[*-6V*])

    // Connecting wires
    line((battery_pos.at(0) + 0.1, battery_pos.at(1)), (r1_pos.at(0) - 0.4, r1_pos.at(1)), stroke: 2.5pt + black)
    line((r1_pos.at(0) + 0.4, r1_pos.at(1)), (r2_pos.at(0) - 0.4, r2_pos.at(1)), stroke: 2.5pt + black)
    line((r2_pos.at(0) + 0.4, r2_pos.at(1)), (7, r2_pos.at(1)), stroke: 2.5pt + black)
    line((7, r2_pos.at(1)), (7, -0.2), stroke: 2.5pt + black)
    line((7, -0.2), (battery_pos.at(0) - 0.1, -0.2), stroke: 2.5pt + black)
    line((battery_pos.at(0) - 0.1, -0.2), (battery_pos.at(0) - 0.1, battery_pos.at(1)), stroke: 2.5pt + black)

    // Current arrow and label
    line((1.2, r1_pos.at(1) + 0.7), (2, r1_pos.at(1) + 0.7), mark: (end: ">", stroke: blue + 2pt), stroke: blue + 2pt)
    content((1.6, r1_pos.at(1) + 0.95), text(11pt, fill: blue)[*I = 3A*])

    // Ground symbol
    line((battery_pos.at(0) - 0.3, -0.2), (battery_pos.at(0) + 0.1, -0.2), stroke: 2.5pt + black)
    line((battery_pos.at(0) - 0.2, -0.3), (battery_pos.at(0), -0.3), stroke: 2.5pt + black)
    line((battery_pos.at(0) - 0.1, -0.4), (battery_pos.at(0) - 0.05, -0.4), stroke: 2.5pt + black)
  }),
  caption: [Series circuit with 12V battery, 6Ω and 2Ω resistors (showing voltage polarity references)],
) <series-circuit>

#note("Passive Sign Convention and Power Balance")[
  This circuit demonstrates the passive sign convention with I = 3A throughout. The devices have the following voltage and power characteristics:

  *Power calculations using passive sign convention:*
  - *12V Battery* (delivers power): $p_"battery" = -v i = -12"V" times 3"A" = -36"W"$
  - *18V Device* (6Ω, absorbs power): $p_1 = +v i = +18"V" times 3"A" = +54"W"$
  - *6V Device* (2Ω, flipped polarity): $p_2 = -v i = -6"V" times 3"A" = -18"W"$

  *Verification of power balance:*
  $ sum p_i = p_"battery" + p_1 + p_2 = -36"W" + 54"W" + (-18"W") = 0"W" $ ✓

  *Key insight*: The flipped polarity on the 6V device means it has a negative power sign in this reference frame, even though it's still physically absorbing power. The algebraic sum of all powers equals zero, confirming energy conservation.

  *Note*: In this idealized circuit, we're treating the devices as having fixed voltage drops at 3A current, demonstrating the passive sign convention rather than pure resistive behavior.
]

= Circuit Topology: Nodes, Branches, and Loops

Understanding circuit topology is essential for analyzing electrical circuits systematically. We need to identify the basic structural elements that define how components are connected.

== Definitions

#definition("Node")[
  A node is a point where two or more circuit elements connect. All points connected by ideal wires (zero resistance) are considered to be at the same node and have the same voltage.
]

#definition("Branch")[
  A branch is a single circuit element or a series combination of elements between two nodes. Current through all elements in a branch is identical.
]

#definition("Loop")[
  A loop is any closed path through the circuit that starts and ends at the same node without passing through any node more than once.
]

== Circuit Topology Examples

The following three diagrams show the same circuit with different aspects highlighted:

#figure(
  canvas(length: 1.2cm, {
    import draw: *

    // Define positions for a more complex circuit
    let node_a = (0, 2)
    let node_b = (3, 2)
    let node_c = (6, 2)
    let node_d = (6, 0)
    let node_e = (3, 0)
    let node_f = (0, 0)

    // Voltage source between nodes f and a
    line(
      (node_a.at(0) - 0.1, node_a.at(1) - 0.3),
      (node_a.at(0) - 0.1, node_a.at(1) + 0.3),
      stroke: 3pt + black,
    )
    line(
      (node_a.at(0) + 0.1, node_a.at(1) - 0.2),
      (node_a.at(0) + 0.1, node_a.at(1) + 0.2),
      stroke: 3pt + black,
    )
    content((node_a.at(0), node_a.at(1) - 0.6), text(9pt)[*12V*])
    content((node_a.at(0) - 0.25, node_a.at(1)), text(10pt)[*+*])
    content((node_a.at(0) + 0.25, node_a.at(1)), text(10pt)[*-*])

    // R1 between nodes a and b (top horizontal)
    let r1_zigzag = (
      (node_a.at(0) + 0.7, node_a.at(1)),
      (node_a.at(0) + 0.9, node_a.at(1) + 0.15),
      (node_a.at(0) + 1.1, node_a.at(1) - 0.15),
      (node_a.at(0) + 1.3, node_a.at(1) + 0.15),
      (node_a.at(0) + 1.5, node_a.at(1)),
    )
    for i in range(r1_zigzag.len() - 1) {
      line(r1_zigzag.at(i), r1_zigzag.at(i + 1), stroke: 2pt + black)
    }
    content((node_a.at(0) + 1.1, node_a.at(1) + 0.4), text(9pt)[*R₁*])
    content((node_a.at(0) + 1.1, node_a.at(1) - 0.4), text(9pt)[*4Ω*])

    // R2 between nodes b and c (top horizontal)
    let r2_zigzag = (
      (node_b.at(0) + 0.7, node_b.at(1)),
      (node_b.at(0) + 0.9, node_b.at(1) + 0.15),
      (node_b.at(0) + 1.1, node_b.at(1) - 0.15),
      (node_b.at(0) + 1.3, node_b.at(1) + 0.15),
      (node_b.at(0) + 1.5, node_b.at(1)),
    )
    for i in range(r2_zigzag.len() - 1) {
      line(r2_zigzag.at(i), r2_zigzag.at(i + 1), stroke: 2pt + black)
    }
    content((node_b.at(0) + 1.1, node_b.at(1) + 0.4), text(9pt)[*R₂*])
    content((node_b.at(0) + 1.1, node_b.at(1) - 0.4), text(9pt)[*2Ω*])

    // R3 between nodes b and e (vertical)
    let r3_zigzag = (
      (node_b.at(0), node_b.at(1) - 0.3),
      (node_b.at(0) - 0.15, node_b.at(1) - 0.5),
      (node_b.at(0) + 0.15, node_b.at(1) - 0.7),
      (node_b.at(0) - 0.15, node_b.at(1) - 0.9),
      (node_b.at(0), node_b.at(1) - 1.1),
    )
    for i in range(r3_zigzag.len() - 1) {
      line(r3_zigzag.at(i), r3_zigzag.at(i + 1), stroke: 2pt + black)
    }
    content((node_b.at(0) + 0.4, node_b.at(1) - 0.7), text(9pt)[*R₃*])
    content((node_b.at(0) + 0.4, node_b.at(1) - 0.9), text(9pt)[*6Ω*])

    // R4 between nodes c and d (vertical)
    let r4_zigzag = (
      (node_c.at(0), node_c.at(1) - 0.3),
      (node_c.at(0) - 0.15, node_c.at(1) - 0.5),
      (node_c.at(0) + 0.15, node_c.at(1) - 0.7),
      (node_c.at(0) - 0.15, node_c.at(1) - 0.9),
      (node_c.at(0), node_c.at(1) - 1.1),
    )
    for i in range(r4_zigzag.len() - 1) {
      line(r4_zigzag.at(i), r4_zigzag.at(i + 1), stroke: 2pt + black)
    }
    content((node_c.at(0) + 0.4, node_c.at(1) - 0.7), text(9pt)[*R₄*])
    content((node_c.at(0) + 0.4, node_c.at(1) - 0.9), text(9pt)[*3Ω*])

    // Connecting wires
    line((node_a.at(0) + 0.1, node_a.at(1)), (node_a.at(0) + 0.7, node_a.at(1)), stroke: 2pt + black) // a to R1
    line((node_a.at(0) + 1.5, node_a.at(1)), (node_b.at(0), node_b.at(1)), stroke: 2pt + black) // R1 to b
    line((node_b.at(0) + 0.7, node_b.at(1)), (node_b.at(0) + 1.5, node_b.at(1)), stroke: 2pt + black) // b to R2
    line((node_b.at(0) + 1.5, node_b.at(1)), (node_c.at(0), node_c.at(1)), stroke: 2pt + black) // R2 to c
    line((node_b.at(0), node_b.at(1) - 0.3), (node_b.at(0), node_b.at(1) - 1.1), stroke: 2pt + black) // b to R3 to e
    line((node_c.at(0), node_c.at(1) - 0.3), (node_c.at(0), node_c.at(1) - 1.1), stroke: 2pt + black) // c to R4 to d
    line((node_e.at(0), node_e.at(1)), (node_d.at(0), node_d.at(1)), stroke: 2pt + black) // e to d (bottom)
    line((node_f.at(0), node_f.at(1)), (node_e.at(0), node_e.at(1)), stroke: 2pt + black) // f to e (bottom)
    line((node_a.at(0) - 0.1, node_a.at(1)), (node_f.at(0), node_f.at(1)), stroke: 2pt + black) // a to f (left side)

    // Highlight nodes with red filled circles
    circle(node_a, radius: 0.08, fill: red, stroke: red + 2pt)
    circle(node_b, radius: 0.08, fill: red, stroke: red + 2pt)
    circle(node_c, radius: 0.08, fill: red, stroke: red + 2pt)
    circle(node_d, radius: 0.08, fill: red, stroke: red + 2pt)
    circle(node_e, radius: 0.08, fill: red, stroke: red + 2pt)
    circle(node_f, radius: 0.08, fill: red, stroke: red + 2pt)

    // Node labels
    content((node_a.at(0) - 0.3, node_a.at(1) + 0.15), text(11pt, fill: red)[*a*])
    content((node_b.at(0) - 0.15, node_b.at(1) + 0.25), text(11pt, fill: red)[*b*])
    content((node_c.at(0) + 0.15, node_c.at(1) + 0.25), text(11pt, fill: red)[*c*])
    content((node_d.at(0) + 0.15, node_d.at(1) - 0.25), text(11pt, fill: red)[*d*])
    content((node_e.at(0) - 0.15, node_e.at(1) - 0.25), text(11pt, fill: red)[*e*])
    content((node_f.at(0) - 0.3, node_f.at(1) - 0.15), text(11pt, fill: red)[*f*])
  }),
  caption: [Circuit with *nodes* highlighted (red circles). This circuit has 6 nodes: a, b, c, d, e, f],
) <nodes-diagram>

#figure(
  canvas(length: 1.2cm, {
    import draw: *

    // Same circuit layout as above
    let node_a = (0, 2)
    let node_b = (3, 2)
    let node_c = (6, 2)
    let node_d = (6, 0)
    let node_e = (3, 0)
    let node_f = (0, 0)

    // Voltage source between nodes f and a
    line(
      (node_a.at(0) - 0.1, node_a.at(1) - 0.3),
      (node_a.at(0) - 0.1, node_a.at(1) + 0.3),
      stroke: 3pt + black,
    )
    line(
      (node_a.at(0) + 0.1, node_a.at(1) - 0.2),
      (node_a.at(0) + 0.1, node_a.at(1) + 0.2),
      stroke: 3pt + black,
    )
    content((node_a.at(0), node_a.at(1) - 0.6), text(9pt)[*12V*])
    content((node_a.at(0) - 0.25, node_a.at(1)), text(10pt)[*+*])
    content((node_a.at(0) + 0.25, node_a.at(1)), text(10pt)[*-*])

    // R1 between nodes a and b (highlighted as branch 1)
    let r1_zigzag = (
      (node_a.at(0) + 0.7, node_a.at(1)),
      (node_a.at(0) + 0.9, node_a.at(1) + 0.15),
      (node_a.at(0) + 1.1, node_a.at(1) - 0.15),
      (node_a.at(0) + 1.3, node_a.at(1) + 0.15),
      (node_a.at(0) + 1.5, node_a.at(1)),
    )
    for i in range(r1_zigzag.len() - 1) {
      line(r1_zigzag.at(i), r1_zigzag.at(i + 1), stroke: 3pt + blue)
    }
    content((node_a.at(0) + 1.1, node_a.at(1) + 0.4), text(9pt, fill: blue)[*R₁*])
    content((node_a.at(0) + 1.1, node_a.at(1) - 0.4), text(9pt)[*4Ω*])

    // R2 between nodes b and c (highlighted as branch 2)
    let r2_zigzag = (
      (node_b.at(0) + 0.7, node_b.at(1)),
      (node_b.at(0) + 0.9, node_b.at(1) + 0.15),
      (node_b.at(0) + 1.1, node_b.at(1) - 0.15),
      (node_b.at(0) + 1.3, node_b.at(1) + 0.15),
      (node_b.at(0) + 1.5, node_b.at(1)),
    )
    for i in range(r2_zigzag.len() - 1) {
      line(r2_zigzag.at(i), r2_zigzag.at(i + 1), stroke: 3pt + green)
    }
    content((node_b.at(0) + 1.1, node_b.at(1) + 0.4), text(9pt, fill: green)[*R₂*])
    content((node_b.at(0) + 1.1, node_b.at(1) - 0.4), text(9pt)[*2Ω*])

    // R3 between nodes b and e (highlighted as branch 3)
    let r3_zigzag = (
      (node_b.at(0), node_b.at(1) - 0.3),
      (node_b.at(0) - 0.15, node_b.at(1) - 0.5),
      (node_b.at(0) + 0.15, node_b.at(1) - 0.7),
      (node_b.at(0) - 0.15, node_b.at(1) - 0.9),
      (node_b.at(0), node_b.at(1) - 1.1),
    )
    for i in range(r3_zigzag.len() - 1) {
      line(r3_zigzag.at(i), r3_zigzag.at(i + 1), stroke: 3pt + orange)
    }
    content((node_b.at(0) + 0.4, node_b.at(1) - 0.7), text(9pt, fill: orange)[*R₃*])
    content((node_b.at(0) + 0.4, node_b.at(1) - 0.9), text(9pt)[*6Ω*])

    // R4 between nodes c and d (highlighted as branch 4)
    let r4_zigzag = (
      (node_c.at(0), node_c.at(1) - 0.3),
      (node_c.at(0) - 0.15, node_c.at(1) - 0.5),
      (node_c.at(0) + 0.15, node_c.at(1) - 0.7),
      (node_c.at(0) - 0.15, node_c.at(1) - 0.9),
      (node_c.at(0), node_c.at(1) - 1.1),
    )
    for i in range(r4_zigzag.len() - 1) {
      line(r4_zigzag.at(i), r4_zigzag.at(i + 1), stroke: 3pt + purple)
    }
    content((node_c.at(0) + 0.4, node_c.at(1) - 0.7), text(9pt, fill: purple)[*R₄*])
    content((node_c.at(0) + 0.4, node_c.at(1) - 0.9), text(9pt)[*3Ω*])

    // Connecting wires (regular black)
    line((node_a.at(0) + 0.1, node_a.at(1)), (node_a.at(0) + 0.7, node_a.at(1)), stroke: 3pt + blue) // a to R1
    line((node_a.at(0) + 1.5, node_a.at(1)), (node_b.at(0), node_b.at(1)), stroke: 3pt + blue) // R1 to b
    line((node_b.at(0) + 0.7, node_b.at(1)), (node_b.at(0) + 1.5, node_b.at(1)), stroke: 3pt + green) // b to R2
    line((node_b.at(0) + 1.5, node_b.at(1)), (node_c.at(0), node_c.at(1)), stroke: 3pt + green) // R2 to c
    line((node_b.at(0), node_b.at(1) - 0.3), (node_b.at(0), node_b.at(1) - 1.1), stroke: 3pt + orange) // b to R3 to e
    line((node_c.at(0), node_c.at(1) - 0.3), (node_c.at(0), node_c.at(1) - 1.1), stroke: 3pt + purple) // c to R4 to d
    line((node_e.at(0), node_e.at(1)), (node_d.at(0), node_d.at(1)), stroke: 3pt + maroon) // e to d (bottom) - branch 5
    line((node_f.at(0), node_f.at(1)), (node_e.at(0), node_e.at(1)), stroke: 3pt + maroon) // f to e (bottom) - branch 5
    line((node_a.at(0) - 0.1, node_a.at(1)), (node_f.at(0), node_f.at(1)), stroke: 3pt + navy) // a to f (left side) - branch 6

    // Small node markers
    circle(node_a, radius: 0.05, fill: black)
    circle(node_b, radius: 0.05, fill: black)
    circle(node_c, radius: 0.05, fill: black)
    circle(node_d, radius: 0.05, fill: black)
    circle(node_e, radius: 0.05, fill: black)
    circle(node_f, radius: 0.05, fill: black)

    // Branch labels (positioned to avoid overlaps)
    content((node_a.at(0) + 1.1, node_a.at(1) + 1.0), text(9pt)[Branch 1])
    content((node_b.at(0) + 1.1, node_b.at(1) + 1.0), text(9pt)[Branch 2])
    content((node_b.at(0) - 1.0, node_b.at(1) - 0.7), text(9pt)[Branch 3])
    content((node_c.at(0) + 1.0, node_c.at(1) - 0.7), text(9pt)[Branch 4])
    content((node_e.at(0) + 1.5, node_e.at(1) - 0.3), text(9pt)[Branch 5])
    content((node_f.at(0) - 0.8, node_f.at(1) + 1.2), text(9pt)[Branch 6])
  }),
  caption: [Circuit with *branches* highlighted (different colors). This circuit has 6 branches: 4 resistors, 1 voltage source, and 1 connecting wire],
) <branches-diagram>

#figure(
  canvas(length: 1.2cm, {
    import draw: *

    // Same circuit layout as above
    let node_a = (0, 2)
    let node_b = (3, 2)
    let node_c = (6, 2)
    let node_d = (6, 0)
    let node_e = (3, 0)
    let node_f = (0, 0)

    // Voltage source between nodes f and a
    line(
      (node_a.at(0) - 0.1, node_a.at(1) - 0.3),
      (node_a.at(0) - 0.1, node_a.at(1) + 0.3),
      stroke: 3pt + black,
    )
    line(
      (node_a.at(0) + 0.1, node_a.at(1) - 0.2),
      (node_a.at(0) + 0.1, node_a.at(1) + 0.2),
      stroke: 3pt + black,
    )
    content((node_a.at(0), node_a.at(1) - 0.6), text(9pt)[*12V*])
    content((node_a.at(0) - 0.25, node_a.at(1)), text(10pt)[*+*])
    content((node_a.at(0) + 0.25, node_a.at(1)), text(10pt)[*-*])

    // R1 between nodes a and b
    let r1_zigzag = (
      (node_a.at(0) + 0.7, node_a.at(1)),
      (node_a.at(0) + 0.9, node_a.at(1) + 0.15),
      (node_a.at(0) + 1.1, node_a.at(1) - 0.15),
      (node_a.at(0) + 1.3, node_a.at(1) + 0.15),
      (node_a.at(0) + 1.5, node_a.at(1)),
    )
    for i in range(r1_zigzag.len() - 1) {
      line(r1_zigzag.at(i), r1_zigzag.at(i + 1), stroke: 2pt + black)
    }
    content((node_a.at(0) + 1.1, node_a.at(1) + 0.3), text(9pt)[*R₁*])
    content((node_a.at(0) + 1.1, node_a.at(1) - 0.3), text(9pt)[*4Ω*])

    // R2 between nodes b and c
    let r2_zigzag = (
      (node_b.at(0) + 0.7, node_b.at(1)),
      (node_b.at(0) + 0.9, node_b.at(1) + 0.15),
      (node_b.at(0) + 1.1, node_b.at(1) - 0.15),
      (node_b.at(0) + 1.3, node_b.at(1) + 0.15),
      (node_b.at(0) + 1.5, node_b.at(1)),
    )
    for i in range(r2_zigzag.len() - 1) {
      line(r2_zigzag.at(i), r2_zigzag.at(i + 1), stroke: 2pt + black)
    }
    content((node_b.at(0) + 1.1, node_b.at(1) + 0.3), text(9pt)[*R₂*])
    content((node_b.at(0) + 1.1, node_b.at(1) - 0.3), text(9pt)[*2Ω*])

    // R3 between nodes b and e
    let r3_zigzag = (
      (node_b.at(0), node_b.at(1) - 0.3),
      (node_b.at(0) - 0.15, node_b.at(1) - 0.5),
      (node_b.at(0) + 0.15, node_b.at(1) - 0.7),
      (node_b.at(0) - 0.15, node_b.at(1) - 0.9),
      (node_b.at(0), node_b.at(1) - 1.1),
    )
    for i in range(r3_zigzag.len() - 1) {
      line(r3_zigzag.at(i), r3_zigzag.at(i + 1), stroke: 2pt + black)
    }
    content((node_b.at(0) - 0.6, node_b.at(1) - 0.7), text(9pt)[*R₃*])
    content((node_b.at(0) - 0.6, node_b.at(1) - 0.9), text(9pt)[*6Ω*])

    // R4 between nodes c and d
    let r4_zigzag = (
      (node_c.at(0), node_c.at(1) - 0.3),
      (node_c.at(0) - 0.15, node_c.at(1) - 0.5),
      (node_c.at(0) + 0.15, node_c.at(1) - 0.7),
      (node_c.at(0) - 0.15, node_c.at(1) - 0.9),
      (node_c.at(0), node_c.at(1) - 1.1),
    )
    for i in range(r4_zigzag.len() - 1) {
      line(r4_zigzag.at(i), r4_zigzag.at(i + 1), stroke: 2pt + black)
    }
    content((node_c.at(0) - 0.6, node_c.at(1) - 0.7), text(9pt)[*R₄*])
    content((node_c.at(0) - 0.6, node_c.at(1) - 0.9), text(9pt)[*3Ω*])

    // Connecting wires (regular black)
    line((node_a.at(0) + 0.1, node_a.at(1)), (node_a.at(0) + 0.7, node_a.at(1)), stroke: 2pt + black)
    line((node_a.at(0) + 1.5, node_a.at(1)), (node_b.at(0), node_b.at(1)), stroke: 2pt + black)
    line((node_b.at(0) + 0.7, node_b.at(1)), (node_b.at(0) + 1.5, node_b.at(1)), stroke: 2pt + black)
    line((node_b.at(0) + 1.5, node_b.at(1)), (node_c.at(0), node_c.at(1)), stroke: 2pt + black)
    line((node_b.at(0), node_b.at(1) - 0.3), (node_b.at(0), node_b.at(1) - 1.1), stroke: 2pt + black)
    line((node_c.at(0), node_c.at(1) - 0.3), (node_c.at(0), node_c.at(1) - 1.1), stroke: 2pt + black)
    line((node_e.at(0), node_e.at(1)), (node_d.at(0), node_d.at(1)), stroke: 2pt + black)
    line((node_f.at(0), node_f.at(1)), (node_e.at(0), node_e.at(1)), stroke: 2pt + black)
    line((node_a.at(0) - 0.1, node_a.at(1)), (node_f.at(0), node_f.at(1)), stroke: 2pt + black)

    // Small node markers
    circle(node_a, radius: 0.05, fill: black)
    circle(node_b, radius: 0.05, fill: black)
    circle(node_c, radius: 0.05, fill: black)
    circle(node_d, radius: 0.05, fill: black)
    circle(node_e, radius: 0.05, fill: black)
    circle(node_f, radius: 0.05, fill: black)

    // Complete loop indicators with arrows going all the way around

    // Loop 1: a → b → e → f → a (RED) - inner left loop
    let loop1_offset = 0.15
    let loop1_path = (
      // Top: a to b (above R1)
      (node_a.at(0) + 0.5, node_a.at(1) + loop1_offset),
      (node_b.at(0) - 0.5, node_b.at(1) + loop1_offset),
      // Right: b to e (right of R3)
      (node_b.at(0) + loop1_offset, node_b.at(1) - 0.2),
      (node_b.at(0) + loop1_offset, node_e.at(1) + 0.2),
      // Bottom: e to f (below bottom wire)
      (node_e.at(0) + 0.5, node_e.at(1) - loop1_offset),
      (node_f.at(0) - 0.5, node_f.at(1) - loop1_offset),
      // Left: f to a (left of voltage source)
      (node_f.at(0) - loop1_offset, node_f.at(1) + 0.2),
      (node_a.at(0) - loop1_offset, node_a.at(1) - 0.2),
      // Close the loop
      (node_a.at(0) + 0.5, node_a.at(1) + loop1_offset),
    )
    for i in range(loop1_path.len() - 1) {
      line(loop1_path.at(i), loop1_path.at(i + 1), stroke: red + 2.5pt)
    }
    // Add arrow on top segment
    line(
      (node_a.at(0) + 1.2, node_a.at(1) + loop1_offset),
      (node_a.at(0) + 1.8, node_a.at(1) + loop1_offset),
      mark: (end: ">", stroke: red + 2.5pt),
      stroke: red + 2.5pt,
    )
    content((node_a.at(0) + 0.8, node_a.at(1) - 0.8), text(11pt, fill: red)[Loop 1])

    // Loop 2: b → c → d → e → b (BLUE) - inner right loop
    let loop2_offset = 0.15
    let loop2_path = (
      // Top: b to c (above R2)
      (node_b.at(0) + 0.5, node_b.at(1) + loop2_offset),
      (node_c.at(0) - 0.5, node_c.at(1) + loop2_offset),
      // Right: c to d (right of R4)
      (node_c.at(0) + loop2_offset, node_c.at(1) - 0.2),
      (node_c.at(0) + loop2_offset, node_d.at(1) + 0.2),
      // Bottom: d to e (below bottom wire)
      (node_d.at(0) - 0.5, node_d.at(1) - loop2_offset),
      (node_e.at(0) + 0.5, node_e.at(1) - loop2_offset),
      // Left: e to b (left of R3)
      (node_e.at(0) - loop2_offset, node_e.at(1) + 0.2),
      (node_b.at(0) - loop2_offset, node_b.at(1) - 0.2),
      // Close the loop
      (node_b.at(0) + 0.5, node_b.at(1) + loop2_offset),
    )
    for i in range(loop2_path.len() - 1) {
      line(loop2_path.at(i), loop2_path.at(i + 1), stroke: blue + 2.5pt)
    }
    // Add arrow on top segment
    line(
      (node_b.at(0) + 1.2, node_b.at(1) + loop2_offset),
      (node_b.at(0) + 1.8, node_b.at(1) + loop2_offset),
      mark: (end: ">", stroke: blue + 2.5pt),
      stroke: blue + 2.5pt,
    )
    content((node_c.at(0) - 0.8, node_c.at(1) - 0.8), text(11pt, fill: blue)[Loop 2])

    // Loop 3: a → b → c → d → e → f → a (GREEN) - outer loop
    let loop3_offset = 0.3
    let loop3_path = (
      // Top: a to c (above entire top section)
      (node_a.at(0) + 0.3, node_a.at(1) + loop3_offset),
      (node_c.at(0) - 0.3, node_c.at(1) + loop3_offset),
      // Right: c to d (far right of circuit)
      (node_c.at(0) + loop3_offset, node_c.at(1) + 0.1),
      (node_c.at(0) + loop3_offset, node_d.at(1) - 0.1),
      // Bottom: d to f (below entire bottom section)
      (node_d.at(0) - 0.3, node_d.at(1) - loop3_offset),
      (node_f.at(0) + 0.3, node_f.at(1) - loop3_offset),
      // Left: f to a (far left of circuit)
      (node_f.at(0) - loop3_offset, node_f.at(1) - 0.1),
      (node_a.at(0) - loop3_offset, node_a.at(1) + 0.1),
      // Close the loop
      (node_a.at(0) + 0.3, node_a.at(1) + loop3_offset),
    )
    for i in range(loop3_path.len() - 1) {
      line(loop3_path.at(i), loop3_path.at(i + 1), stroke: green + 2.5pt)
    }
    // Add arrow on top segment
    line(
      (node_a.at(0) + 2.4, node_a.at(1) + loop3_offset),
      (node_a.at(0) + 3.6, node_a.at(1) + loop3_offset),
      mark: (end: ">", stroke: green + 2.5pt),
      stroke: green + 2.5pt,
    )
    content((node_a.at(0) + 3, node_a.at(1) + 1.0), text(11pt, fill: green)[Loop 3])

    // Node labels
    content((node_a.at(0) - 0.3, node_a.at(1) + 0.15), text(9pt)[*a*])
    content((node_b.at(0) - 0.15, node_b.at(1) + 0.25), text(9pt)[*b*])
    content((node_c.at(0) + 0.15, node_c.at(1) + 0.25), text(9pt)[*c*])
    content((node_d.at(0) + 0.15, node_d.at(1) - 0.25), text(9pt)[*d*])
    content((node_e.at(0) - 0.15, node_e.at(1) - 0.25), text(9pt)[*e*])
    content((node_f.at(0) - 0.3, node_f.at(1) - 0.15), text(9pt)[*f*])
  }),
  caption: [Circuit with *loops* highlighted (colored arrows). This circuit has several possible loops, with three examples shown],
) <loops-diagram>

#note("Counting Circuit Elements")[
  For this example circuit:

  - *Nodes*: 6 total (a, b, c, d, e, f)
  - *Branches*: 6 total (voltage source + 4 resistors + 1 connecting wire)
  - *Loops*: Many possible loops exist. The three shown are:
    - *Loop 1*: a → R₁ → b → R₃ → e → (bottom wire) → f → (voltage source) → a
    - *Loop 2*: b → R₂ → c → R₄ → d → (bottom wire) → e → R₃ → b
    - *Loop 3*: Outer loop through all components a → R₁ → b → R₂ → c → R₄ → d → (bottom wire) → e → (bottom wire) → f → (voltage source) → a

  Understanding these topological elements is essential for applying systematic circuit analysis methods like nodal analysis and mesh analysis.
]

= Resistor Combinations

Resistors can be combined in two fundamental ways: series and parallel connections. Understanding these combinations allows us to simplify complex circuits by finding equivalent resistances.

== Series Connection

#definition("Series Resistors")[
  Resistors are in series when they share the same current (i.e., when current has only one path to flow through all of them). The equivalent resistance is the sum of individual resistances:
  $ #iboxed($R_"eq" = sum_(i=1)^n R_i = R_1 + R_2 + R_3 + dots$) $
]

#figure(
  canvas(length: 1.5cm, {
    import draw: *

    // Individual resistors in series
    let r1_pos = (1, 2)
    let r2_pos = (3, 2)
    let r3_pos = (5, 2)

    // R1
    let r1_zigzag = (
      (r1_pos.at(0) - 0.3, r1_pos.at(1)),
      (r1_pos.at(0) - 0.1, r1_pos.at(1) + 0.15),
      (r1_pos.at(0) + 0.1, r1_pos.at(1) - 0.15),
      (r1_pos.at(0) + 0.3, r1_pos.at(1)),
    )
    for i in range(r1_zigzag.len() - 1) {
      line(r1_zigzag.at(i), r1_zigzag.at(i + 1), stroke: 2.5pt + black)
    }
    content((r1_pos.at(0), r1_pos.at(1) - 0.4), text(10pt)[*R₁*])

    // R2
    let r2_zigzag = (
      (r2_pos.at(0) - 0.3, r2_pos.at(1)),
      (r2_pos.at(0) - 0.1, r2_pos.at(1) + 0.15),
      (r2_pos.at(0) + 0.1, r2_pos.at(1) - 0.15),
      (r2_pos.at(0) + 0.3, r2_pos.at(1)),
    )
    for i in range(r2_zigzag.len() - 1) {
      line(r2_zigzag.at(i), r2_zigzag.at(i + 1), stroke: 2.5pt + black)
    }
    content((r2_pos.at(0), r2_pos.at(1) - 0.4), text(10pt)[*R₂*])

    // R3
    let r3_zigzag = (
      (r3_pos.at(0) - 0.3, r3_pos.at(1)),
      (r3_pos.at(0) - 0.1, r3_pos.at(1) + 0.15),
      (r3_pos.at(0) + 0.1, r3_pos.at(1) - 0.15),
      (r3_pos.at(0) + 0.3, r3_pos.at(1)),
    )
    for i in range(r3_zigzag.len() - 1) {
      line(r3_zigzag.at(i), r3_zigzag.at(i + 1), stroke: 2.5pt + black)
    }
    content((r3_pos.at(0), r3_pos.at(1) - 0.4), text(10pt)[*R₃*])

    // Connecting wires
    line((0, r1_pos.at(1)), (r1_pos.at(0) - 0.3, r1_pos.at(1)), stroke: 2.5pt + black)
    line((r1_pos.at(0) + 0.3, r1_pos.at(1)), (r2_pos.at(0) - 0.3, r2_pos.at(1)), stroke: 2.5pt + black)
    line((r2_pos.at(0) + 0.3, r2_pos.at(1)), (r3_pos.at(0) - 0.3, r3_pos.at(1)), stroke: 2.5pt + black)
    line((r3_pos.at(0) + 0.3, r3_pos.at(1)), (6, r3_pos.at(1)), stroke: 2.5pt + black)

    // Current arrows and labels
    line((0.3, r1_pos.at(1) + 0.4), (0.7, r1_pos.at(1) + 0.4), mark: (end: ">", stroke: blue + 2pt), stroke: blue + 2pt)
    content((0.5, r1_pos.at(1) + 0.65), text(10pt, fill: blue)[*I*])

    line((2.3, r2_pos.at(1) + 0.4), (2.7, r2_pos.at(1) + 0.4), mark: (end: ">", stroke: blue + 2pt), stroke: blue + 2pt)
    content((2.5, r2_pos.at(1) + 0.65), text(10pt, fill: blue)[*I*])

    line((4.3, r3_pos.at(1) + 0.4), (4.7, r3_pos.at(1) + 0.4), mark: (end: ">", stroke: blue + 2pt), stroke: blue + 2pt)
    content((4.5, r3_pos.at(1) + 0.65), text(10pt, fill: blue)[*I*])

    // Terminals
    circle((0, r1_pos.at(1)), radius: 0.06, fill: black)
    circle((6, r3_pos.at(1)), radius: 0.06, fill: black)
    content((0, r1_pos.at(1) + 0.3), text(9pt)[*a*])
    content((6, r3_pos.at(1) + 0.3), text(9pt)[*b*])

    // Equivalent circuit below
    content((3, 0.8), text(12pt)[*≡*])

    let req_pos = (3, 0)
    let req_zigzag = (
      (req_pos.at(0) - 0.5, req_pos.at(1)),
      (req_pos.at(0) - 0.2, req_pos.at(1) + 0.2),
      (req_pos.at(0), req_pos.at(1) - 0.2),
      (req_pos.at(0) + 0.2, req_pos.at(1) + 0.2),
      (req_pos.at(0) + 0.5, req_pos.at(1)),
    )
    for i in range(req_zigzag.len() - 1) {
      line(req_zigzag.at(i), req_zigzag.at(i + 1), stroke: 2.5pt + black)
    }
    content((req_pos.at(0), req_pos.at(1) - 0.5), text(10pt)[*R*#sub[eq] *= R₁ + R₂ + R₃*])

    // Connecting wires for equivalent
    line((1, req_pos.at(1)), (req_pos.at(0) - 0.5, req_pos.at(1)), stroke: 2.5pt + black)
    line((req_pos.at(0) + 0.5, req_pos.at(1)), (5, req_pos.at(1)), stroke: 2.5pt + black)

    // Current for equivalent
    line(
      (1.8, req_pos.at(1) + 0.4),
      (2.2, req_pos.at(1) + 0.4),
      mark: (end: ">", stroke: blue + 2pt),
      stroke: blue + 2pt,
    )
    content((2, req_pos.at(1) + 0.65), text(10pt, fill: blue)[*I*])

    // Terminals for equivalent
    circle((1, req_pos.at(1)), radius: 0.06, fill: black)
    circle((5, req_pos.at(1)), radius: 0.06, fill: black)
    content((1, req_pos.at(1) - 0.3), text(9pt)[*a*])
    content((5, req_pos.at(1) - 0.3), text(9pt)[*b*])
  }),
  caption: [Series resistor combination: same current flows through each resistor],
) <series-resistors>

#note("Series Resistor Properties")[
  In a series connection:
  - *Same current*: $I_1 = I_2 = I_3 = I$
  - *Voltages add*: $V_"total" = V_1 + V_2 + V_3$
  - *Individual voltages*: $V_i = I R_i$
  - *Total resistance increases*: $R_"eq" > R_"largest"$
]

== Parallel Connection

#definition("Parallel Resistors")[
  Resistors are in parallel when they share the same voltage (i.e., when they are connected across the same two nodes). The reciprocal of equivalent resistance equals the sum of reciprocals:
  $ #iboxed($1/R_"eq" = sum_(i=1)^n 1/R_i = 1/R_1 + 1/R_2 + 1/R_3 + dots$) $

  For two resistors: $R_"eq" = (R_1 R_2)/(R_1 + R_2)$ (product over sum)
]

#figure(
  canvas(length: 1.5cm, {
    import draw: *

    // Parallel resistors
    let left_node = (1, 1.5)
    let right_node = (5, 1.5)

    // Top branch with R1
    let r1_pos = (3, 2.2)
    let r1_zigzag = (
      (r1_pos.at(0) - 0.4, r1_pos.at(1)),
      (r1_pos.at(0) - 0.2, r1_pos.at(1) + 0.15),
      (r1_pos.at(0), r1_pos.at(1) - 0.15),
      (r1_pos.at(0) + 0.2, r1_pos.at(1) + 0.15),
      (r1_pos.at(0) + 0.4, r1_pos.at(1)),
    )
    for i in range(r1_zigzag.len() - 1) {
      line(r1_zigzag.at(i), r1_zigzag.at(i + 1), stroke: 2.5pt + black)
    }
    content((r1_pos.at(0), r1_pos.at(1) + 0.4), text(10pt)[*R₁*])

    // Middle branch with R2
    let r2_pos = (3, 1.5)
    let r2_zigzag = (
      (r2_pos.at(0) - 0.4, r2_pos.at(1)),
      (r2_pos.at(0) - 0.2, r2_pos.at(1) + 0.15),
      (r2_pos.at(0), r2_pos.at(1) - 0.15),
      (r2_pos.at(0) + 0.2, r2_pos.at(1) + 0.15),
      (r2_pos.at(0) + 0.4, r2_pos.at(1)),
    )
    for i in range(r2_zigzag.len() - 1) {
      line(r2_zigzag.at(i), r2_zigzag.at(i + 1), stroke: 2.5pt + black)
    }
    content((r2_pos.at(0), r2_pos.at(1) + 0.4), text(10pt)[*R₂*])

    // Bottom branch with R3
    let r3_pos = (3, 0.8)
    let r3_zigzag = (
      (r3_pos.at(0) - 0.4, r3_pos.at(1)),
      (r3_pos.at(0) - 0.2, r3_pos.at(1) + 0.15),
      (r3_pos.at(0), r3_pos.at(1) - 0.15),
      (r3_pos.at(0) + 0.2, r3_pos.at(1) + 0.15),
      (r3_pos.at(0) + 0.4, r3_pos.at(1)),
    )
    for i in range(r3_zigzag.len() - 1) {
      line(r3_zigzag.at(i), r3_zigzag.at(i + 1), stroke: 2.5pt + black)
    }
    content((r3_pos.at(0), r3_pos.at(1) - 0.4), text(10pt)[*R₃*])

    // Connecting wires - left side
    line((left_node.at(0), left_node.at(1)), (left_node.at(0), r1_pos.at(1)), stroke: 2.5pt + black)
    line((left_node.at(0), r1_pos.at(1)), (r1_pos.at(0) - 0.4, r1_pos.at(1)), stroke: 2.5pt + black)
    line((left_node.at(0), left_node.at(1)), (r2_pos.at(0) - 0.4, r2_pos.at(1)), stroke: 2.5pt + black)
    line((left_node.at(0), left_node.at(1)), (left_node.at(0), r3_pos.at(1)), stroke: 2.5pt + black)
    line((left_node.at(0), r3_pos.at(1)), (r3_pos.at(0) - 0.4, r3_pos.at(1)), stroke: 2.5pt + black)

    // Connecting wires - right side
    line((right_node.at(0), right_node.at(1)), (right_node.at(0), r1_pos.at(1)), stroke: 2.5pt + black)
    line((right_node.at(0), r1_pos.at(1)), (r1_pos.at(0) + 0.4, r1_pos.at(1)), stroke: 2.5pt + black)
    line((right_node.at(0), right_node.at(1)), (r2_pos.at(0) + 0.4, r2_pos.at(1)), stroke: 2.5pt + black)
    line((right_node.at(0), right_node.at(1)), (right_node.at(0), r3_pos.at(1)), stroke: 2.5pt + black)
    line((right_node.at(0), r3_pos.at(1)), (r3_pos.at(0) + 0.4, r3_pos.at(1)), stroke: 2.5pt + black)

    // External connections
    line((0, left_node.at(1)), (left_node.at(0), left_node.at(1)), stroke: 2.5pt + black)
    line((right_node.at(0), right_node.at(1)), (6, right_node.at(1)), stroke: 2.5pt + black)

    // Current arrows
    line((1.8, r1_pos.at(1) + 0.2), (2.2, r1_pos.at(1) + 0.2), mark: (end: ">", stroke: blue + 2pt), stroke: blue + 2pt)
    content((1.4, r1_pos.at(1) + 0.2), text(10pt, fill: blue)[*I₁*])

    line((1.8, r2_pos.at(1) + 0.2), (2.2, r2_pos.at(1) + 0.2), mark: (end: ">", stroke: blue + 2pt), stroke: blue + 2pt)
    content((1.4, r2_pos.at(1) + 0.2), text(10pt, fill: blue)[*I₂*])

    line((1.8, r3_pos.at(1) + 0.2), (2.2, r3_pos.at(1) + 0.2), mark: (end: ">", stroke: blue + 2pt), stroke: blue + 2pt)
    content((1.4, r3_pos.at(1) + 0.2), text(10pt, fill: blue)[*I₃*])

    // Total current
    line(
      (0.3, left_node.at(1) + 0.2),
      (0.7, left_node.at(1) + 0.2),
      mark: (end: ">", stroke: red + 2pt),
      stroke: red + 2pt,
    )
    content((0.5, left_node.at(1) + 0.5), text(10pt, fill: red)[*I*])

    // Voltage across parallel combination
    content((left_node.at(0) - 0.2, left_node.at(1) + 0.8), text(10pt, fill: green)[*+*])
    content((right_node.at(0) + 0.2, right_node.at(1) + 0.8), text(10pt, fill: green)[*-*])
    content((3, 3), text(10pt, fill: green)[*V*])

    // Node labels
    circle((left_node.at(0), left_node.at(1)), radius: 0.06, fill: black)
    circle((right_node.at(0), right_node.at(1)), radius: 0.06, fill: black)
    content((left_node.at(0) - 0.2, left_node.at(1) - 0.2), text(9pt)[*a*])
    content((right_node.at(0) + 0.2, right_node.at(1) - 0.2), text(9pt)[*b*])
  }),
  caption: [Parallel resistor combination: same voltage across each resistor],
) <parallel-resistors>

#note("Parallel Resistor Properties")[
  In a parallel connection:
  - *Same voltage*: $V_1 = V_2 = V_3 = V$
  - *Currents add*: $I_"total" = I_1 + I_2 + I_3$
  - *Individual currents*: $I_i = V/R_i$
  - *Total resistance decreases*: $R_"eq" < R_"smallest"$
  - *Current divides inversely with resistance*
]

== Voltage Division

When resistors are connected in series, the total voltage divides among them proportionally to their resistance values.

#definition("Voltage Divider Rule")[
  For resistors in series, the voltage across any resistor is:
  $ #iboxed($V_i = V_"total" times (R_i)/(R_"total")$) $
  where $R_"total" = R_1 + R_2 + dots + R_n$ is the sum of all series resistances.
]

#figure(
  canvas(length: 1.8cm, {
    import draw: *

    // Voltage source
    let vs_pos = (1, 1.5)
    line(
      (vs_pos.at(0) - 0.1, vs_pos.at(1) - 0.4),
      (vs_pos.at(0) - 0.1, vs_pos.at(1) + 0.4),
      stroke: 3pt + black,
    )
    line(
      (vs_pos.at(0) + 0.1, vs_pos.at(1) - 0.3),
      (vs_pos.at(0) + 0.1, vs_pos.at(1) + 0.3),
      stroke: 3pt + black,
    )
    content((vs_pos.at(0), vs_pos.at(1) - 0.7), text(10pt)[*V*#sub[s]])
    content((vs_pos.at(0) - 0.25, vs_pos.at(1)), text(11pt)[*+*])
    content((vs_pos.at(0) + 0.25, vs_pos.at(1)), text(11pt)[*-*])

    // R1 (top resistor)
    let r1_pos = (3, 2.5)
    let r1_zigzag = (
      (r1_pos.at(0), r1_pos.at(1) - 0.3),
      (r1_pos.at(0) - 0.15, r1_pos.at(1) - 0.1),
      (r1_pos.at(0) + 0.15, r1_pos.at(1) + 0.1),
      (r1_pos.at(0) - 0.15, r1_pos.at(1) + 0.3),
      (r1_pos.at(0), r1_pos.at(1) + 0.5),
    )
    for i in range(r1_zigzag.len() - 1) {
      line(r1_zigzag.at(i), r1_zigzag.at(i + 1), stroke: 2.5pt + black)
    }
    content((r1_pos.at(0) + 0.4, r1_pos.at(1) + 0.1), text(10pt)[*R₁*])

    // Voltage across R1
    content((r1_pos.at(0) - 0.4, r1_pos.at(1) + 0.3), text(10pt, fill: red)[*+*])
    content((r1_pos.at(0) - 0.4, r1_pos.at(1) - 0.1), text(10pt, fill: red)[*-*])
    content((r1_pos.at(0) - 0.8, r1_pos.at(1) + 0.1), text(10pt, fill: red)[*V₁*])

    // R2 (bottom resistor)
    let r2_pos = (3, 0.5)
    let r2_zigzag = (
      (r2_pos.at(0), r2_pos.at(1) - 0.3),
      (r2_pos.at(0) - 0.15, r2_pos.at(1) - 0.1),
      (r2_pos.at(0) + 0.15, r2_pos.at(1) + 0.1),
      (r2_pos.at(0) - 0.15, r2_pos.at(1) + 0.3),
      (r2_pos.at(0), r2_pos.at(1) + 0.5),
    )
    for i in range(r2_zigzag.len() - 1) {
      line(r2_zigzag.at(i), r2_zigzag.at(i + 1), stroke: 2.5pt + black)
    }
    content((r2_pos.at(0) + 0.4, r2_pos.at(1) + 0.1), text(10pt)[*R₂*])

    // Voltage across R2
    content((r2_pos.at(0) - 0.4, r2_pos.at(1) + 0.3), text(10pt, fill: blue)[*+*])
    content((r2_pos.at(0) - 0.4, r2_pos.at(1) - 0.1), text(10pt, fill: blue)[*-*])
    content((r2_pos.at(0) - 0.8, r2_pos.at(1) + 0.1), text(10pt, fill: blue)[*V₂*])

    // Connecting wires
    line((vs_pos.at(0) + 0.1, vs_pos.at(1)), (4.5, vs_pos.at(1)), stroke: 2.5pt + black)
    line((4.5, vs_pos.at(1)), (4.5, r1_pos.at(1) + 0.5), stroke: 2.5pt + black)
    line((4.5, r1_pos.at(1) + 0.5), (r1_pos.at(0), r1_pos.at(1) + 0.5), stroke: 2.5pt + black)
    line((r1_pos.at(0), r1_pos.at(1) - 0.3), (r2_pos.at(0), r2_pos.at(1) + 0.5), stroke: 2.5pt + black)
    line((r2_pos.at(0), r2_pos.at(1) - 0.3), (4.5, r2_pos.at(1) - 0.3), stroke: 2.5pt + black)
    line((4.5, r2_pos.at(1) - 0.3), (4.5, -0.5), stroke: 2.5pt + black)
    line((4.5, -0.5), (vs_pos.at(0) - 0.1, -0.5), stroke: 2.5pt + black)
    line((vs_pos.at(0) - 0.1, -0.5), (vs_pos.at(0) - 0.1, vs_pos.at(1)), stroke: 2.5pt + black)

    // Current arrow
    line(
      (3.8, r1_pos.at(1) + 0.7),
      (4.2, r1_pos.at(1) + 0.7),
      mark: (end: ">", stroke: green + 2pt),
      stroke: green + 2pt,
    )
    content((4, r1_pos.at(1) + 0.95), text(10pt, fill: green)[*I*])

    // Ground symbol
    line((4.3, -0.5), (4.7, -0.5), stroke: 2.5pt + black)
    line((4.4, -0.6), (4.6, -0.6), stroke: 2.5pt + black)
    line((4.45, -0.7), (4.55, -0.7), stroke: 2.5pt + black)
  }),
  caption: [Voltage divider circuit showing voltage division across series resistors],
) <voltage-divider>

#example("Voltage Divider Calculation")[
  Given: $V_s = 12"V"$, $R_1 = 8"kΩ"$, $R_2 = 4"kΩ"$

  *Solution:*
  1. Total resistance: $R_"total" = R_1 + R_2 = 8 + 4 = 12"kΩ"$

  2. Voltage across R₁: $V_1 = V_s times (R_1)/(R_"total") = 12"V" times (8"kΩ")/(12"kΩ") = 8"V"$

  3. Voltage across R₂: $V_2 = V_s times (R_2)/(R_"total") = 12"V" times (4"kΩ")/(12"kΩ") = 4"V"$

  *Verification:* $V_1 + V_2 = 8"V" + 4"V" = 12"V" = V_s$ ✓

  Note: The larger resistance (R₁) gets the larger voltage drop.
]

== Current Division

When resistors are connected in parallel, the total current divides among them inversely proportional to their resistance values.

#definition("Current Divider Rule")[
  For resistors in parallel, the current through any resistor is:
  $ #iboxed($I_i = I_"total" times (R_"eq")/(R_i) = I_"total" times (1\/R_i)/(sum_(k=1)^n 1\/R_k)$) $

  For two resistors: $I_1 = I_"total" times (R_2)/(R_1 + R_2)$ and $I_2 = I_"total" times (R_1)/(R_1 + R_2)$
]

#figure(
  canvas(length: 1.8cm, {
    import draw: *

    // Current source
    let is_pos = (1, 1.5)
    circle(is_pos, radius: 0.4, stroke: 2.5pt + black)
    content(is_pos, text(10pt)[*I*#sub[s]])
    line((-0.5, is_pos.at(1)), (is_pos.at(0) - 0.4, is_pos.at(1)), stroke: 2.5pt + black)
    line((is_pos.at(0) + 0.4, is_pos.at(1)), (2, is_pos.at(1)), stroke: 2.5pt + black)
    // Current arrow through source
    line(
      (is_pos.at(0) - 0.15, is_pos.at(1)),
      (is_pos.at(0) + 0.15, is_pos.at(1)),
      mark: (end: ">", stroke: blue + 1.5pt),
      stroke: blue + 1.5pt,
    )

    // Parallel resistors
    let left_node = (2, 1.5)
    let right_node = (4.5, 1.5)

    // R1 (top branch)
    let r1_pos = (3.25, 2.2)
    let r1_zigzag = (
      (r1_pos.at(0) - 0.4, r1_pos.at(1)),
      (r1_pos.at(0) - 0.2, r1_pos.at(1) + 0.15),
      (r1_pos.at(0), r1_pos.at(1) - 0.15),
      (r1_pos.at(0) + 0.2, r1_pos.at(1) + 0.15),
      (r1_pos.at(0) + 0.4, r1_pos.at(1)),
    )
    for i in range(r1_zigzag.len() - 1) {
      line(r1_zigzag.at(i), r1_zigzag.at(i + 1), stroke: 2.5pt + black)
    }
    content((r1_pos.at(0), r1_pos.at(1) + 0.4), text(10pt)[*R₁*])

    // R2 (bottom branch)
    let r2_pos = (3.25, 0.8)
    let r2_zigzag = (
      (r2_pos.at(0) - 0.4, r2_pos.at(1)),
      (r2_pos.at(0) - 0.2, r2_pos.at(1) + 0.15),
      (r2_pos.at(0), r2_pos.at(1) - 0.15),
      (r2_pos.at(0) + 0.2, r2_pos.at(1) + 0.15),
      (r2_pos.at(0) + 0.4, r2_pos.at(1)),
    )
    for i in range(r2_zigzag.len() - 1) {
      line(r2_zigzag.at(i), r2_zigzag.at(i + 1), stroke: 2.5pt + black)
    }
    content((r2_pos.at(0), r2_pos.at(1) - 0.4), text(10pt)[*R₂*])

    // Connecting wires for parallel branches
    line((left_node.at(0), left_node.at(1)), (left_node.at(0), r1_pos.at(1)), stroke: 2.5pt + black)
    line((left_node.at(0), r1_pos.at(1)), (r1_pos.at(0) - 0.4, r1_pos.at(1)), stroke: 2.5pt + black)
    line((right_node.at(0), right_node.at(1)), (right_node.at(0), r1_pos.at(1)), stroke: 2.5pt + black)
    line((right_node.at(0), r1_pos.at(1)), (r1_pos.at(0) + 0.4, r1_pos.at(1)), stroke: 2.5pt + black)

    line((left_node.at(0), left_node.at(1)), (left_node.at(0), r2_pos.at(1)), stroke: 2.5pt + black)
    line((left_node.at(0), r2_pos.at(1)), (r2_pos.at(0) - 0.4, r2_pos.at(1)), stroke: 2.5pt + black)
    line((right_node.at(0), right_node.at(1)), (right_node.at(0), r2_pos.at(1)), stroke: 2.5pt + black)
    line((right_node.at(0), r2_pos.at(1)), (r2_pos.at(0) + 0.4, r2_pos.at(1)), stroke: 2.5pt + black)

    // Return path
    line((right_node.at(0), right_node.at(1)), (5.5, right_node.at(1)), stroke: 2.5pt + black)
    line((5.5, right_node.at(1)), (5.5, -0.5), stroke: 2.5pt + black)
    line((5.5, -0.5), (-0.5, -0.5), stroke: 2.5pt + black)
    line((-0.5, -0.5), (-0.5, is_pos.at(1)), stroke: 2.5pt + black)

    // Current arrows
    line((2.6, r1_pos.at(1) + 0.2), (3, r1_pos.at(1) + 0.2), mark: (end: ">", stroke: red + 2pt), stroke: red + 2pt)
    content((2.3, r1_pos.at(1) + 0.4), text(10pt, fill: red)[*I₁*])

    line((2.6, r2_pos.at(1) + 0.2), (3, r2_pos.at(1) + 0.2), mark: (end: ">", stroke: green + 2pt), stroke: green + 2pt)
    content((2.3, r2_pos.at(1) + 0.4), text(10pt, fill: green)[*I₂*])

    // Voltage across parallel combination
    content((left_node.at(0) - 0.2, left_node.at(1) + 0.2), text(10pt, fill: purple)[*+*])
    content((right_node.at(0) + 0.2, right_node.at(1) + 0.2), text(10pt, fill: purple)[*-*])
    content((3.25, 3), text(10pt, fill: purple)[*V*])

    // Node markers
    circle((left_node.at(0), left_node.at(1)), radius: 0.06, fill: black)
    circle((right_node.at(0), right_node.at(1)), radius: 0.06, fill: black)
  }),
  caption: [Current divider circuit showing current division across parallel resistors],
) <current-divider>

#example("Current Divider Calculation")[
  Given: $I_s = 6"A"$, $R_1 = 3"Ω"$, $R_2 = 6"Ω"$

  *Solution:*
  Using the two-resistor current divider formula:
  1. Current through R₁: $I_1 = I_s times (R_2)/(R_1 + R_2) = 6"A" times (6"Ω")/(3"Ω" + 6"Ω") = 6"A" times (6)/(9) = 4"A"$

  2. Current through R₂: $I_2 = I_s times (R_1)/(R_1 + R_2) = 6"A" times (3"Ω")/(3"Ω" + 6"Ω") = 6"A" times (3)/(9) = 2"A"$

  *Verification:* $I_1 + I_2 = 4"A" + 2"A" = 6"A" = I_s$ ✓

  Note: The smaller resistance (R₁) gets the larger current (inverse relationship).
]

#note("Key Relationships")[
  *Voltage Division (Series):*
  - Voltage divides directly with resistance
  - Larger R gets larger V
  - $V_i/V_"total" = R_i/R_"total"$

  *Current Division (Parallel):*
  - Current divides inversely with resistance
  - Smaller R gets larger I
  - $I_i/I_"total" = (1/R_i)/(sum 1/R_k)$

  These relationships are fundamental for analyzing more complex circuits.
]
