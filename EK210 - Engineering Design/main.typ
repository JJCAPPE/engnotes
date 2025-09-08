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
      // link: "https://your-website.com", // Uncomment and add your link if desired
    ),
  ),
  
  // lof: true,  // Uncomment for list of figures
  // lot: true,  // Uncomment for list of tables  
  // lol: true,  // Uncomment for list of listings
  bibliography_file: "refs.bib",
  paper_size: "a4",
  // landscape: true,  // Uncomment for landscape orientation
  cols: 1,
  text_font: "STIX Two Text",
  code_font: "Cascadia Mono",
  accent: "#DC143C", // Crimson red - change to your preferred color
  h1-prefix: "Lecture",
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
    
    [Energy\ (torque)]
  ),
  caption: [Glass box functional analysis for a screwdriver]
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
    
    [Material\ (graphite marks on paper)\ \ Information\ (written content)]
  ),
  caption: [Glass box functional analysis for a lead pencil]
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
