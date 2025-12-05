#import "lib.typ": *
#import "@preview/mannot:0.2.2": markrect

// Homework Template Configuration
#show: template.with(
  title: [Homework 10],
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
#solution[
  #align(center)[$ V_s = 8 angle.l -40° $]

  #align(center)[$ V_s = 8 cos(-40°) + j 8 sin(-40°) = 6.128 - j 5.142 "V" $]

  #align(center)[$ |V_s| = 8.00 "V", quad angle V_s = -40.0° $]

  #align(center)[$ Z_L = j omega L = j (2)(3) = j 6 Omega $]

  #align(center)[$ Z_C = 1/(j omega C) = 1/(j (2)(0.25)) = 1/(j 0.5) = -j 2 Omega $]

  #align(center)[$ Z_(R_2 C) = R_2 + Z_C = 2 - j 2 Omega $]

  #align(center)[$ Z_("parallel") = (Z_L dot Z_(R_2 C))/(Z_L + Z_(R_2 C)) = (j 6 dot (2 - j 2))/(j 6 + 2 - j 2) $]

  #align(center)[$ = (j 12 + 12)/(2 + j 4) = (12 + j 12)/(2 + j 4) $]

  #align(center)[$ = ((12 + j 12)(2 - j 4))/((2 + j 4)(2 - j 4)) = (24 - j 48 + j 24 + 48)/(4 + 16) = (72 - j 24)/20 $]

  #align(center)[$ Z_("parallel") = 3.6 - j 1.2 Omega $]

  #align(center)[$ |Z_("parallel")| = 3.795 Omega, quad angle Z_("parallel") = -18.43° $]

  #align(center)[$ Z_("total") = R_1 + Z_("parallel") = 1 + 3.6 - j 1.2 = 4.6 - j 1.2 Omega $]

  #align(center)[$ |Z_("total")| = 4.754 Omega, quad angle Z_("total") = -14.62° $]

  #align(center)[$ I_s = V_s / Z_("total") = (6.128 - j 5.142)/(4.6 - j 1.2) $]

  #align(center)[$ = 1.520 - j 0.721 "A" $]

  #align(center)[$ |I_s| = 1.683 "A", quad angle I_s = -25.38° $]

  #align(center)[$ V_(R_1) = I_s dot R_1 = (1.520 - j 0.721)(1) = 1.520 - j 0.721 "V" $]

  #align(center)[$ |V_(R_1)| = 1.683 "V", quad angle V_(R_1) = -25.38° $]

  #align(center)[$ V_("par") = V_s - V_(R_1) = (6.128 - j 5.142) - (1.520 - j 0.721) $]
  #align(center)[$ = 4.608 - j 4.421 "V" $]
  #align(center)[$ |V_("par")| = 6.386 "V", quad angle V_("par") = -43.81° $]

  #align(center)[$ I_L = V_("par") / Z_L = (4.608 - j 4.421)/(j 6) = -0.737 - j 0.768 "A" $]

  #align(center)[$ |I_L| = 1.064 "A", quad angle I_L = -133.81° $]

  #align(center)[$ I_(R_2 C) = V_("par") / (R_2 + Z_C) = (4.608 - j 4.421)/(2 - j 2) $]

  #align(center)[$ = 2.257 + j 0.047 "A" $]
  
  #align(center)[$ |I_(R_2 C)| = 2.258 "A", quad angle I_(R_2 C) = 1.19° $]

  #align(center)[$ V_(R_2) = I_(R_2 C) dot R_2 = (2.257 + j 0.047)(2) = 4.514 + j 0.093 "V" $]
  #align(center)[$ |V_(R_2)| = 4.515 "V", quad angle V_(R_2) = 1.19° $]

  #align(center)[$ V_C = I_(R_2 C) dot Z_C = (2.257 + j 0.047)(-j 2) = 0.093 - j 4.514 "V" $]
  #align(center)[$ |V_C| = 4.515 "V", quad angle V_C = -88.81° $]

  #align(center)[$ P_(R_1) = 1/2 |V_(R_1)|^2 / R_1 = 1/2 (1.683)^2 / 1 = 1.416 "W" $]

  #align(center)[$ P_(R_2) = 1/2 |V_(R_2)|^2 / R_2 = 1/2 (4.515)^2 / 2 = 5.097 "W" $]

  #align(center)[$ P_L = 0 "W" quad "(reactive element)" $]

  #align(center)[$ P_C = 0 "W" quad "(reactive element)" $]


  #markrect(
    $P_(R_1) = 1.416 "W"$,
  )
  #markrect(
    $P_(R_2) = 5.097 "W"$,
  )
  #markrect(
    $P_L = 0 "W"$,
  )
  #markrect(
    $P_C = 0 "W"$,
  )
]

