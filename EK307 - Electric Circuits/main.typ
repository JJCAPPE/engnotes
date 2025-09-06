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
  $ q(t) = cases(
    0 &"if" t < 0,
    30 t &"if" 0 <= t < 1,
    30 - 30 (t - 1) &"if" 1 <= t < 2,
    -30 + 15 (t - 2) &"if" 2 <= t < 4,
    0 &"if" t >= 4
  ) $
  with $t$ in seconds. Find $i(t)$ and comment on current direction.
  
  *Solution:*
  Differentiate $q(t)$ on each interval (and convert to amperes by μC/s = μA):
  $ i(t) = cases(
    0 &"if" t < 0,
    30 mu"A" &"if" 0 <= t < 1,
    -30 mu"A" &"if" 1 <= t < 2,
    15 mu"A" &"if" 2 <= t < 4,
    0 &"if" t >= 4
  ) $
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
      line((i * width/5, -0.05), (i * width/5, 0.05), stroke: 0.8pt)
      content((i * width/5, -0.2), text(9pt)[#str(i)])
    }
    
    // Y-axis ticks (for μC values: -30, 0, 30)
    line((-0.05, -1.5), (0.05, -1.5), stroke: 0.8pt)
    content((-0.3, -1.5), text(9pt)[-30])
    line((-0.05, 0), (0.05, 0), stroke: 0.8pt) 
    content((-0.3, 0), text(9pt)[0])
    line((-0.05, 1.5), (0.05, 1.5), stroke: 0.8pt)
    content((-0.3, 1.5), text(9pt)[30])
    
    // Plot q(t) piecewise function (scaling: 30μC = 1.5 units)
    line((0, 0), (width/5, 1.5), stroke: 2pt + blue)           // 0 to 30 over t=0 to 1
    line((width/5, 1.5), (2*width/5, 0), stroke: 2pt + blue)   // 30 to 0 over t=1 to 2  
    line((2*width/5, 0), (4*width/5, -1.5), stroke: 2pt + blue) // 0 to -30 over t=2 to 4
    line((4*width/5, -1.5), (width, -1.5), stroke: 2pt + blue) // flat at -30
    
    // Add transition points
    circle((0, 0), radius: 0.04, fill: blue)
    circle((width/5, 1.5), radius: 0.04, fill: blue)
    circle((2*width/5, 0), radius: 0.04, fill: blue)  
    circle((4*width/5, -1.5), radius: 0.04, fill: blue)
    
    // Axis labels
    content((width/2, -0.5), text(11pt)[*t* (s)])
    content((-0.8, 0.8), text(11pt)[*q(t)* (μC)])
  }),
  caption: [Piecewise linear charge function q(t)]
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
      line((i * width/5, -0.05), (i * width/5, 0.05), stroke: 0.8pt)
      content((i * width/5, -0.2), text(9pt)[#str(i)])
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
    line((0, 1.5), (width/5, 1.5), stroke: 2pt + red)          // 30μA from t=0 to 1
    line((width/5, -1.5), (2*width/5, -1.5), stroke: 2pt + red) // -30μA from t=1 to 2
    line((2*width/5, 0.75), (4*width/5, 0.75), stroke: 2pt + red) // 15μA from t=2 to 4
    line((4*width/5, 0), (width, 0), stroke: 2pt + red)        // 0μA from t=4 onwards
    
    // Vertical transitions (dashed lines showing discontinuities)
    line((0, 0), (0, 1.5), stroke: (dash: "dashed", paint: red, thickness: 1pt))
    line((width/5, 1.5), (width/5, -1.5), stroke: (dash: "dashed", paint: red, thickness: 1pt))
    line((2*width/5, -1.5), (2*width/5, 0.75), stroke: (dash: "dashed", paint: red, thickness: 1pt))
    line((4*width/5, 0.75), (4*width/5, 0), stroke: (dash: "dashed", paint: red, thickness: 1pt))
    
    // Add filled circles at start points, empty at end points for step function
    circle((0, 1.5), radius: 0.04, fill: red)
    circle((width/5, 1.5), radius: 0.04, stroke: red + 1pt, fill: white)
    circle((width/5, -1.5), radius: 0.04, fill: red)
    circle((2*width/5, -1.5), radius: 0.04, stroke: red + 1pt, fill: white)
    circle((2*width/5, 0.75), radius: 0.04, fill: red)
    circle((4*width/5, 0.75), radius: 0.04, stroke: red + 1pt, fill: white)
    circle((4*width/5, 0), radius: 0.04, fill: red)
    
    // Axis labels
    content((width/2, -0.5), text(11pt)[*t* (s)])
    content((-0.8, 0.8), text(11pt)[*i(t)* (μA)])
  }),
  caption: [Piecewise constant current function i(t) = dq/dt]
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

#note("Unit Checks")[
  Combine unit checks frequently: V·A = W. For example, a 2 kΩ resistor carrying 5 mA absorbs $p = i^2 R = (5 "mA")^2 dot 2 "kΩ" = 50 "mW"$.
] 
 