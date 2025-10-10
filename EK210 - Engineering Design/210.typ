#import "lib.typ": *

#show: template.with(
  title: [EK210: Engineering Design],
  short_title: "EK210",
  description: [
    Lecture notes for Engineering Design
  ],
  date: datetime.today(),
  authors: (
    (
      name: "Giacomo Cappelletto",
      link: "github.com/JJCAPPE", // Uncomment and add your link if desired
    ),
  ),

  // lof: true,  // Uncomment for list of figures
  lot: true, // Uncomment for list of tables
  // lol: true,  // Uncomment for list of listings
  bibliography_file: "refs.bib",
  paper_size: "a4",
  // landscape: true,  // Uncomment for landscape orientation
  cols: 1,
  text_font: "STIX Two Text",
  code_font: "Cascadia Mono",
  accent: "#DC143C", // Crimson red - change to your preferred color
  h1-prefix: "Chapter",
  colortab: false,
)

= Engineering Design Definition

#definition("Engineering Design")[
  A *systematic, intelligent process* in which designers generate, evaluate, and specify designs for devices, systems, or processes whose form and function achieve clients' objectives and users' needs while satisfying a specified set of constraints.
]

== Key Concepts

=== Objectives vs Functions vs Specifications

#note("Objectives")[
  *Attributes* that a client or user would like in a product.
  - Example: "Make a brown frying pan", "Make it cheap", "Make it transparent"
  - Often vague and require clarification through proper questioning
]

#note("Functions")[
  *Things the product is supposed to do* (verb-noun pairs).
  - Example: "Measure temperature", "Withstand impact", "Resist breakage"
  - Engineering perspective of what must be achieved
  - Active form vs. objectives as "states of being"
]

#note("Specifications")[
  *Engineering statements* of functions that must be exhibited and can be measured.
  - Example: Coefficient of thermal expansion < X value
  - Example: Fracture toughness > Y value
  - Example: Thermal conductivity specification
]

=== Other Key Terms

#definition("Metrics")[
  A scale upon which achievement of design objectives can be measured.
]

#definition("Constraints")[
  Restrictions or limitations on a product's performance.
  - Example: \"Cannot be metal\", \"Must cost under \$5\"
  - Can be explicit or implicit
]

= Problem Statements

#note("Good Problem Statement Requirements")[
  1. *Clear statement of WHO, WHAT, and WHY*
  2. *General* - doesn't constrain specific means/solutions
  3. *Specific enough* to guide design decisions
]

== Examples

#example("Poor Problem Statement")[
  "The goal of our project is to design an infrared thermometer"

  *Issues:*
  - Constrains means (infrared)
  - Doesn't explain what/who/why
]

#example("Good Problem Statements")[
  "The goal is to design a device to measure the temperature of everyone walking through the front door at Boston Medical Center as a preliminary indicator of either COVID-19 or influenza."

  "The goal is to design a device to measure temperature in a home setting for use with telemedicine tracking of elderly patients."

  *Why these work:*
  - Clear WHO, WHAT, WHY
  - No specific means mentioned
  - Sufficient detail for design direction
]

= Functional Analysis: Glass Box Method

#definition("Glass Box Analysis")[
  A systematic method for determining functional requirements by analyzing inputs, outputs, and the functions needed to transform them.
]

== Glass Box Components

All glass boxes have three possible inputs and outputs:
- *Energy*
- *Information*
- *Material*

== Example: Screwdriver Glass Box

#figure(
  table(
    columns: 3,
    stroke: 1pt,
    inset: 8pt,
    table.header([*INPUTS*], [*FUNCTIONS*], [*OUTPUTS*]),

    [Energy\ (supplied by user)\ \ Information\ (location, object)],

    [*Enable grip*\ (plastic cylinder, rubberized handle, wood, rectangular)\ \ *Attach to object*\ (wood, metal, flathead, phillips, interchangeable)],

    [Energy\ (torque)],
  ),
  caption: [Glass box functional analysis for a screwdriver],
)

== Worked Example: Lead Pencil Glass Box

Let's work through a complete glass box analysis for a lead pencil.