=

#solution[
  #align(center)[$ Z_(5 || L) = (R_5 dot Z_L)/(R_5 + Z_L) = (5 dot j 2)/(5 + j 2) $]

  #align(center)[$ = (j 10)/(5 + j 2) = (j 10(5 - j 2))/((5 + j 2)(5 - j 2)) = (j 50 + 20)/(25 + 4) = (20 + j 50)/29 $]

  #align(center)[$ Z_(5 || L) = 0.6897 + j 1.7241 Omega $]

  #align(center)[$ Z_("series") = Z_C + Z_(5 || L) = -j 3 + 0.6897 + j 1.7241 $]

  #align(center)[$ Z_("series") = 0.6897 - j 1.2759 Omega $]

  #align(center)[$ Z_("th") = R_4 || Z_("series") = (4 dot (0.6897 - j 1.2759))/(4 + 0.6897 - j 1.2759) $]

  #align(center)[$ = (2.7586 - j 5.1034)/(4.6897 - j 1.2759) $]

  #align(center)[$ = ((2.7586 - j 5.1034)(4.6897 + j 1.2759))/((4.6897 - j 1.2759)(4.6897 + j 1.2759)) $]

  #align(center)[$ = (12.9383 + j 3.5205 - j 23.9369 + 6.5119)/(22.0013 + 1.6279) $]

  #align(center)[$ = (19.4502 - j 20.4164)/23.6292 $]

  #align(center)[$ Z_("th") = 0.8234 - j 0.8642 Omega $]

  #align(center)[$ |Z_("th")| = 1.194 Omega, quad angle Z_("th") = -46.39° $]

  Node B: $(V_B - V_s)/R_4 + (V_B - V_C)/Z_C = 0$

  Node C: $(V_C - V_s)/Z_L + (V_C - V_B)/Z_C + V_C/R_5 = 0$

  #align(center)[$ V_B (1/R_4 + 1/Z_C) - V_C (1/Z_C) = V_s/R_4 $]

  #align(center)[$ -V_B (1/Z_C) + V_C (1/Z_L + 1/Z_C + 1/R_5) = V_s/Z_L $]

  #align(center)[$ a_(11) = 1/4 + 1/(-j 3) = 0.25 + j 0.3333 $]

  #align(center)[$ a_(12) = -1/(-j 3) = -j 0.3333 $]

  #align(center)[$ a_(21) = -1/(-j 3) = -j 0.3333 $]

  #align(center)[$ a_(22) = 1/(j 2) + 1/(-j 3) + 1/5 = -j 0.5 + j 0.3333 + 0.2 = 0.2 - j 0.1667 $]

  #align(center)[$ b_1 = 165/4 = 41.25 $]

  #align(center)[$ b_2 = 165/(j 2) = -j 82.5 $]

  #align(center)[$ "det" = a_(11) a_(22) - a_(12) a_(21) = (0.25 + j 0.3333)(0.2 - j 0.1667) - (-j 0.3333)(-j 0.3333) $]

  #align(center)[$ = 0.05 - j 0.0417 + j 0.0667 + 0.0556 - 0.1111 $]

  #align(center)[$ = -0.0056 + j 0.025 $]

  #align(center)[$ V_B = (b_1 a_(22) - b_2 a_(12))/"det" = (41.25(0.2 - j 0.1667) - (-j 82.5)(-j 0.3333))/(-0.0056 + j 0.025) $]

  #align(center)[$ = (8.25 - j 6.875 - 27.5)/(-0.0056 + j 0.025) = (-19.25 - j 6.875)/(-0.0056 + j 0.025) $]

  #align(center)[$ = ((-19.25 - j 6.875)(-0.0056 - j 0.025))/((-0.0056 + j 0.025)(-0.0056 - j 0.025)) $]

  #align(center)[$ = (0.1078 + j 0.4813 + j 0.0385 - 0.1719)/(0.0000314 + 0.000625) $]

  #align(center)[$ = (-0.0641 + j 0.5198)/0.0006564 $]

  #align(center)[$ V_("th") = V_B = 159.22 - j 50.10 "V" $]

  #align(center)[$ |V_("th")| = 166.92 "V", quad angle V_("th") = -17.47° $]

  #align(center)[$ Z_L^("opt") = Z_("th")^* = 0.8234 + j 0.8642 Omega $]

  #align(center)[$ R_("th") = 0.8234 Omega, quad X_("th") = -0.8642 Omega $]

  #align(center)[$ P_("max") = |V_("th")|^2 / (4 R_("th")) = (166.92)^2 / (4 dot 0.8234) $]

  #align(center)[$ P_("max") = 27860.95 / 3.2935 = 8459.54 "W" $]

  #markrect(
    $Z_L^("opt") = 0.823 + j 0.864 Omega$,
  )
  #markrect(
    $P_("max") = 8459.5 "W"$,
  )
]

