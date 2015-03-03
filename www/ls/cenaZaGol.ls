metrics =
  ['cenaZaGol', 'Cena za gól']
  ['cenaZaNasGol', 'Cena za gól hostům']
  ['cenaZaVyhru', 'Cena za výhru']
ig.drawCenaZaGol = (parentElement) ->
  data = ig.getCenaZaGol!
  scale = d3.scale.linear!
    ..range [0 50]

  element = parentElement.append \div .attr \class "graph"

  element.append \form .append \ul
    ..selectAll \li .data metrics .enter!append \li
      ..append \input
        ..attr \type \radio
        ..attr \name \metric
        ..attr \id -> "metric-#{it.0}"
        ..on \change -> draw it.0
        ..attr \checked (d, i) -> if not i then "checked" else void
      ..append \label
        ..html -> it.1
        ..attr \for -> "metric-#{it.0}"

  lines = element.append \div .attr \class \lines
    .selectAll \div.line .data data .enter!append \div
      ..attr \class \line
      ..append \div
        ..attr \class \title
        ..html -> "#{it.klub}"
      ..append \div
        ..attr \class \bar
      ..append \div
        ..attr \class \value


  draw = (field) ->
    max = d3.max data.map -> it[field]
    data.sort (a, b) -> b[field] - a[field]
    for datum, index in data
      datum.index = index
    scale.domain [0 max]
    lines
      ..style \top -> "#{30 * it.index}px"
      ..select \div.title
        ..style \right -> "#{scale it[field]}%"
      ..select \div.bar
        ..style \width -> "#{scale it[field]}%"
      ..select \div.value
        ..html -> "#{ig.utils.formatNumber it[field], 2} Kč"
        ..style \left -> "#{100 - scale it[field]}%"
    lines

  draw 'cenaZaGol'

