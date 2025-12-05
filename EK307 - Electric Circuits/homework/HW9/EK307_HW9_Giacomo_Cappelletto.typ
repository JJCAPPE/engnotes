#import "lib.typ": *
#import "@preview/mannot:0.2.2": markrect

// Homework Template Configuration
#show: template.with(
  title: [Homework 9],
  short_title: "EK307",
  description: [
    EK307
  ],
  date: datetime.today(),
  authors: (
    (
      name: "Giacomo Cappelletto",
      // link: "mailto:your.email@university.edu", // Optional: add your email
    ),
  ),

  // Simplified settings for homework
  toc: false,
  lof: false,
  lot: false,
  lol: false,
  show_dates: false,
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
#set math.equation(numbering: none)

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

=
==
#solution[
  $v(t) = 20 e^(- i 60°)$

  $v(t) = 20 cos(- 60 °) + i 20 sin(- 60 °) = 10 - 10 sqrt(3) i$

  $ markrect(10 - 10 sqrt(3) i) $
]

==
#solution[
  $ v(t) = 10 e^(i 180°) $

  $v(t) = 10 cos(180 °) + i 10 sin(180 °) = -10$

  $ markrect(-10) $
]

==
#solution[
  $ i(t) = -4 e^(i 0°) + 3 e^(-i 90°) $

  $i(t) = -4 cos(0 °) - i 4 sin(0 °) + 3 cos(-90 °) + i 3 sin(-90 °) = -4 - 3 i$

  $ markrect(-4 - 3 i) $
]

=
==

#solution[
  $6-8 i => arctan(frac(-8, 6)) = -53.13° => theta = -53.13° , sqrt(6^2 + 8^2) = 10 => = 10 e^(-i 53.13°)$

  $2 + i => arctan(frac(1, 2)) = 26.56° => theta = 26.56° , sqrt(2^2 + 1^2) = sqrt(5) => sqrt(5) e^(i 26.56°)$

  $frac(3 angle 60, sqrt(5) angle 26.56°) = frac(3 e^(i 60°), sqrt(5) e^(i 26.56°)) = frac(3, sqrt(5)) e^(i (60° - 26.56°)) = frac(3, sqrt(5)) e^(i 33.44°) = frac(3, sqrt(5)) angle 33.44°$

  $frac(3, sqrt(5)) angle 33.44° dot 5 angle 30° = frac(3, sqrt(5)) dot 5 e^(i (33.44° + 30°)) = frac(15, sqrt(5)) e^(i 63.44°) = frac(15, sqrt(5)) angle 63.44°$

  $10 angle -53.13° dot 5 angle 30° = 50 e^(i (-53.13° + 30°)) = 50 e^(-i 23.13°) = 50 angle -23.13°$

  $ 50 angle -23.13° + frac(15, sqrt(5)) angle 63.44° $

  $ 50 angle -23.13° = 50 cos(-23.13°) + i dot 50 sin(-23.13°) = 45.98 - 19.64 i $

  $ frac(15, sqrt(5)) angle 63.44° = 6.708 cos(63.44°) + i dot 6.708 sin(63.44°) = 3.0 + 6.0 i $

  $ (45.98 + 3.0) + i(-19.64 + 6.0) = 48.98 - 13.64 i $

  $ sqrt(48.98^2 + 13.64^2) = 50.84 , quad arctan(frac(-13.64, 48.98)) = -15.56° $

  $ markrect(50.84 angle -15.56°) $
]

