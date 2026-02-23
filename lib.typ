#import "text-boxes.typ": *
#import "page.typ": *
#import "front-page.typ": *
#import "equations.typ": *
#import "term-dictionaries.typ": *

#let simplex-template(
  title-page: none,
  dedication: none,
  abstract: none,
  keywords: none,
  abstract-other-language: none,
  keywords-other-language: none,
  show-outline: true,
  lang: "en",
  body,
) = {
  if lang == "cs" {
    term-dictionary.update(cs-dictionary)
  }

  set page(paper: "a4")
  set enum(numbering: "(a)", indent: 10pt)
  set list(indent: 10pt)
  set par(justify: true)
  set heading(numbering: "1.1")
  set text(size: 12pt, lang: lang)

  show: text-boxes
  show: equations
  show heading: set text(weight: "bold", font: title-font)
  show heading.where(level: 1): set text(size: 30pt)
  show heading.where(level: 2): set text(size: 20pt)
  show heading.where(level: 3): set text(size: 16pt)

  // A hack to fix https://github.com/typst/typst/issues/529
  show math.equation.where(block: true): e => [
    #box(width: 100%, inset: 0em, [
      #set align(center)
      #e
    ])
  ]

  show ref: it => [#h(2pt)#box(
      stroke: light-color,
      fill: luma(245),
      outset: (left: 1pt, right: 1pt, bottom: 3.5pt, top: 2pt),
      radius: 2pt,
      it,
    )#h(2pt)]

  show: set page(numbering: "i", footer: none)

  if title-page != none {
    front-page(title-page)
  }

  set page(header: page-header(), footer: page-footer(title-page.author))

  if dedication != none {
    pagebreak()
    align(bottom)[
      #heading(numbering: none, outlined: false, level: 2)[#dedication.title]
      #dedication.content
      #v(3em)
    ]
  }

  if (
    abstract != none
      or keywords != none
      or abstract-other-language != none
      or keywords-other-language != none
  ) {
    pagebreak()
  }

  if abstract != none {
    heading(numbering: none, outlined: false, level: 2)[#context {
      term-dictionary.get().Abstract
    }]
    abstract
  }
  if keywords != none {
    heading(numbering: none, outlined: false, level: 2)[#context {
      term-dictionary.get().Keywords
    }]
    keywords
  }

  if abstract-other-language != none {
    heading(
      numbering: none,
      outlined: false,
      level: 2,
      abstract-other-language.title,
    )
    abstract-other-language.content
  }
  if keywords-other-language != none {
    heading(
      numbering: none,
      outlined: false,
      level: 2,
      keywords-other-language.title,
    )
    keywords-other-language.content
  }

  if show-outline {
    pagebreak()
    outline(title: heading(level: 2, context {
      term-dictionary.get().Contents
    }))
  }

  show: set page(numbering: "1")
  counter(page).update(1)
  pagebreak()

  body
}
