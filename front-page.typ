#let front-page(title-page) = align(center + horizon)[
  #text(size: 20pt, title-page.institution)

  #image(
    "images/cvut_symbol.svg",
    width: 200pt,
  )

  #if "type-of-text" in title-page {
    text(size: 20pt, title-page.type-of-text)
  }

  #text(size: 30pt, title-page.title)

  #text(size: 20pt)[#title-page.author]

  #text(
    size: 15pt,
  )[
    #if "supervisor" in title-page [
      Supervisor: #title-page.supervisor
    ]

    #if "study-programme" in title-page [
      Study Programme: #title-page.study-programme
    ]

    #if "field-of-study" in title-page [
      Field of Study: #title-page.field-of-study
    ]
  ]

  #text(size: 20pt, datetime.today().display())
]