#import "@preview/cetz:0.4.2": canvas
#import "@preview/cetz-plot:0.1.3": plot

#let R = 200       // Ω
#let L = 0.1       // H
#let wc = R / L
#let fc = wc / (2 * calc.pi)

=

==
#solution[
  #align(center)[$H_L(s) = frac(V_o(s), V_i(s)) = frac(s L, R + s L)$]

  #align(center)[$H_L(j omega) = frac(j omega L, R + j omega L)$]

  #align(center)[$abs(H_L(j omega)) = frac(omega L, sqrt(R^2 + (omega L)^2))$]

  Low: $omega -> 0 => abs(H_L) -> 0$

  High: $omega -> infinity => abs(H_L) -> 1$

  #align(center)[$omega_c = frac(R, L) = frac(200, 0.1) = 2000 "rad/s"$]

  $f_c = frac(omega_c, 2 pi)
  = frac(2000, 2 pi)
  approx 3.18 times 10^2 "Hz"$

  Filter type: high-pass.
]

==

#solution[
  #align(center)[$H_R(s) = frac(V_o(s), V_i(s)) = frac(R, R + s L)$]

  #align(center)[$H_R(j omega) = frac(R, R + j omega L)$]

  #align(center)[$abs(H_R(j omega)) = frac(R, sqrt(R^2 + (omega L)^2))$]

  Low: $omega -> 0 => abs(H_R) -> 1$

  High: $omega -> infinity => abs(H_R) -> 0$

  At $omega = omega_c$: $abs(H_R) = 1 / sqrt(2) approx -3 "dB"$

  Filter type: low–pass.
]

==


#import "@preview/cetz:0.4.2": canvas, draw
#import "@preview/cetz-plot:0.1.3": plot
#solution[
  #canvas({
    // use CeTZ draw functions
    import draw: *
    import "@preview/cetz-plot:0.1.3": plot

    // cutoff at log10(ω/ω_c) = 0 and -3 dB level
    let xc = 0.0
    let minus3db = -3.0

    plot.plot(
      size: (12, 7),
      x-min: -3,
      x-max: 3,
      y-min: -80,
      y-max: 10,
      x-tick-step: 1,
      y-tick-step: 20,
      x-label: "log10(omega / omega_c)",
      y-label: "Magnitude (dB)",
      legend: "inner-south",
      {
        // High-pass (L): +20 dB/dec below 0, 0 dB above
        plot.add(
          domain: (-3, 3),
          x => if x <= 0 { 20 * x } else { 0 },
          label: [High-pass (L)],
        )

        // Low-pass (R): 0 dB below 0, -20 dB/dec above
        plot.add(
          domain: (-3, 3),
          x => if x <= 0 { 0 } else { -20 * x },
          label: [Low-pass (R)],
        )

        // --- Cutoff frequency marker at x = 0 ---
        plot.add-vline(
          xc,
          style: (stroke: (dash: "dashed")),
          label: [$omega = omega_c$],
        )

        // --- Annotations: -3 dB point + slopes ---
        plot.annotate({
          // -3 dB point as a small circle at (xc, -3 dB)
          circle((xc, minus3db), radius: 0.08)

          // Label for the -3 dB point
          content((xc, minus3db), [-3 dB], anchor: "north")

          // High-pass side: +20 dB/dec
          content((-1.5, -30), [+20 dB/dec])

          // Low-pass side: -20 dB/dec
          content((1.5, -10), [-20 dB/dec])
        })
      },
    )
  })
]



