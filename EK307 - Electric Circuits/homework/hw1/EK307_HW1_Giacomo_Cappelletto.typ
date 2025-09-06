#import "lib.typ": *

// Homework Template Configuration
#show: template.with(
  title: [1],
  short_title: "EK307 HW",
  description: [
    EK307 - Electric Circuits \ Homework 1
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
    [*Solution:*\ #body]
  )
  v(1em)
}



= // Question 1
== // Subquestion a
#solution[
  $ i(t) = d/d t (3t + 8) "mC" = 3 "mA" $
]
== // Subquestion b
#solution[
  $ i(t) = d/d t (8t^2 + 4t - 2) C = (16t + 4) A $
]
== // Subquestion c
#solution[
  $ i(t) = d/d t (3e^(-t) - 5e^(-2t)) "nC" = (-3e^(-t) + 10e^(-2t)) "nA" $
]
== // Subquestion d
#solution[
  $ i(t) = d/d t (10 sin(120 pi t)) "pC" = 1200 pi cos(120 pi t) "pA" $
]
== // Subquestion e
#solution[
  $ i(t) = d/d t (20e^(-4t) cos(50t)) "μC" = -20e^(-4t)(4cos(50t) + 50sin(50t)) "μA" $
]

= // Question 2
== // Subquestion a
#solution[
  At $t = 1 "ms"$, current is the slope of the line:
  $ i = (d q)/(d t) = (30 "mC") / (2 "ms") = 15 A $
]
== // Subquestion b
#solution[
  At $t = 6 "ms"$, the graph is flat, so the slope is zero:
  $ i = 0 A $
]
== // Subquestion c
#solution[
  At $t = 10 "ms"$, current is the slope of the line:
  $ i = (d q)/(d t) = (-30 "mC") / (4 "ms") = -7.5 A $
]

= // Question 3
#solution[
  $ Q = integral i(t) d t $
  $ Q = (1/2 dot "base" dot "height")_"triangle" + ("width" dot "height")_"rectangle" $
  $ Q = (1/2 dot 1"ms" dot 10"mA") + (1"ms" dot 10"mA") $
  $ Q = 5 "μC" + 10 "μC" = 15 "μC" $
]

= // Question 4
#solution[
  $ Q = I times t = (90 times 10^(-3) A) times (12 h times 3600 s/h) = 3888 C $
  $ W = V times Q = 1.5 V times 3888 C = 5832 J $
]

= // Question 5
#solution[
  $ Q = I times t = (40 times 10^3 A) times (1.7 times 10^(-3) s) = 68 C $
]

= // Question 6
== // Subquestion a
#solution[
  $ W_"total" = (200W)(18h) + (800W)(2h)  (1200W)(4h)  $
  $ W_"total" = 10000 "Wh" = 10 "kWh" $
]
== // Subquestion b
#solution[
  $ P_"avg" = "Total Energy" / "Total Time" = (10000 "Wh") / (24 "h") approx 417 "W" $
]

= // Question 7
== // Subquestion a
#solution[
  *Current `i`*:
  $ 8 A = 2 A + i ==> i = 6 A $

]
== // Subquestion b
#solution[
  $ sum P = -8A times 9V + 6A times 9V + 2A times 3V + 2A times 6V = $
  $ sum P = -72 W + 54 W + 6 W + 12 W = 0 W $
]

// End of homework
#v(2em)
#align(center)[
  #line(length: 30%, stroke: 0.5pt)
  
  *End of Homework 1*
] 