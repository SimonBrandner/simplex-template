#let equation-counter = counter("equation:counter")
#let equation(content) = {
  figure(
    outlined: false,
    kind: "equation",
    supplement: "Equation",
  )[
    #equation-counter.step()
    #context {
      let numbers = (
        ..counter(heading).get(),
        ..equation-counter.get(),
      )

      block(width: 100%)[
        #metadata(numbers)
        #label("equation:label")
        #align(center, content)
        #place(right + horizon, numbering(
          "(1.1)",
          ..numbers,
        ))]
    }

  ]
}

#let equations(body) = {
  show heading: it => {
    counter("equation:counter").update(0)
    it
  }

  show ref: it => {
    let element = it.element
    if (
      element != none
        and element.func() == figure
        and element.kind == "equation"
    ) {
      let num = numbering(
        "(1.1)",
        ..query(
          selector(label("equation:label")).after(it.target),
        )
          .first()
          .value,
      )

      return link(element.label)[#num]
    }
    it
  }

  body
}
