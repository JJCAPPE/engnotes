#import "lib.typ": *
#import "@preview/cetz:0.4.2": canvas, draw

#show: template.with(
  title: [EC311: Logic Design],
  short_title: "EC311",
  description: [
    Lecture notes for Logic Design
  ],
  date: datetime.today(),
  authors: (
    (
      name: "Giacomo Cappelletto",
      // link: "https://your-website.com", // Uncomment and add your link if desired
    ),
  ),

  lof: true, // Uncomment for list of figures
  // lot: true,  // Uncomment for list of tables
  // lol: true,  // Uncomment for list of listings
  paper_size: "a4",
  // landscape: true,  // Uncomment for landscape orientation
  cols: 1,
  text_font: "STIX Two Text",
  code_font: "DejaVu Sans Mono",
  accent: "#DC143C", // Crimson red - change to your preferred color
  h1-prefix: "Chapter",
  colortab: false,
)

// Enable section numbering
#set heading(numbering: "1.1.1.")

= Introduction to Logic Design

Digital logic design is the foundation of modern computing systems, from simple embedded controllers to complex processors. This course covers the systematic approach to designing digital circuits using Boolean algebra, logic gates, and systematic design methodologies.

== Design Flow Overview

#definition("Digital System Design Flow")[
  The modern digital design process follows a structured approach:
  *Analog Input* → *ADC* → *Device* → *Digitized Data* → *Processing*

  This flow transforms real-world analog signals into digital representations that can be processed by digital logic circuits.
]

== System Hierarchy

Digital systems are organized in a hierarchical structure for manageable design:

