# Simplex Template

## How to use

```typst
#import "@local/simplex-template:0.1.0": *

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
```