*Step 1: Define the objective*
- Product: Lead pencil
- Objective: Create marks on paper for writing/drawing

*Step 2-5: Complete Glass Box Analysis*

#figure(
  table(
    columns: 3,
    stroke: 1pt,
    inset: 8pt,
    table.header([*INPUTS*], [*FUNCTIONS*], [*OUTPUTS*]),

    [Energy\ (user pressure & motion)\ \ Information\ (content, location)\ \ Material\ (paper)],

    [*Hold graphite*\ (wood casing, mechanical housing, plastic tube, metal ferrule)\ \ *Enable user grip*\ (hexagonal shape, round shape, textured surface, rubber grip)],

    [Material\ (graphite marks on paper)\ \ Information\ (written content)],
  ),
  caption: [Glass box functional analysis for a lead pencil],
)

*Step 6: Analysis and selection*
For a traditional wooden pencil:
- *Hold graphite*: Wood casing → inexpensive, easy to sharpen, natural grip
- *Enable grip*: Hexagonal shape → prevents rolling, comfortable hold, easy manufacturing

== Key Steps for Glass Box Analysis

1. *Set boundaries* - define what's inside vs outside your system
2. *Identify inputs* - what Energy/Information/Material enters?
3. *Identify outputs* - what Energy/Information/Material exits?
4. *Determine functions* - what must happen to transform inputs to outputs?
5. *List means* - brainstorm ways each function could be achieved

= Engineering Design Process

The five-stage systematic process:

1. *Problem Definition* - Frame problem, clarify objectives, identify constraints, establish functions
2. *Conceptual Design* - Generate alternative concepts, evaluate and select best approach
3. *Preliminary Design* - Size and estimate attributes, model and analyze chosen design
4. *Detailed Design* - Refine and optimize, build prototype, fix design details
5. *Communication* - Document specifications, justification, and design decisions

#note("Important Principles")[
  - Cross-functional teamwork required
  - No single \"best\" answer to design problems
  - Communication skills (oral & written) are critical
  - Don't jump to final solution too quickly - explore alternatives
]

= Team project

== Objectives

- Fit within a 12" × 12" footprint and weigh < 750 g
- Operate autonomously with no tethered power or manual control
- Start via a touchless mechanism (e.g., clap or proximity sensor)
- Cover the entire 4×4 ft desk area in 2 minutes or less
- Include reliable edge detection to prevent falling off the desk
- Incorporate a student‑built vacuum or suction mechanism for cleaning
- Collect visible and particulate debris into a removable or viewable container
- Pick up both light debris (paper scraps) and heavier particles (e.g., rice grains)
- Run untethered for at least 5 minutes continuously
- Signal cleaning completion with a clear indicator (LED, buzzer, etc.)
- Remain within the EK210 project budget constraints
- Prioritize core functionality over aesthetic appearance

== Material Flow
- Collect debris
- Entrain air
- Pick up paper scraps
- Pick up rice grains
- Transport debris/air
- Prevent clogging

== Energy Flow
- Store electrical energy
- Convert electrical energy to motion
- Convert electrical energy to suction
- Indicate low battery

== Information Flow
- Detect start gesture
- Detect edge
- Detect obstacle
- Measure runtime
- Indicate completion

== Morph Chart
#block[
  #align(center, text(1.1em)[Autonomous Desk Cleaner — Morph Chart])
]

#let H = strong