==
#solution[
  $ (2 + i 6) - (5 + i) = (2 - 5) + i(6 - 1) = -3 + i 5 $

  $sqrt((-3)^2 + 5^2) = sqrt(9 + 25) = sqrt(34) approx 5.831$

  Angle: Since real part is negative and imaginary is positive, we're in Q2:

  $ theta = 180° - arctan(5/3) = 180° - 59.04° = 120.96° $

  $ therefore -3 + i 5 = sqrt(34) angle 120.96° $

  $ (10 angle 60°)(35 angle -50°) = (10 dot 35) angle (60° + (-50°)) = 350 angle 10° $

  $
    frac(350 angle 10°, sqrt(34) angle 120.96°) = frac(350, sqrt(34)) angle (10° - 120.96°) = frac(350, sqrt(34)) angle -110.96°
  $

  $ frac(350, sqrt(34)) = frac(350, 5.831) approx 60.02 $

  $ markrect(60.02 angle -110.96°) $

  $ 60.02 angle -110.96° = 60.02 cos(-110.96°) + i dot 60.02 sin(-110.96°) $

  $ = 60.02(-0.358) + i dot 60.02(-0.934) = markrect(-21.49 - i 56.06) $
]

=

==

#solution[
  $[ 3 cos(10°) - 5 cos(-30°) ] + [ 3 sin(10°) - 5 sin(-30°) ] i$

  $= (3 dot 0.985 - 5 dot 0.866) + (3 dot 0.174 - 5 dot (-0.5)) i$

  $= (2.955 - 4.33) + (0.522 + 2.5) i$

  $= -1.375 + 3.022 i$

  $theta = 180° + arctan(frac(3.022, -1.375)) = 180° - 65.5° = 114.5°$

  $ sqrt((-1.375)^2 + (3.022)^2) = sqrt(1.890625 + 9.132484) = sqrt(11.023109) approx 3.32 $

  $ = markrect(3.32 cos(20t + 114.5°)) $
]

==

#solution[
  $ 40 sin(50t) = 40 cos(50t - 90°) $

  $ 40 angle -90° + 30 angle -45° $

  $ [40 cos(-90°) + 30 cos(-45°)] + [40 sin(-90°) + 30 sin(-45°)] i $

  $ = (0 + 21.21) + (-40 - 21.21) i $

  $ = 21.21 - 61.21 i $

  $ sqrt(21.21^2 + 61.21^2) = sqrt(450.06 + 3746.66) = sqrt(4196.72) approx 64.78 $

  $ theta = arctan(frac(-61.21, 21.21)) = -70.9° $

  $ = markrect(64.78 cos(50t - 70.9°)) $
]

==

#solution[
  $ 20 sin(400t) = 20 cos(400t - 90°) $

  $ -5 sin(400t - 20°) = -5 cos(400t - 110°) = 5 cos(400t + 70°) $

  $ 20 angle -90° + 10 angle 60° + 5 angle 70° $

  $ [20 cos(-90°) + 10 cos(60°) + 5 cos(70°)] + [20 sin(-90°) + 10 sin(60°) + 5 sin(70°)] i $

  $ = (0 + 5 + 1.71) + (-20 + 8.66 + 4.70) i $

  $ = 6.71 - 6.64 i $

  $ sqrt(6.71^2 + 6.64^2) = sqrt(45.02 + 44.09) = sqrt(89.11) approx 9.44 $

  $ theta = arctan(frac(-6.64, 6.71)) = -44.7° $

  $ = markrect(9.44 cos(400t - 44.7°)) $
]

=
#solution[
  $ v_s(t) = 50 cos(200t) $

  $ arrow(V_s) = 50 angle 0° $
  $ omega = 200 $

  $ Z_R = 10 $
  $ Z_L = i dot 200 dot 0.02 = i 4 $
  $ Z_C = 1 / (i dot 200 dot 0.005) = - i $

  $ Z_(e q) = 10 + i 4 - i 1 = 10 + i 3 $
  $ |Z_(e q)| = sqrt(10^2 + 3^2) = 10.44 $


  $ theta = arctan(frac(3, 10)) = 16.7° $

  $ arrow(I) = 50 angle 0° / (10.44 angle 16.7°) = 4.79 angle(-16.7°) $
  $ i(t) = markrect(4.79 cos(200t - 16.7°)) $
]