#figure(
  canvas(length: 1cm, {
    import draw: *
    import "../jsk-lecnotes/cirCeTZ/circuitypst.typ": node

    // Anatomy of Complex Digital System - improved spacing
    let box_width = 4.0
    let box_height = 1.4
    let spacing_y = 2.2
    let left_col = 0
    let right_col = 6

    // Title
    content((5, 15), text(14pt, weight: "bold", fill: purple)[Anatomy of an Example Complex Digital System])

    // Computer level
    rect(
      (left_col, 6 * spacing_y),
      (left_col + box_width, 6 * spacing_y + box_height),
      fill: blue.lighten(85%),
      stroke: 2pt + blue,
    )
    content((left_col + box_width / 2, 6 * spacing_y + box_height / 2 + 0.3), text(12pt, weight: "bold")[*Computer*])
    content((left_col + box_width / 2, 6 * spacing_y + box_height / 2 - 0.3), text(10pt)[iPad v1])

    // PCB level
    rect(
      (left_col, 4.5 * spacing_y),
      (left_col + box_width, 4.5 * spacing_y + box_height),
      fill: green.lighten(85%),
      stroke: 2pt + green,
    )
    content((left_col + box_width / 2, 4.5 * spacing_y + box_height / 2 + 0.4), text(
      12pt,
      weight: "bold",
    )[*Circuit Board (PCB)*])
    content((left_col + box_width / 2, 4.5 * spacing_y + box_height / 2), text(10pt)[~8 / system])
    content((left_col + box_width / 2, 4.5 * spacing_y + box_height / 2 - 0.4), text(
      10pt,
      weight: "bold",
      fill: red,
    )[1-2B devices])

    // IC level
    rect(
      (right_col, 4.5 * spacing_y),
      (right_col + box_width, 4.5 * spacing_y + box_height),
      fill: orange.lighten(85%),
      stroke: 2pt + orange,
    )
    content((right_col + box_width / 2, 4.5 * spacing_y + box_height / 2 + 0.4), text(
      12pt,
      weight: "bold",
    )[*Integrated Circuit (IC)*])
    content((right_col + box_width / 2, 4.5 * spacing_y + box_height / 2), text(10pt)[~8-16 / PCB])
    content((right_col + box_width / 2, 4.5 * spacing_y + box_height / 2 - 0.4), text(10pt)[0.25M-16M devices])

    // Module level
    rect(
      (right_col, 3 * spacing_y),
      (right_col + box_width, 3 * spacing_y + box_height),
      fill: purple.lighten(85%),
      stroke: 2pt + purple,
    )
    content((right_col + box_width / 2, 3 * spacing_y + box_height / 2 + 0.3), text(12pt, weight: "bold")[*Module*])
    content((right_col + box_width / 2, 3 * spacing_y + box_height / 2), text(10pt)[~8-16 / IC])
    content((right_col + box_width / 2, 3 * spacing_y + box_height / 2 - 0.3), text(10pt)[100K devices])

    // Cell level
    rect(
      (left_col, 1.5 * spacing_y),
      (left_col + box_width, 1.5 * spacing_y + box_height),
      fill: red.lighten(85%),
      stroke: 2pt + red,
    )
    content((left_col + box_width / 2, 1.5 * spacing_y + box_height / 2 + 0.4), text(12pt, weight: "bold")[*Cell*])
    content((left_col + box_width / 2, 1.5 * spacing_y + box_height / 2), text(10pt)[~1K-10K / Module])
    content((left_col + box_width / 2, 1.5 * spacing_y + box_height / 2 - 0.4), text(10pt)[16-64 devices])

    // Gate level
    rect(
      (right_col, 1.5 * spacing_y),
      (right_col + box_width, 1.5 * spacing_y + box_height),
      fill: yellow.lighten(70%),
      stroke: 2pt + olive,
    )
    content((right_col + box_width / 2, 1.5 * spacing_y + box_height / 2 + 0.3), text(12pt, weight: "bold")[*Gate*])
    content((right_col + box_width / 2, 1.5 * spacing_y + box_height / 2), text(10pt)[~2-16 / Cell])
    content((right_col + box_width / 2, 1.5 * spacing_y + box_height / 2 - 0.3), text(10pt)[8 devices])

    // Transistor level
    rect(
      (left_col, 0 * spacing_y),
      (left_col + box_width, 0 * spacing_y + box_height),
      fill: gray.lighten(80%),
      stroke: 2pt + black,
    )
    content((left_col + box_width / 2, 0 * spacing_y + box_height / 2 + 0.3), text(12pt, weight: "bold")[*Transistor*])
    content((left_col + box_width / 2, 0 * spacing_y + box_height / 2 - 0.3), text(10pt)[MOSFET])

    // Information representation scheme
    rect(
      (right_col, 0 * spacing_y),
      (right_col + box_width, 0 * spacing_y + box_height),
      fill: black.lighten(90%),
      stroke: 2pt + black,
    )
    content((right_col + box_width / 2, 0 * spacing_y + box_height / 2 + 0.4), text(11pt, weight: "bold")[*Scheme for*])
    content((right_col + box_width / 2, 0 * spacing_y + box_height / 2 + 0.1), text(
      11pt,
      weight: "bold",
    )[*representing information*])
    content((right_col + box_width / 2, 0 * spacing_y + box_height / 2 - 0.3), text(
      10pt,
      font: "DejaVu Sans Mono",
    )[0 0 1 0 1 1])

    // Arrows connecting levels with improved spacing
    let arrow_style = (thickness: 3pt, paint: red)

    // Computer to PCB
    line(
      (left_col + box_width / 2, 6 * spacing_y),
      (left_col + box_width / 2, 4.5 * spacing_y + box_height + 0.15),
      stroke: arrow_style,
    )
    line(
      (left_col + box_width / 2 - 0.15, 4.5 * spacing_y + box_height + 0.3),
      (left_col + box_width / 2, 4.5 * spacing_y + box_height + 0.15),
      stroke: arrow_style,
    )
    line(
      (left_col + box_width / 2 + 0.15, 4.5 * spacing_y + box_height + 0.3),
      (left_col + box_width / 2, 4.5 * spacing_y + box_height + 0.15),
      stroke: arrow_style,
    )

    // PCB to IC (horizontal)
    line(
      (left_col + box_width, 4.5 * spacing_y + box_height / 2),
      (right_col, 4.5 * spacing_y + box_height / 2),
      stroke: arrow_style,
    )
    line(
      (right_col - 0.15, 4.5 * spacing_y + box_height / 2 + 0.15),
      (right_col, 4.5 * spacing_y + box_height / 2),
      stroke: arrow_style,
    )
    line(
      (right_col - 0.15, 4.5 * spacing_y + box_height / 2 - 0.15),
      (right_col, 4.5 * spacing_y + box_height / 2),
      stroke: arrow_style,
    )

    // IC to Module
    line(
      (right_col + box_width / 2, 4.5 * spacing_y),
      (right_col + box_width / 2, 3 * spacing_y + box_height + 0.15),
      stroke: arrow_style,
    )
    line(
      (right_col + box_width / 2 - 0.15, 3 * spacing_y + box_height + 0.3),
      (right_col + box_width / 2, 3 * spacing_y + box_height + 0.15),
      stroke: arrow_style,
    )
    line(
      (right_col + box_width / 2 + 0.15, 3 * spacing_y + box_height + 0.3),
      (right_col + box_width / 2, 3 * spacing_y + box_height + 0.15),
      stroke: arrow_style,
    )

    // Module to Cell (diagonal)
    line(
      (right_col, 3 * spacing_y + box_height / 2),
      (left_col + box_width, 1.5 * spacing_y + box_height / 2),
      stroke: arrow_style,
    )
    line(
      (left_col + box_width - 0.2, 1.5 * spacing_y + box_height / 2 + 0.1),
      (left_col + box_width, 1.5 * spacing_y + box_height / 2),
      stroke: arrow_style,
    )
    line(
      (left_col + box_width - 0.2, 1.5 * spacing_y + box_height / 2 - 0.1),
      (left_col + box_width, 1.5 * spacing_y + box_height / 2),
      stroke: arrow_style,
    )

    // Cell to Gate (horizontal)
    line(
      (left_col + box_width, 1.5 * spacing_y + box_height / 2),
      (right_col, 1.5 * spacing_y + box_height / 2),
      stroke: arrow_style,
    )
    line(
      (right_col - 0.15, 1.5 * spacing_y + box_height / 2 + 0.15),
      (right_col, 1.5 * spacing_y + box_height / 2),
      stroke: arrow_style,
    )
    line(
      (right_col - 0.15, 1.5 * spacing_y + box_height / 2 - 0.15),
      (right_col, 1.5 * spacing_y + box_height / 2),
      stroke: arrow_style,
    )

    // Gate to Transistor (diagonal)
    line((right_col, 1.5 * spacing_y), (left_col + box_width, 0 * spacing_y + box_height), stroke: arrow_style)
    line(
      (left_col + box_width - 0.2, 0 * spacing_y + box_height + 0.05),
      (left_col + box_width, 0 * spacing_y + box_height),
      stroke: arrow_style,
    )
    line(
      (left_col + box_width - 0.05, 0 * spacing_y + box_height - 0.2),
      (left_col + box_width, 0 * spacing_y + box_height),
      stroke: arrow_style,
    )

    // Transistor to Information scheme (horizontal)
    line(
      (left_col + box_width, 0 * spacing_y + box_height / 2),
      (right_col, 0 * spacing_y + box_height / 2),
      stroke: arrow_style,
    )
    line(
      (right_col - 0.15, 0 * spacing_y + box_height / 2 + 0.15),
      (right_col, 0 * spacing_y + box_height / 2),
      stroke: arrow_style,
    )
    line(
      (right_col - 0.15, 0 * spacing_y + box_height / 2 - 0.15),
      (right_col, 0 * spacing_y + box_height / 2),
      stroke: arrow_style,
    )
  }),
  caption: [Complete anatomy of a complex digital system showing hierarchy from computer to transistor level],
) <complex-system-anatomy>

