#import "lib.typ": *
#import "@preview/cetz:0.4.2": canvas, draw
#import "@preview/cetz-plot:0.1.3": plot


// Homework Template Configuration
#show: template.with(
  title: [Homework 6],
  

  // Simplified settings for homework
  lof: false,
  lot: false,
  lol: false,
  toc: false,
  bibliography_file: none,
  paper_size: "a4",
  cols: 1,
  text_font: "STIX Two Text",
  code_font: "DejaVu Sans Mono",
  accent: "#2E86C1", // Blue theme for homework
  h1-prefix: "Problem",
  colortab: false,
)

// Homework-specific styling
#set heading(numbering: "1.a)")
#set enum(numbering: "a)")

// Custom problem environment
#let problem(title: none, body) = {
  if title != none [
    == #title
  ]
  body
  v(1em)
}

// Custom solution environment
#let solution(body) = {
  block(
    fill: blue.lighten(95%),
    stroke: (left: 3pt + blue.lighten(40%)),
    inset: 1em,
    radius: (right: 5pt),
    width: 100%,
    [*Solution:*\ #body],
  )
  v(1em)
}

// Header information
#align(center)[
  #text(12pt)[Giacomo Cappelletto]
]

#horizontalrule

=

==

#solution[

  #align(center)[
    $v_- = v_+ = 0 V$

    $v_p = v_n = 4 V$

    At node A between $2 k Omega$ , $1 m A$ and $v_-$ KCL

    $i_s + i_f = i_n = i_p = 0$

    $1 m A + frac(v_o - v_A, 2 k Omega) = 0$

    $v_a = v_n = 4 V$

    $v_0 = - 1 m A times 2 k Omega + 4 V = -2 V + 4 V = 2 V$
  ]

]

==

#solution[
  #align(center)[
    $v_+ = 3 V, v_- = v_o + 1 V$

    $v_- = v_+ => v_o + 1 = 3 => v_o = 2 V$
  ]
]

=

#solution[
  #align(center)[
    $v_+ = 1 V times frac(90 k Omega, 10 k Omega + 90 k Omega) = 0.9 V$

    $v_- = v_+ = 0.9 V$

    $v_- = v_o times frac(50 k Omega, 50 k Omega + 100 k Omega) = frac(v_o, 3)$

    $v_o = 3 times 0.9 V = 2.7 V$

    $i_o = frac(v_o, 10 k Omega) + frac(v_o - v_-, 100 k Omega) = frac(2.7, 10 k Omega) + frac(2.7 - 0.9, 100 k Omega) = 0.27 m A + 0.018 m A = 0.288 m A$
  ]
]

=

==

#solution[
  #align(center)[
    $v_+ = 0,\ v_- = 0$

    $i_s = frac(0 - v_b, R_1) => v_b = - R_1 i_s$

    Let B be the node between $R_1, R_2$ and $R_3$

    $frac(v_b, R_1) + frac(v_b, R_2) + frac(v_b - v_o, R_3) = 0$

    $v_o = - i_s R_1 + R_3 + frac(R_1 R_3, R_2)$

    $frac(v_o, i_s) = - R_1 + R_3 + frac(R_1 R_3, R_2)$
  ]
]

==

#solution[
  #align(center)[
    $frac(v_o, i_s) = - R_1 + R_3 + frac(R_1 R_3, R_2) = - 20 k Omega + 40 k Omega + frac(20 k Omega times 40 k Omega, 25 k Omega) = - 20 k Omega + 40 k Omega + 32 k Omega = 52 k Omega$
  ]
]

=

#solution[
  #align(center)[
    $v_- = v_+ => v_o = v_b$

    $frac(v_b - v_a, 6 k Omega) + frac(v_b - v_a, 12 k Omega) + frac(v_b, 6 k Omega) = 0$

    $=>\ 5 v_b - 3 v_a = 0 => v_b = frac(3, 5) v_a$

    $4 m A = frac(v_a, 3 k Omega) + frac(v_a - v_b, 6 k Omega) + frac(v_a - v_b, 12 k Omega)$

    $=>\ 7 v_a - 3 v_b = 48 => 7 v_a - 3(frac(3, 5) v_a) = 48 => v_a = frac(120, 13) V$

    $v_b = v_o = frac(3, 5) v_a = frac(72, 13) V$

    $i_x = frac(v_b, 6 k Omega) = frac(72, 13) slash 6 k Omega = frac(12, 13) m A approx 0.923 m A$
  ]
]