==

#solution[
  For RC low–pass: $omega_c = frac(1, R_{R C} C)$

  $C = frac(1, R_{R C} omega_c)
  = frac(1, (10^4)(2000))
  = 5 times 10^{-8} "F"
  = 50 "nF"$

  Circuit: series $10 "k" Omega$ from $v_i$ to node, capacitor
  $C = 50 "nF"$ from node to ground, $v_o$ across $C$.
]

=
==
#solution[
  #align(center)[$Z_L = j ω L$]
  #align(center)[$Z_C = frac(1, j ω C)$]
  #align(center)[$Z_R = R$]

  #align(center)[$Z_{R C} = (frac(1, R) + j ω C)^{-1}$]

  $H(j ω) = frac(V_o, V_i)
  = frac(Z_{R C}, Z_L + Z_{R C})
  = frac(
    frac(1, frac(1, R) + j ω C),
    j ω L + frac(1, frac(1, R) + j ω C)
  )$

  $H(j ω)
  = frac(1, 1 + j ω L (frac(1, R) + j ω C ))$

  $j ω L (frac(1, R) + j ω C )
  = j ω frac(L, R) + j^2 ω^2 L C
  = j ω frac(L, R) - ω^2 L C$

  #align(center)[$H(j ω) = frac(1, 1 - ω^2 L C + j ω frac(L, R))$]

  #align(center)[$lim_(ω -> 0) |H(j ω)| = frac(1, |1|) = 1$]

  $lim_(ω -> infinity) |H(j ω)|
  = lim_(ω -> infinity) frac(1, sqrt((1 - ω^2 L C)^2 + (ω L/R)^2))
  = 0$

  $therefore$ Low-pass filter.
]
==

#solution[
  #align(center)[$L = 1, quad C = 1, quad R = 0.25$]

  #align(center)[$L C = 1$]
  #align(center)[$frac(L, R) = 4$]

  #align(center)[$H(j ω) = frac(1, 1 - ω^2 + j 4 ω)$]

  #align(center)[$a(ω) = 1 - ω^2$]
  #align(center)[$b(ω) = 4 ω$ for $H(ω) = frac(1, a(ω) + j b(ω))$]
]

=

#solution[
  #align(center)[$ω = 4$]

  #align(center)[$Z_L = j 4$]
  #align(center)[$Z_C = frac(1, j 4 dot (0.25)) = -j$]
  #align(center)[$Z_R = 1$]

  #align(center)[$Z_(C R) = 1 - j$]

  #align(center)[$I_(C R) = frac(V_A, Z_(C R))$]

  #align(center)[$I_x = I_L$]

  #align(center)[$I_{C R} - 0.5 I_x - I_x = 0$]

  #align(center)[$I_{C R} = 1.5 I_x$]

  #align(center)[$V_A = V_s - I_x Z_L$]

  #align(center)[$V_A = 1.5 I_x Z_(C R)$]

  #align(center)[$I_x ( j 4 + 1.5(1 - j) ) = 24 angle 45°$]

  #align(center)[$I_x = frac(24 angle 45°, j 4 + 1.5 - 1.5j)$]

  #align(center)[$I_x = 8.23 angle(-14°)$]

  #align(center)[$I_(C R) = 1.5 I_x = 12.35 angle(-14°)$]

  #align(center)[$V_o = I_(C R)$]

  #align(center)[$v_o(t) = 12.35 cos(4t - 14°)$]
]

// End of homework
#v(2em)
#align(center)[
  #line(length: 30%, stroke: 0.5pt)

  *End of Homework 10*
]