#note("Claude Shannon")[
  Claude Shannon's work in the 1940s established the mathematical foundation for digital logic design, showing how Boolean algebra could be used to analyze and synthesize switching circuits.
]

= Digital Logic Fundamentals

== Basic Logic Elements

Digital circuits are built from fundamental logic gates that perform Boolean operations on binary inputs.

#definition("Logic Gate")[
  A logic gate is a digital circuit that implements a Boolean function. It has one or more binary inputs and produces a single binary output based on the logical relationship defined by the gate type.
]

=== Truth Tables and Boolean Functions

For 2 input variables (X, Y), there are $2^(2^2) = 16$ possible Boolean functions:

#figure(
  table(
    columns: (
      0.6fr,
      0.6fr,
      0.5fr,
      0.5fr,
      0.5fr,
      0.5fr,
      0.5fr,
      0.5fr,
      0.5fr,
      0.5fr,
      0.5fr,
      0.5fr,
      0.5fr,
      0.5fr,
      0.5fr,
      0.5fr,
      0.5fr,
      0.5fr,
    ),
    align: center,
    stroke: 0.8pt,
    inset: 3pt,
    // Header row
    table.header(
      [*X*],
      [*Y*],
      [$F_0$],
      [$F_1$],
      [$F_2$],
      [$F_3$],
      [$F_4$],
      [$F_5$],
      [$F_6$],
      [$F_7$],
      [$F_8$],
      [$F_9$],
      [$F_(10)$],
      [$F_(11)$],
      [$F_(12)$],
      [$F_(13)$],
      [$F_(14)$],
      [$F_(15)$],
    ),

    // Truth table rows
    [0], [0], [0], [0], [0], [0], [0], [0], [0], [0], [1], [1], [1], [1], [1], [1], [1], [1],
    [0], [1], [0], [0], [0], [0], [1], [1], [1], [1], [0], [0], [0], [0], [1], [1], [1], [1],
    [1], [0], [0], [0], [1], [1], [0], [0], [1], [1], [0], [0], [1], [1], [0], [0], [1], [1],
    [1], [1], [0], [1], [0], [1], [0], [1], [0], [1], [0], [1], [0], [1], [0], [1], [0], [1],
  ),
  caption: [Complete truth table showing all 16 possible Boolean functions (F₀-F₁₅) for inputs X and Y],
) <complete-truth-table>

#figure(
  table(
    columns: (1fr, 2fr, 3fr, 1fr, 2fr, 3fr),
    align: left,
    stroke: none,
    // Function identifications in two columns - corrected
    [$F_0 =$], [0], [(Always FALSE)], [$F_8 =$], [$overline(X + Y)$], [(X NOR Y)],
    [$F_1 =$], [$X dot Y$], [(X AND Y)], [$F_9 =$], [$overline(X plus.circle Y)$], [(X XNOR Y)],
    [$F_2 =$], [$X dot overline(Y)$], [(X AND NOT Y)], [$F_(10) =$], [$overline(Y)$], [(NOT Y)],
    [$F_3 =$], [$X$], [(Copy X)], [$F_(11) =$], [$X + overline(Y)$], [(X OR NOT Y)],
    [$F_4 =$], [$overline(X) dot Y$], [(NOT X AND Y)], [$F_(12) =$], [$overline(X)$], [(NOT X)],
    [$F_5 =$], [$Y$], [(Copy Y)], [$F_(13) =$], [$overline(X) + Y$], [(NOT X OR Y)],
    [$F_6 =$], [$X plus.circle Y$], [(X XOR Y)], [$F_(14) =$], [$overline(X dot Y)$], [(X NAND Y)],
    [$F_7 =$], [$X + Y$], [(X OR Y)], [$F_(15) =$], [1], [(Always TRUE)],
  ),
  caption: [Complete identification of all 16 Boolean functions with their logical expressions],
) <function-identifications>

