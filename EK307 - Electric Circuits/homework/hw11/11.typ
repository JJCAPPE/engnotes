#import "lib.typ": *
#import "@preview/mannot:0.2.2": markrect

// Homework Template Configuration
#show: template.with(
  title: [Homework 11],
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
  Bandwidth $B = 20 upright(" rad/s")$ and center $omega_0 = 1000 upright(" rad/s")$ give quality factor $Q = omega_0 / B = 50$.
  For a series RLC band-pass with output across $R = 10 thin Omega$:

  #align(center)[$ L = R/B = 10/20 = 0.5 thin upright("H") $]
  #align(center)[$ C = 1/(omega_0^2 L) = 1/((1000)^2 (0.5)) = 2.0 thin upright("μF") $]
  #align(center)[$ abs(H(j omega)) = R/sqrt(R^2 + (omega L - 1/(omega C))^2) $]

  Half-power points occur when $abs(omega L - 1/(omega C)) = R$:
  #align(center)[$
    omega_(c 1) approx 990 thin upright("rad/s"), h(quad) omega_(c 2) approx 1010 thin upright("rad/s")
  $]

  Sketch: low-frequency slope $+20$ dB/dec, peak at $omega_0 = 1000$ rad/s, then $-20$ dB/dec after $omega_(c 2)$.
]

=
#solution[
  Shunt network is $R = 4 thin Omega$ in parallel with a series $L C$ ($4 thin upright("μ")$F, $1$ mH) fed through $R_s = 6 thin Omega$.
  Series $L C$ resonates (minimum impedance) at
  #align(center)[$
    omega_0 = 1/sqrt(L C) = 1/sqrt((1 times 10^(-3))(4 times 10^(-6))) approx 1.58 times 10^4 thin upright("rad/s")
  $]
  #align(center)[$ f_0 = omega_0 / (2 pi) approx 2.52 thin upright("kHz") $]

  Solving $abs(H(j omega)) = abs(H)_upright("pass")/sqrt(2)$ (with $abs(H)_upright("pass") approx R/(R_s+R) = 0.4$) gives
  #align(center)[$
    omega_(c 1) approx 1.47 times 10^4 thin upright("rad/s"), h(quad) omega_(c 2) approx 1.71 times 10^4 thin upright("rad/s")
  $]
  #align(center)[$
    B_(3 upright("dB")) approx omega_(c 2) - omega_(c 1) approx 2.4 times 10^3 thin upright("rad/s") med (approx 380 thin upright("Hz"))
  $]
]

=
#solution[
  Non-inverting first-order high-pass (input cap $C$ into $R$ to ground, non-inverting gain set by $R_f$/$R_i$):
  #align(center)[$ H(j omega) = lr((1 + R_f / R_i)) med (j omega R C)/(1 + j omega R C) $]
  Pass-band gain magnitude: $1 + R_f / R_i$.
  Cut-off (corner) frequency: $omega_c = 1/(R C)$.
]

=
#solution[
  (a) First-order low-pass with gain 10 and $omega_c = 50$ rad/s:
  #align(center)[$ H(j omega) = 10/(1 + j thin omega / 50) $]

  (b) One convenient choice:
  #align(center)[$
    R_i = 10 thin upright("k") Omega, h(quad) R_f = 100 thin upright("k") Omega med (upright("gain ") 10), h(quad) C = 1/(R_f omega_c) = 1/((100 upright("k"))(50)) approx 200 thin upright("nF")
  $]
  These values implement $omega_c approx 50$ rad/s with the desired gain.
]

=
#solution[
  Lab 7 heartbeat filter stage used $R_i = R_3 = 4.7 thin upright("k") Omega$, $C_i = C_2 = 1 thin upright("μF")$, and feedback $R_f = R_4 = 100 thin upright("k") Omega$ in parallel with $C_f = C_3 = 0.01 thin upright("μF")$. Its transfer function is
  #align(center)[$
    H(j omega) = - frac(100 upright("k"), 4.7 upright("k")) med frac(1, 1 + j omega (100 upright("k") dot 0.01 upright("μF"))) med frac(j omega (4.7 upright("k") dot 1 upright("μF")), 1 + j omega (4.7 upright("k") dot 1 upright("μF")))
  $]
  Mid-band gain is about $-21.3$ (approx $26.6$ dB).

  Corner (cut-off) frequencies:
  #align(center)[$
    omega_upright("L") = 1/(4.7 upright("k") dot 1 upright("μF")) approx 2.13 times 10^2 thin upright(" rad/s") h(quad) (f_upright("L") approx 33.9 thin upright(" Hz"))
  $]
  #align(center)[$
    omega_upright("H") = 1/(100 upright("k") dot 0.01 upright("μF")) = 1.00 times 10^3 thin upright(" rad/s") h(quad) (f_upright("H") approx 159 thin upright(" Hz"))
  $]
  So the stage passes roughly $34$–$159$ Hz while attenuating outside that band.
]

=
#solution[
  #align(center)[$ H(j omega) = (0.2 thin (10 + j omega))/(j omega thin (2 + j omega)) $]
  Poles/zero: pole at $omega = 0$, pole at $omega = 2$ rad/s, zero at $omega = 10$ rad/s.

  Magnitude breaks and slopes (Bode plot):
  - For $omega << 2$: $abs(H) approx 1/omega$ (crosses 0 dB at $omega approx 1$) -> slope $-20$ dB/dec.
  - After $omega = 2$ rad/s: second pole -> slope $-40$ dB/dec.
  - After $omega = 10$ rad/s: zero adds +20 dB/dec -> net slope $-20$ dB/dec.

  Useful reference magnitudes: $abs(H(1)) approx 0.90$ (approx -0.9 dB), $abs(H(2)) approx 0.36$ (approx -8.9 dB), $abs(H(10)) approx 0.028$ (approx -31 dB). Plot using the above slopes with corner marks at $2$ and $10$ rad/s.
]

// End of homework
#v(2em)
#align(center)[
  #line(length: 30%, stroke: 0.5pt)

  *End of Homework 11*
]