=

#solution[
  #align(center)[
    Let node voltages be $(x_1, x_2, x_3, x_4)$ from left to right on the top rail.

    First op-amp inverting:
    $ => x_2 = - frac(50 Omega, 25 Omega) times V_(s 1) $
    $ => x_2 = - 2 V_(s 1) $

    Second op-amp inverting summer, inputs through $100 k Omega$ from $x_2$ and $50 k Omega$ from $V_(s 2)$ feedback $100 k Omega$ to output $x_3$:

    $ => x_3 = - frac(100 Omega, 100 Omega) x_2 - frac(100 Omega, 50 Omega) V_(s 2) $
    $ => x_3 = - x_2 - 2 V_(s 2) $

    Penultimate op-amp no input current to right op-amp (+) node => no current in series $100 k Omega$:
    $ x_4 = x_3 $

    Right op-amp non-inverting gain $(1 + frac(100 k Omega, 50 k Omega) = 3)$:
    $ v_o = 3 x_4 = 3 x_3 = 3(- x_2 - 2 V_(s 2)) = 3(2 V_(s 1) - 2 V_(s 2)) $

    $ v_o = 6 V_(s 1) - 6 V_(s 2) $
  ]
]

=

#solution[
  since $v_L (t) = L frac(d i_L (t), d t)$ and $i_L (t) = 0$ for $t < 0$ and $t > 12 mu s$, we have

  $
    v_L (t) = cases(
      10 times 10^(-3) times 4000 = 40 "V" & 0 <= t <= 5 mu s,
      10 times 10^(-3) times (-4000) = -40 "V" & 5 mu s < t <= 10 mu s,
      0 & t > 10 mu s
    )
  $
  #figure(
    canvas({
      plot.plot(
        size: (10, 5),
        x-tick-step: 2,
        y-tick-step: 20,
        x-min: 0,
        x-max: 12,
        y-min: -50,
        y-max: 50,
        x-label: [Time (μs)],
        y-label: [$v_L$ (V)],
        {
          plot.add(
            ((0, 40), (5, 40), (5, -40), (10, -40), (10, 0), (12, 0)),
            style: (stroke: blue + 2pt),
          )
          plot.add-hline(0, style: (stroke: (dash: "dashed", paint: gray)))
        },
      )
    }),
    caption: [ $v_L (t)$ ],
  )

  since $p_L (t) = v_L (t) times i(t)$ we have

  $
    p_L (t) = cases(
      p_L = 40 times 4t times 10^(-3) =0.16t "W" & 0 <= t <= 5 mu s,
      p_L = -40 times (-4t + 40) times 10^(-3) = 0.16t - 1.6 "W" & 5 mu s < t <= 10 mu s,
      0 & t > 10 mu s
    )
  $

  #figure(
    canvas({
      plot.plot(
        size: (10, 5),
        x-tick-step: 2,
        y-tick-step: 0.4,
        x-min: 0,
        x-max: 12,
        y-min: -1,
        y-max: 1,
        x-label: [Time (μs)],
        y-label: [$p_L$ (W)],
        {
          plot.add(
            ((0, 0), (5, 0.8), (5, -0.8), (10, 0), (12, 0)),
            style: (stroke: red + 2pt),
          )
          plot.add-hline(0, style: (stroke: (dash: "dashed", paint: gray)))
        },
      )
    }),
    caption: [ $p_L (t)$ ],
  )

  since  $w_L (t) = 1/2 L i^2(t)$ we have
  $
    w_L (t) = cases(
      1/2 times 10 times 10^(-3) times (4t times 10^(-3))^2 = 8 times 10^(-8) t^2 "J" & 0 <= t <= 5 mu s,
      1/2 times 10 times 10^(-3) times ((-4t + 40) times 10^(-3))^2 = 8 times 10^(-8) (t - 10)^2 "J" & 5 mu s < t <= 10 mu s,
      0 & t > 10 mu s
    )
  $

  #figure(
    canvas({
      plot.plot(
        size: (10, 5),
        x-tick-step: 2,
        y-tick-step: 0.5,
        x-min: 0,
        x-max: 12,
        y-min: 0,
        y-max: 2.5,
        x-label: [Time (μs)],
        y-label: [$w_L$ (μJ)],
        {
          plot.add(
            x => {
              if x <= 5 {
                0.08 * x * x
              } else if x <= 10 {
                0.08 * calc.pow(x - 10, 2)
              } else {
                0
              }
            },
            domain: (0, 12),
            samples: 200,
            style: (stroke: green + 2pt),
          )
        },
      )
    }),
    caption: [ $w_L (t)$ ],
  )
]