=== Standard Logic Gates

#figure(image("logicgates.png", width: 65%))

=== Boolean Expressions

#example("XOR and XNOR Expressions")[
  The XOR and XNOR gates have expanded Boolean forms:

  - *XOR*: $Z = X plus.circle Y = X dot overline(Y) + overline(X) dot Y$
  - *XNOR*: $Z = overline(X plus.circle Y) = X dot Y + overline(X) dot overline(Y)$

  These expressions show that XOR outputs 1 when inputs differ, while XNOR outputs 1 when inputs are the same.
]

=== Decimal to BCD and Binary to BCD (Double‑Dabble)

#definition("Binary‑Coded Decimal (BCD)")[
  BCD encodes each decimal digit (0–9) in 4 bits. For example,
  2 → 0010, 4 → 0100, 3 → 0011.
]

#example("Decimal → BCD")[
  Encode each decimal digit independently: 243 → 2|4|3 →
  0010 0100 0011.
]

#example("Binary → BCD with double‑dabble")[
  Convert an n‑bit binary number to BCD by repeating for each bit (MSB→LSB):
  1) If any BCD nibble ≥ 5, add 3 to that nibble.
  2) Shift the entire BCD register left by 1 and shift in the next input bit.
  After all shifts, the BCD nibbles are the decimal digits.

  Tiny example for 243₁₀ = 11110011₂ (8 bits):
  - Ones nibble hits 7 → add 3 → 10 before shifting
  - Later ones hits 5 → add 3 → 8
  - Tens hits 6 → add 3 → 9
  After 8 shifts: BCD = 0010 0100 0011 → digits 2 4 3.
]

