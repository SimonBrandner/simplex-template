#import "fonts.typ": title-font
#import "colors.typ": light-color
#import "term-dictionaries.typ": *

#let counter-name(kind) = kind + ":counter"
#let label-name(kind) = kind + ":label"

#let text-box(kind, supplement) = {
  let box-counter = counter(counter-name(kind))

  content => {
    figure(
      outlined: false,
      kind: kind,
      supplement: supplement,
    )[
      #box-counter.step()
      #content(
        context {
          let numbers = (
            ..counter(heading).get(),
            ..box-counter.get(),
          )

          [#metadata(numbers)#label(label-name(kind))#supplement #numbering(
              "1.1",
              ..numbers,
            )]
        },
      )
    ]
  }
}

#let non-border-text-box(kind, supplement) = {
  let render = text-box(kind, supplement)

  (content, name: none) => render(
    number-and-supplement => block(width: 100%)[
      #text(font: title-font)[
        #text(weight: "bold")[#number-and-supplement]#if name != none [ (#name)].
      ]
      #content#place(bottom + right, text(fill: light-color, $corner.r.b$))
    ],
  )
}

#let border-text-box(kind, supplement) = {
  let render = text-box(kind, supplement)

  (name: none, content) => render(
    number-and-supplement => box(
      stroke: 0.5pt,
      inset: 7.5pt,
      radius: 5pt,
      width: 100%,
    )[
      #text(
        font: title-font,
      )[
        #text(weight: "bold")[#number-and-supplement]#if name != none [ (#name)].
      ]
      #content
    ],
  )
}

#let proof(content) = block(width: 100%)[
  #text(
    font: title-font,
    weight: "bold",
  )[#context { term-dictionary.get().Proof }.]
  #content#place(bottom + right, $square$)
]
#let solution(content) = block(width: 100%)[
  #text(
    font: title-font,
    weight: "bold",
  )[#context { term-dictionary.get().Solution }.]
  #content#place(bottom + right, $triangle$)
]

#let definition = border-text-box(
  "definition",
  context term-dictionary.get().Definition,
)
#let theorem = border-text-box(
  "theorem",
  context term-dictionary.get().Theorem,
)
#let remark = non-border-text-box(
  "remark",
  context term-dictionary.get().Remark,
)
#let example = non-border-text-box(
  "example",
  context term-dictionary.get().Example,
)
#let exercise(..args, number: none) = {
  if number != none {
    counter(counter-name("exercise")).update(number - 1)
  }
  non-border-text-box(
    "exercise",
    context term-dictionary.get().Exercise,
  )(..args)
}
#let text-boxes-kinds = (
  "definition",
  "remark",
  "theorem",
  "exercise",
  "example",
)

#let text-boxes(body) = {
  show: body => text-boxes-kinds.fold(body, (
    (body, kind) => {
      show figure.where(kind: kind): set align(start)
      show figure.where(kind: kind): set block(breakable: true)
      show figure.where(kind: kind): fig => fig.body
      show heading: it => {
        counter(counter-name(kind)).update(0)
        it
      }
      body
    }
  ))

  show ref: it => {
    let element = it.element
    if (
      element != none
        and element.func() == figure
        and element.kind in text-boxes-kinds
    ) {
      let num = numbering(
        "1.1",
        ..query(
          selector(label(label-name(element.kind))).after(it.target),
        )
          .first()
          .value,
      )

      return link(element.label)[#element.supplement #num]
    }
    it
  }

  body
}