=

#solution[
  #align(center)[

    $ v_L (t) = L frac(d i_L (t), d t) = 0.1 times (-1) e^(-10 t) = -0.1 e^(-10 t)  V$

    $ p_L (t) = v_L (t) times i_L (t) = (-0.1 e^(-10 t)) (0.1 e^(-10 t)) = -0.01 e^(-20 t)  W$

    $ w_L (t) = 1/2 L i_L^2 (t) = 1/2 times 0.1 times (0.1 e^(-10 t))^2 = 5 times 10^(-4) e^(-20 t)  J $

    Since $p_L (t) < 0$ for all $t > 0$, the inductor is delivering power.
  ]
]

=

#solution[
  #align(center)[
    since in parallel, same voltage: $ v_R (t) = v_L (t) = L frac(d i_L (t), d t) = 0.1 times (-1000) times 0.02 e^(-1000 t) = -2 e^(-1000 t)  V$

    $ i_R (t) = frac(v_R (t), R) = frac(-2 e^(-1000 t), 33 k Omega) approx -60.6 mu A times e^(-1000 t) $
  ]
]

=

#solution[
  #align(center)[
    $ i(t) = C frac(d v_C (t), d t) = 3.3 mu F times (-10 times 2000) sin(2000 t) = -0.066 sin(2000 t)  A$

    $ v_R (t) = i(t) R = (-0.066) times 1 k Omega times sin(2000 t) = -66 sin(2000 t)  V $

    $= 66 cos(2000 t - pi/2)  V$
  ]
]

=

#solution[
  #align(center)[
    $(10+3.3) parallel (1+2.2) mu F$
    $ = (13.3 times 3.2) / (13.3 + 3.2) mu F$
    $ approx 2.58 mu F$
  ]
]


#solution[
  #align(center)[
    $150+(25+50 parallel (100 parallel 100)) mu F$
    $ = 150+(25+50 parallel 50) mu F$
    $ = 150+((75 times 50) / (75 + 50)) mu F$
    $ = 150+30 = 180 mu F$
  ]
]

=

#solution[
  #align(center)[
    Left Capacitors: $10 + (6 parallel 3) mu F$
    $=> C_(E Q) = (10 + (6 parallel 3)) = 10 + 2 = 12 mu F$

    Right inductors: $0.5 + (3 parallel 3) mu H$
    $=> L_(E Q) = (0.5 + (3 parallel 3)) = 0.5 + 1.5 = 2 mu H$
  ]
]

=

==

#solution[
  #align(center)[
    since we have an inverting summer
    $V_o = -R_f times (frac(V_1, R_1) + frac(V_2, R_2) + frac(V_3, R_3) + frac(V_4, R_4))$
  ]
]

==

#solution[
  #align(center)[
    We want to have $2V$ at $1111_2$. pick $1V$ reference voltage.
    
    Weight should be $M S B - 8 - 4 - 2 - 1 - L S B$

    $2 = - R_f times (frac(1+1+1+1, 8 + 4 + 2 + 1 + R_n))$

    $R_f / R_n =  2/15 $

    Pick $R_4 ("LSB") = 10 k Omega$ so $R_f = 2/15 times 10 k Omega = 1.333 k Omega$

    Then #table(
      columns: 2,
      [Resistor], [Value],
      [$R_1$], [$1.25 k Omega$],
      [$R_2$], [$2.5 k Omega$],
      [$R_3$], [$5 k Omega$],
      [$R_4$], [$10 k Omega$],
      [$R_f$], [$(2/15) k Omega$],
    )
  ]
]