#figure(
  table(
    columns: (2.4fr, 1.6fr, 2.2fr),
    align: left,
    stroke: none,
    inset: 2pt,
    [#text(10pt, font: "DejaVu Sans Mono")[0000 0000 0000]],
    [#text(10pt, font: "DejaVu Sans Mono")[11110011]],
    [Initialization],

    [#text(10pt, font: "DejaVu Sans Mono")[0000 0000 0001]], [#text(10pt, font: "DejaVu Sans Mono")[11100110]], [Shift],
    [#text(10pt, font: "DejaVu Sans Mono")[0000 0000 0011]], [#text(10pt, font: "DejaVu Sans Mono")[11001100]], [Shift],
    [#text(10pt, font: "DejaVu Sans Mono")[0000 0000 0111]], [#text(10pt, font: "DejaVu Sans Mono")[10011000]], [Shift],
    [#text(10pt, font: "DejaVu Sans Mono")[0000 0000 1010]],
    [#text(10pt, font: "DejaVu Sans Mono")[10011000]],
    [Add 3 to ONES (was 7)],

    [#text(10pt, font: "DejaVu Sans Mono")[0000 0001 0101]], [#text(10pt, font: "DejaVu Sans Mono")[00110000]], [Shift],
    [#text(10pt, font: "DejaVu Sans Mono")[0000 0001 1000]],
    [#text(10pt, font: "DejaVu Sans Mono")[00110000]],
    [Add 3 to ONES (was 5)],

    [#text(10pt, font: "DejaVu Sans Mono")[0000 0011 0000]], [#text(10pt, font: "DejaVu Sans Mono")[01100000]], [Shift],
    [#text(10pt, font: "DejaVu Sans Mono")[0000 0110 0000]], [#text(10pt, font: "DejaVu Sans Mono")[11000000]], [Shift],
    [#text(10pt, font: "DejaVu Sans Mono")[0000 1001 0000]],
    [#text(10pt, font: "DejaVu Sans Mono")[11000000]],
    [Add 3 to TENS (was 6)],

    [#text(10pt, font: "DejaVu Sans Mono")[0001 0010 0001]], [#text(10pt, font: "DejaVu Sans Mono")[10000000]], [Shift],
    [#text(10pt, font: "DejaVu Sans Mono")[0010 0100 0011]], [#text(10pt, font: "DejaVu Sans Mono")[00000000]], [Shift],
  ),
  caption: [Double‑dabble run for 243₁₀ (11110011₂). Left: BCD register; Right: original register. Transparent grid mimics textbook layout. Result: 0010 0100 0011 → digits 2 4 3.],
) <double-dabble-243>

== Digital Logic Systems

#definition("Types of Digital Logic Systems")[
  - *Combinational Logic*: Output depends only on the current inputs, memoryless
  - *Sequential Logic*: Output depends on current inputs and previous states, has memory

  #canvas(length: 1cm, {
    import draw: *
    // Combinational: Input -> [Combinational Logic] -> Output
    rect((2, 1.0), (4, 2.0), fill: gray.lighten(85%), stroke: 2pt + black)
    content((3, 1.5), text(10pt, weight: "bold")[Combinational Logic])

    // Input label and arrow
    content((0.6, 1.5), text(10pt, weight: "bold")[Input])
    line((1.1, 1.5), (2, 1.5), stroke: 2pt + black)
    line((1.85, 1.65), (2, 1.5), stroke: 2pt + black)
    line((1.85, 1.35), (2, 1.5), stroke: 2pt + black)

    // Output label and arrow
    line((4, 1.5), (4.8, 1.5), stroke: 2pt + black)
    line((4.65, 1.65), (4.8, 1.5), stroke: 2pt + black)
    line((4.65, 1.35), (4.8, 1.5), stroke: 2pt + black)
    content((5.1, 1.5), text(10pt, weight: "bold")[Output])
  })

  #canvas(length: 1cm, {
    import draw: *
    // Sequential: input and state -> [Combinational Logic] -> output; next-state -> register -> state

    // Combinational block
    rect((2, 2.2), (4, 3.2), fill: gray.lighten(85%), stroke: 2pt + black)
    content((3, 2.7), text(10pt, weight: "bold")[Combinational Logic])

    // Input label and arrow (left)
    content((0.6, 2.7), text(10pt, weight: "bold")[Input])
    line((1.1, 2.7), (2, 2.7), stroke: 2pt + black)
    line((1.85, 2.85), (2, 2.7), stroke: 2pt + black)
    line((1.85, 2.55), (2, 2.7), stroke: 2pt + black)

    // Output label and arrow (bottom)
    content((2.9, 1.2), text(10pt, weight: "bold")[Output])
    line((3, 2.2), (3, 1.5), stroke: 2pt + black)
    line((2.85, 1.65), (3, 1.5), stroke: 2pt + black)
    line((3.15, 1.65), (3, 1.5), stroke: 2pt + black)

    // Register block to the right
    rect((5, 2.2), (6.2, 3.2), fill: white, stroke: 2pt + black)
    content((5.6, 2.7), text(10pt, weight: "bold")[Register])

    // Next state from combinational to register
    line((4, 2.7), (5, 2.7), stroke: 2pt + black)
    line((4.85, 2.85), (5, 2.7), stroke: 2pt + black)
    line((4.85, 2.55), (5, 2.7), stroke: 2pt + black)
    content((4.5, 2.95), text(8pt)[Next State])

    // Feedback from register to state input (top)
    line((6.2, 2.7), (6.2, 3.9), stroke: 2pt + black)
    line((6.2, 3.9), (2, 3.9), stroke: 2pt + black)
    line((2, 3.9), (2, 3.2), stroke: 2pt + black)
    line((1.85, 3.35), (2, 3.2), stroke: 2pt + black)
    line((2.15, 3.35), (2, 3.2), stroke: 2pt + black)
    content((2.2, 3.95), text(8pt, weight: "bold")[State])
  })
]

=== Combinational Logic Circuits

#definition("Boolean Expression Basics")[
  A Boolean function combines binary variables using logical operations:

  - $a , b , c$ are binary inputs
  - Product (e.g., $a b$) denotes AND
  - Sum (e.g., $a + b$) denotes OR
  - Inversion (e.g., $a'$) denotes NOT

  Example function: $F(a , b , c ) = a'b c + a b'c'$
]

#definition("Canonical Terms")[
  Fundamental terms appearing in Boolean expressions:

  - A variable or its complement is a _literal_
  - $a b c$ is a cube (product term) with 3 literals
  - Minterms are products of all variables (or their complements), e.g., $a b c$, $a' b c$, $a b' c$, $a' b' c$
  - Maxterms are sums of all variables (or their complements), e.g., $a + b + c'$, $a + b' + c'$, $a' + b + c'$, $a' + b' + c'$
]

#definition("Standard Forms")[
  Two common normal forms for Boolean functions:

  - Product of sums (POS): $F(a , b , c ) = (a + b + c')(a + b' + c')$
  - Sum of products (SOP): $F(a , b , c ) = a b c + a' b c + a b' c'$
]


#figure(
  canvas(length: 1cm, {
    import draw: *
    import "../jsk-lecnotes/cirCeTZ/circuitypst.typ": node

    // Title and expression (2-input gates)
    content((0.6, 5.4), text(12pt, weight: "bold")[Two-Level SOP (AND → OR)])
    content((0.6, 5.0), text(11pt)[$F = a b + c d + e f + g h$])

    // Input rails (a..h)
    let x0 = 0.8
    let x1 = 2.2
    let ys = (4.4, 4.0, 3.2, 2.8, 2.0, 1.6, 0.8, 0.4)
    let labels = ("a", "b", "c", "d", "e", "f", "g", "h")
    for i in range(ys.len()) {
      line((x0, ys.at(i)), (x1, ys.at(i)), stroke: 2pt)
      content((x0 - 0.2, ys.at(i)), text(11pt, weight: "bold")[#labels.at(i)])
    }

    // Four 2-input AND gates (pairs: ab, cd, ef, gh)
    node("and gate", (4.6, 4.2), name: "and_ab")
    node("and gate", (4.6, 3.0), name: "and_cd")
    node("and gate", (4.6, 1.8), name: "and_ef")
    node("and gate", (4.6, 0.6), name: "and_gh")

    // Wiring to ANDs
    line((x1, ys.at(0)), "and_ab.in 1", stroke: 2pt)
    line((x1, ys.at(1)), "and_ab.in 2", stroke: 2pt)

    line((x1, ys.at(2)), "and_cd.in 1", stroke: 2pt)
    line((x1, ys.at(3)), "and_cd.in 2", stroke: 2pt)

    line((x1, ys.at(4)), "and_ef.in 1", stroke: 2pt)
    line((x1, ys.at(5)), "and_ef.in 2", stroke: 2pt)

    line((x1, ys.at(6)), "and_gh.in 1", stroke: 2pt)
    line((x1, ys.at(7)), "and_gh.in 2", stroke: 2pt)

    // OR tree (2-input OR gates)
    node("or gate", (7.0, 3.6), name: "or_top")
    node("or gate", (7.0, 1.2), name: "or_bot")
    line("or_top.in 1", "and_ab.out")
    line("or_top.in 2", "and_cd.out")
    line("or_bot.in 1", "and_ef.out")
    line("or_bot.in 2", "and_gh.out")

    node("or gate", (8.8, 2.4), name: "or_final")
    line("or_final.in 1", "or_top.out")
    line("or_final.in 2", "or_bot.out")

    // Output
    line("or_final.out", (rel: (1.2, 0)))
    content((), text(11pt, weight: "bold")[F], anchor: "west")
  }),
  caption: [SOP implementation using only 2-input gates: $F = a b + c d + e f + g h$],
) <two-level-sop>


#figure(
  canvas(length: 1cm, {
    import draw: *
    import "../jsk-lecnotes/cirCeTZ/circuitypst.typ": node

    // Title and expression (2-input gates)
    content((0.6, 5.2), text(12pt, weight: "bold")[Two-Level POS (OR → AND)])
    content((0.6, 4.8), text(11pt)[$F = (a + b)(c + d)(e + f)(g + h)$])

    // Input rails (a..h)
    let x0 = 0.8
    let x1 = 2.2
    let ys = (4.0, 3.6, 2.8, 2.4, 1.6, 1.2, 0.4, 0.0)
    let labels = ("a", "b", "c", "d", "e", "f", "g", "h")
    for i in range(ys.len()) {
      line((x0, ys.at(i)), (x1, ys.at(i)), stroke: 2pt)
      content((x0 - 0.2, ys.at(i)), text(11pt, weight: "bold")[#labels.at(i)])
    }

    // Four 2-input OR gates for sums
    node("or gate", (4.6, 3.8), name: "or_ab")
    node("or gate", (4.6, 2.6), name: "or_cd")
    node("or gate", (4.6, 1.4), name: "or_ef")
    node("or gate", (4.6, 0.2), name: "or_gh")

    // Wiring to ORs
    line((x1, ys.at(0)), "or_ab.in 1", stroke: 2pt)
    line((x1, ys.at(1)), "or_ab.in 2", stroke: 2pt)
    line((x1, ys.at(2)), "or_cd.in 1", stroke: 2pt)
    line((x1, ys.at(3)), "or_cd.in 2", stroke: 2pt)
    line((x1, ys.at(4)), "or_ef.in 1", stroke: 2pt)
    line((x1, ys.at(5)), "or_ef.in 2", stroke: 2pt)
    line((x1, ys.at(6)), "or_gh.in 1", stroke: 2pt)
    line((x1, ys.at(7)), "or_gh.in 2", stroke: 2pt)

    // AND tree combining the four sums
    node("and gate", (7.0, 3.2), name: "and_top")
    node("and gate", (7.0, 0.8), name: "and_bot")
    line("and_top.in 1", "or_ab.out")
    line("and_top.in 2", "or_cd.out")
    line("and_bot.in 1", "or_ef.out")
    line("and_bot.in 2", "or_gh.out")

    node("and gate", (8.8, 2.0), name: "and_final")
    line("and_final.in 1", "and_top.out")
    line("and_final.in 2", "and_bot.out")

    // Output
    line("and_final.out", (rel: (1.2, 0)))
    content((), text(11pt, weight: "bold")[F], anchor: "west")
  }),
  caption: [POS implementation using only 2-input gates: $F = (a + b)(c + d)(e + f)(g + h)$],
) <two-level-pos>


== Modern Technology: MOS and CMOS

#definition("MOSFET Technology")[
  Modern digital circuits primarily use MOSFET (Metal-Oxide-Semiconductor Field-Effect Transistor) technology:

  - *NMOS*: N-channel transistors that conduct when gate is HIGH
  - *PMOS*: P-channel transistors that conduct when gate is LOW
  - *CMOS*: Complementary MOS using both NMOS and PMOS for low power consumption
]

The CMOS inverter we studied earlier demonstrates how these transistors work together to create efficient digital switches with minimal power consumption except during transitions.

= Circuit Analysis and Abstraction

== Abstraction Levels

#note("Design Abstraction")[
  Digital design uses multiple levels of abstraction:

  1. *Behavioral Description*: Specification of what the circuit should do
  2. *Circuit Schematic*: Gate-level implementation
  3. *Hardware Implementation*: Physical realization in silicon

  Each level abstracts away lower-level details while maintaining functionality.
]

== CMOS NOT Gate Implementation

The CMOS (Complementary MOS) NOT gate demonstrates the fundamental principle of modern digital logic design using both NMOS and PMOS transistors.

=== Transistor Operation as Switches

#definition("MOS Transistor Switch Model")[
  MOSFET transistors can be modeled as voltage-controlled switches:

  - *NMOS*: Acts like a switch between drain and source, controlled by gate voltage
    - Gate HIGH (VDD) → Switch CLOSED (conducts)
    - Gate LOW (GND) → Switch OPEN (does not conduct)

  - *PMOS*: Acts like an inverted switch (note the bubble on gate symbol)
    - Gate LOW (GND) → Switch CLOSED (conducts)
    - Gate HIGH (VDD) → Switch OPEN (does not conduct)
]

=== Complete CMOS Inverter Circuit

#figure(
  canvas(length: 2cm, {
    import draw: *

    let circuit_width = 4
    let circuit_height = 6

    // VDD rail
    line((1, circuit_height), (3, circuit_height), stroke: 3pt + black)
    content((0.3, circuit_height), text(12pt, weight: "bold")[VDD])

    // PMOS transistor (top)
    let pmos_center = (2, 4.5)
    let pmos_gate = (1.2, 4.5)

    // PMOS gate line with inversion bubble
    line((0.5, 4.5), (1.1, 4.5), stroke: 2pt)
    circle((1.15, 4.5), radius: 0.05, fill: white, stroke: 2pt)
    line((1.2, 4.5), (1.4, 4.5), stroke: 2pt)

    // PMOS channel (solid line)
    line((1.4, 4.2), (1.4, 4.8), stroke: 2pt)
    line((1.6, 4.2), (1.6, 4.8), stroke: 2pt)

    // PMOS source to VDD
    line((1.6, 4.8), (1.6, circuit_height), stroke: 2pt)

    // PMOS drain connection (to output node)
    line((1.6, 4.2), (1.6, 3.5), stroke: 2pt)

    // NMOS transistor (bottom)
    let nmos_center = (2, 2.5)
    let nmos_gate = (1.2, 2.5)

    // NMOS gate line (no bubble)
    line((0.5, 2.5), (1.4, 2.5), stroke: 2pt)

    // NMOS channel (dashed line for enhancement mode)
    line((1.4, 2.2), (1.4, 2.8), stroke: 2pt)
    line((1.6, 2.2), (1.6, 2.8), stroke: (dash: "dashed", thickness: 2pt))

    // NMOS source to GND
    line((1.6, 2.2), (1.6, 1), stroke: 2pt)

    // NMOS drain connection (to output node)
    line((1.6, 2.8), (1.6, 3.5), stroke: 2pt)

    // Connect gates together (input)
    line((0.5, 4.5), (0.5, 2.5), stroke: 2pt)
    content((0, 3.5), text(12pt, weight: "bold")[INPUT])

    // Output node
    line((1.6, 3.5), (3.5, 3.5), stroke: 2pt)
    content((3.8, 3.5), text(12pt, weight: "bold")[OUTPUT])
    circle((1.6, 3.5), radius: 0.04, fill: black)

    // GND rail
    line((1, 1), (3, 1), stroke: 3pt + black)
    content((0.3, 1), text(12pt, weight: "bold")[GND])

    // Ground symbol
    for i in range(3) {
      let y = 0.9 - i * 0.1
      let width = 0.6 - i * 0.2
      line((2 - width / 2, y), (2 + width / 2, y), stroke: 2pt)
    }

    // Labels for transistor types
    content((0.8, 5), text(11pt, weight: "bold", fill: blue)[PMOS])
    content((0.8, 1.8), text(11pt, weight: "bold", fill: red)[NMOS])

    // Operating principle annotations
    content((4.5, 5), text(10pt, fill: blue)[ON when INPUT = 0])
    content((4.5, 4.7), text(10pt, fill: blue)[OFF when INPUT = 1])
    content((4.5, 2), text(10pt, fill: red)[ON when INPUT = 1])
    content((4.5, 1.7), text(10pt, fill: red)[OFF when INPUT = 0])
  }),
  caption: [CMOS NOT gate schematic showing complementary operation],
) <cmos-not-gate>

=== Switch Model Abstraction

To understand why we need both NMOS and PMOS, consider the resistor abstraction:

#figure(
  canvas(length: 2cm, {
    import draw: *

    let spacing = 4

    // Left side: Input = 0 case
    content((1, 5.5), text(12pt, weight: "bold")[INPUT = 0 (GND)])

    // VDD rail
    line((0.5, 5), (2.5, 5), stroke: 3pt)
    content((0, 5), text(10pt)[VDD])

    // PMOS as closed switch (low resistance)
    rect((1, 4.5), (2, 4.8), fill: green.lighten(70%), stroke: 2pt + green)
    content((1.5, 4.65), text(8pt)[PMOS])
    content((1.5, 4.4), text(8pt, fill: green)[CLOSED])
    line((1.5, 4.8), (1.5, 5), stroke: 2pt)

    // Output connection
    line((1.5, 4.5), (1.5, 3.8), stroke: 2pt)
    line((1.5, 3.8), (3, 3.8), stroke: 2pt)
    content((3.3, 3.8), text(10pt, weight: "bold")[OUT = 1])
    circle((1.5, 3.8), radius: 0.04, fill: black)

    // NMOS as open switch (high resistance)
    rect((1, 3.2), (2, 3.5), fill: red.lighten(70%), stroke: 2pt + red)
    content((1.5, 3.35), text(8pt)[NMOS])
    content((1.5, 3.05), text(8pt, fill: red)[OPEN])
    line((1.5, 3.5), (1.5, 3.8), stroke: 2pt)

    // GND connection
    line((1.5, 3.2), (1.5, 2.5), stroke: 2pt)
    line((1, 2.5), (2, 2.5), stroke: 3pt)
    content((0.7, 2.5), text(10pt)[GND])

    // Right side: Input = 1 case
    content((spacing + 1, 5.5), text(12pt, weight: "bold")[INPUT = 1 (VDD)])

    // VDD rail
    line((spacing + 0.5, 5), (spacing + 2.5, 5), stroke: 3pt)
    content((spacing, 5), text(10pt)[VDD])

    // PMOS as open switch (high resistance)
    rect((spacing + 1, 4.5), (spacing + 2, 4.8), fill: blue.lighten(70%), stroke: 2pt + blue)
    content((spacing + 1.5, 4.65), text(8pt)[PMOS])
    content((spacing + 1.5, 4.4), text(8pt, fill: blue)[OPEN])
    line((spacing + 1.5, 4.8), (spacing + 1.5, 5), stroke: 2pt)

    // Output connection
    line((spacing + 1.5, 4.5), (spacing + 1.5, 3.8), stroke: 2pt)
    line((spacing + 1.5, 3.8), (spacing + 3, 3.8), stroke: 2pt)
    content((spacing + 3.3, 3.8), text(10pt, weight: "bold")[OUT = 0])
    circle((spacing + 1.5, 3.8), radius: 0.04, fill: black)

    // NMOS as closed switch (low resistance)
    rect((spacing + 1, 3.2), (spacing + 2, 3.5), fill: green.lighten(70%), stroke: 2pt + green)
    content((spacing + 1.5, 3.35), text(8pt)[NMOS])
    content((spacing + 1.5, 3.05), text(8pt, fill: green)[CLOSED])
    line((spacing + 1.5, 3.5), (spacing + 1.5, 3.8), stroke: 2pt)

    // GND connection
    line((spacing + 1.5, 3.2), (spacing + 1.5, 2.5), stroke: 2pt)
    line((spacing + 1, 2.5), (spacing + 2, 2.5), stroke: 3pt)
    content((spacing + 0.7, 2.5), text(10pt)[GND])
  }),
  caption: [Switch model showing why both NMOS and PMOS are necessary],
) <switch-model>

=== Why Both Transistor Types Are Essential

#example("Necessity of Complementary Transistors")[
  Each transistor type serves a specific role:

  *PMOS (Pull-up network):*
  - Connects output to VDD when input is LOW
  - Good at "pulling up" to logic 1
  - Poor at "pulling down" to logic 0

  *NMOS (Pull-down network):*
  - Connects output to GND when input is HIGH
  - Good at "pulling down" to logic 0
  - Poor at "pulling up" to logic 1

  *Together they provide:*
  - Strong drive in both directions (full rail-to-rail output)
  - No static current path (one is always OFF)
  - Fast switching with minimal power consumption
]

=== Operation Analysis

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 2fr),
    align: center,
    table.header[*INPUT*][*PMOS*][*NMOS*][*OUTPUT*][*Current Path*],
    [0 (GND)], [ON], [OFF], [1 (VDD)], [VDD → PMOS → Output],
    [1 (VDD)], [OFF], [ON], [0 (GND)], [Output → NMOS → GND],
  ),
  caption: [CMOS inverter truth table and current paths],
) <cmos-truth-table>

#note("Power Consumption Advantage")[
  The complementary nature ensures that in steady state, one transistor is always OFF, preventing any direct current path from VDD to GND. Power is only consumed during switching transitions, making CMOS extremely power-efficient compared to other logic families.
]

== Alternative Single-Transistor Approaches (Why They Don't Work)

#example("NMOS-only Inverter Problems")[
  If we tried to build an inverter with only NMOS:
  - Could pull output LOW when input is HIGH
  - Cannot pull output HIGH when input is LOW (would need a resistor)
  - Resistor would cause static power consumption
  - Weak HIGH output level (degraded logic levels)

  This is why early logic families like NMOS required large pull-up resistors and consumed significant power.
]

The CMOS approach solves all these problems by using the PMOS as an "active pull-up" device that strongly drives the output HIGH while consuming no static power.

