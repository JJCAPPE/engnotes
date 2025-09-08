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