#pagebreak(weak: true)
#block(breakable: false, width: 100%)[
  #set text(size: 8.2pt)
  #set par(leading: 0.72em)
  #table(
    columns: 7,
    column-gutter: 6pt,
    stroke: 0.5pt + gray,
    inset: 6pt,
    align: horizon,
    table.header([H[FUNCTION]], [H[MEANS 1]], [H[MEANS 2]], [H[MEANS 3]], [H[MEANS 4]], [H[MEANS 5]], [H[MEANS 6]]),
    [
      H[Initiate on gesture],
      [MEMS mic + Goertzel clap],
      [IR prox (VCNL/ToF) wave],
      [UWB tap‑zone start],
      [BLE beacon start pkt],
      [Time‑gate + first motion],
      [Dual‑confirm (audio ∧ prox)],
    ],
    [
      H[Propel & steer to cover area],
      [Boustrophedon lanes],
      [Spiral‑in/out + lanes],
      [Random + wall‑follow],
      [SLAM‑lite: gyro + bump map],
      [Lissajous sweep],
      [Frontier fill],
    ],
    [
      H[Sense & avoid edges],
      [IR “cliff” array],
      [ToF mini‑lidar (drop)],
      [Optical‑flow ground‑loss],
      [IMU pitch spike → retreat],
      [Drop whisker (mech)],
      [Fusion vote (2‑of‑N)],
    ],
    [
      H[Sense & avoid obstacles],
      [Front ToF strip (10–60 cm)],
      [Ultrasonic pair (backup)],
      [Tactile bumpers],
      [Optical‑flow looming],
      [Hall/odom slip check],
      [Bayes fusion → slow/re‑route],
    ],
    [
      H[Generate suction & entrain debris],
      [50–80 mm radial + ESC (2–3S)],
      [Dual‑stage centrifugal (high ΔP)],
      [Vortex nozzle],
      [Agitator brush (foam/bristle)],
      [Nozzle skirt seal],
      [PWM suction (cruise save)],
    ],
    [
      H[Convey, separate & store debris],
      [Cyclonic cup],
      [Mesh + HEPA slice],
      [Labyrinth path (quiet, anti‑re‑entrain)],
      [Anti‑clog grate + purge],
      [Clear bin + mag latch],
      [ΔP clog sensor → boost/stop],
    ],

    [
      H[Manage power & communicate status],
      [2S 18650 pack + BMS + LVC],
      [Buck‑boost rails (isolated)],
      [Fuel‑gauge (INA219/LC709)],
      [LED ring + buzzer],
      [Auto‑sleep after done],
      [Budget watchdog (BOM counter)],
    ],
  )
]

#v(6pt)
#line(length: 100%, stroke: 0.5pt + gray)
#v(4pt)

#align(left, [
  #text(1.0em, strong[Brief notes on selected means])
  #list(
    tight: true,
    [
      strong[Goertzel clap detector] — band‑energy detect for clap; low‑cost.
    ],
    [
      strong[Boustrophedon coverage] — lane sweep for fast, full coverage.
    ],
    [
      strong[“SLAM-lite”] — gyro/odom + bump map; avoids gaps without vision.
    ],
    [
      strong[Optical‑flow cues] — ground‑flow vs wheel speed flags drop/loom.
    ],
    [
      strong[Cyclonic separation] — spins air to drop debris before filter.
    ],
    [
      strong[ΔP clog sensing] — pressure rise triggers purge/alert.
    ],
    [
      strong[Fuel‑gauge + LVC] — runtime estimate; cell protection.
    ],
  )
])


= Project

== Modelling in Pairs

- *List	your	product's	requirements	for	the	sensor/actuator.*
- *With	possible	product	means	identified,	look	up	the	component's	specification	sheet	and report	any	relevant values	(i.e.	values	one	might	test	to understand	real	world	performance)	Note	if	these	values	can	meet	your	requirements.*
- *If	necessary,	provide	calculations	of	relevant	component	specifications	with	regards	to	how	your	product	would	use	it.	(i.e.	motor	torque	and	wheel	size,	sensor	range/FOV…)*
- *Calculate/model/test	at	least	2	aspects of	the	component's capability	or	compare	one	aspect	for	 at	least	2	means or	components.	Test	things	relevant to	your	product	design.	(i.e.	Test	one	motor's	lifting	torque	and	it's	wattage	vs	speed,	or	test	two	different	distance	sensors	accuracy	vs	distance.)*
- *Describe	the	quantitative	experiment	you	are	conducting	to	test	the	aspect.	Consider	how	the	component	behaves	under	a	varied	condition.	(i.e.	what	is	the	independent	vs	dependent	variables)*
- *Provide	sketches	with	dimensions	for	the	experiment.*
- *Report	the	data. Plots,	Graphs,	Tables…*
- *Discuss	whether	it	fits	the	need*