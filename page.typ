#import "colors.typ": light-color
#import "@preview/hydra:0.6.2": hydra

#let page-header() = context [
  #grid(
    columns: (4fr, 1fr),
    align(left, text(fill: light-color, hydra())),
    align(right)[#counter(page).display()],
  )
  #v(-5pt)
  #line(length: 100%, stroke: light-color + 0.1pt)
]
#let page-footer() = context [
  #grid(
    columns: (1fr, 1fr),
    align(left)[Šimon Brandner], align(right)[#datetime.today().display()],
  )
]
