# Simplex Template

## How to use

```typst
#import "@local/simplex-template:0.1.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge

#show: body => simplex-template(
  title-page: (
    title: "This is a text",
    author: "Some person",
    supervisor: "Some other person, Ph. D.",
    study-programme: [#lorem(2)],
    field-of-study: [#lorem(5)],
    type-of-text: "Experiment",
    institution: [
      Czech Technical University in Prague

      Faculty of Electrical Engineering
    ],
  ),
  dedication: (title: "Acknowledgements", content: [#lorem(100)]),
  abstract: [#lorem(100)],
  keywords: [#lorem(10)],
  abstract-other-language: (title: "Abstrakt", content: [#lorem(100)]),
  keywords-other-language: (title: "Klíčová slova", content: [#lorem(10)]),
  body,
)

= Introduction

Hello world!

#definition("A very important definition")[X is Y.]
#remark(name: "This is a note")[This is very important!]

#theorem("A very important theorem")[
  Let X be Y, then Z.
]
#proof[Is left to the reader.]

#equation(
  $
    integral_a^b f(x) "d"x = F(b) - F(a).
  $
) <newton>

See @newton.

#equation(
  diagram(
    $
      & Z edge("d", "-->", exists ! f) edge("ldd", "->", bend: #(-30deg), f_1) edge("rdd", "->", bend: #30deg, f_2) \
      & X times Y edge("ld", "->", pi_1) edge("rd", "->", pi_2) \
      X & & Y
    $,
  ),
)
```
