#set page(
  "a6",
  margin: 4mm,
  height: auto,
  background: image("paper.png", width: 100%, height: 100%, fit: "cover"),
)
#set text(size: 3mm)
#set par(spacing: 5pt)

#let item = json(sys.inputs.item)

//---title---
#rect(
  //font: "TeX Gyre Chorus"
  align(center, heading(text(item.title, size: 8mm))),
  radius: 10pt,
  height: auto,
  width: 100%,
  stroke: 2pt + black,
  fill: white
)

//---image---
#align(center, image("images/" + item.image, height: 45mm))

//---objecttype & rarity---
#rect(
  grid(
    columns: (50%, 50%),
    item.objecttype,
    align(right, item.rarity)
      ),
  
  width: 100%,
  height: auto,
  radius: (top:5pt),
  stroke: 2pt + black
)

//---different body functions---

// item has: properties, description, effect
#let draw_item(item) = [
  #rect(
    grid(
      columns: (auto),
      rows: (auto),
      gutter: 5mm,

      grid(
      columns: (1fr,2fr),
      gutter: 5mm,
      //---properties---
      [
        #for property in item.properties [
        #box(rect(radius: 2pt, stroke: 1pt + gray, text(property, size: 2mm)))
        ]
      ],
      //---description---
      item.description,
    ),
  
    //---effect---
    item.effect
  ),
  
  width: 100%,
  height: auto,
  radius: (bottom: 5pt),
  stroke: 2pt + black
  )
]

#let draw_component(item) = [
#rect(
    grid(
      columns: (auto),
      rows: (auto),
      gutter: 5mm,

      grid(
      columns: (15%,2fr),
      gutter: 5mm,
      [
        #for property in item.properties [
          #box(rect(radius: 2pt, stroke: 1pt + gray,        text(property, size: 2mm)))
        ]
        
      ],
      item.description
      ),
    ),
  
    width: 100%,
    height: auto,
    radius: (bottom: 5pt),
    stroke: 2pt + black
  )
]

//---body---
//changes on cardtype

#if item.cardtype == "item"{
    draw_item(item)
  }  else if item.cardtype == "component" {
    draw_component(item)
  }