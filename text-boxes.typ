#import "fonts.typ": title-font
#import "colors.typ": light-color

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
    number-and-supplement => [
      #text(font: title-font)[
        #text(weight: "bold")[#number-and-supplement]#if name != none [ (#name)].
      ]
      #content
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

#let proof(content) = [
  #text(font: title-font, weight: "bold")[Proof.]
  #content
]

#let definition = border-text-box("definition", "Definition")
#let theorem = border-text-box("theorem", "Theorem")
#let remark = non-border-text-box("remark", "Remark")
#let text-boxes-kinds = ("definition", "remark", "theorem")

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