=
#solution[
  $-14 i + 25 i parallel 16 = frac(176 i, 16 + 11 i) times frac(16 - 11 i, 16 - 11 i) = frac (176,377) (11 + 16 i)$

  $frac (176,377) (11 + 16 i) + 4 + 20 i = 3444/377 + (10356 i)/377 = 9.135 + 27.469 i$

  $arrow(I) = arrow(V) / arrow(Z) = 12 / (9.135 + 27.469 i) = (287 - 863 i)/2194 = 0.1308 -0.3933 i$

  $theta = arctan(frac(-0.3933, 0.1308)) = -71.6°$

  $I_o = sqrt(0.1308^2 + 0.3933^2) = 0.41448$

  $
    i(t) = 0.41448 cos(10t - 71.6°) A
  $
]

=

#solution[
  $ Z_C = frac(1, j omega C) = frac(1, j 200 dot 50 dot 10^(-6)) = -j 100 $

  $
    Z_"par" = frac(50 dot Z_C, 50 + Z_C) = frac(50(-j 100), 50 - j 100) = 40 - j 20 quad (|Z_"par"| = 44.72, theta = -26.57°)
  $

  $ Z_L = j omega L = j 200 dot 0.1 = j 20 $

  $ arrow(V)_o = 60 dot frac(Z_L, Z_"par" + Z_L) = 60 dot frac(j 20, 40 - j 20 + j 20) = 60 dot frac(j 20, 40) = j 30 $

  $ |arrow(V)_o| = 30, quad theta = 90° $

  $ v_o (t) = markrect(30 cos(200 t + 90°)) "V" $
]

=

#solution[
  $ Z_C = frac(1, j omega C) = frac(1, j 377 dot 50 dot 10^(-6)) = -j 53.05 quad (|Z_C| = 53.05, theta = -90°) $

  $ Z_L = j omega L = j 377 dot 60 dot 10^(-3) = j 22.62 quad (|Z_L| = 22.62, theta = 90°) $

  $
    Z_"par" = frac(Z_L dot 40, Z_L + 40) = frac(j 22.62 dot 40, j 22.62 + 40) = 9.69 + j 17.14 quad (|Z_"par"| = 19.69, theta = 60.51°)
  $

  $ Z_"eq" = 12 + Z_C + Z_"par" = 12 + (-j 53.05) + (9.69 + j 17.14) $

  $ Z_"eq" = (12 + 9.69) + j(-53.05 + 17.14) = 21.69 - j 35.91 $

  $ |Z_"eq"| = sqrt(21.69^2 + 35.91^2) = 41.95 $

  $ theta = arctan(frac(-35.91, 21.69)) = -58.87° $

  $ markrect(Z_"eq" = 41.95 angle -58.87°) $
]

=

#solution[
  $ Z_"top" = 4 - j 6 quad (|Z_"top"| = 7.21, theta = -56.31°) $

  $ Z_"bot" = 3 + j 4 quad (|Z_"bot"| = 5.0, theta = 53.13°) $

  $
    Z_"par" = frac(Z_"top" dot Z_"bot", Z_"top" + Z_"bot") = frac((4 - j 6)(3 + j 4), (4 - j 6) + (3 + j 4)) = frac((12 + 16j - 18j + 24), 7 - j 2)
  $

  $ Z_"par" = frac(36 - j 2, 7 - j 2) = 4.83 + j 1.09 quad (|Z_"par"| = 4.95, theta = 12.77°) $

  $ Z_"eq" = 2 + Z_"par" = 2 + 4.83 + j 1.09 = 6.83 + j 1.09 quad (|Z_"eq"| = 6.92, theta = 9.10°) $

  $ arrow(I) = 10 + frac(j 10, Z_"eq") = 10 + frac(j 10, 6.83 + j 1.09) = 10.23 + j 1.43 $

  $ |arrow(I)| = 10.33, quad theta = 7.94° $

  $ markrect(arrow(I) = 10.33 angle 7.94° "A") $
]
// End of homework
#v(2em)
#align(center)[
  #line(length: 30%, stroke: 0.5pt)

  *End of Homework 1*
]
