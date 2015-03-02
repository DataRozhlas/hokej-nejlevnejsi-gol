ig.drawCenaZaGol = (parentElement) ->
  data = ig.getCenaZaGol!
  scale = d3.scale.linear!
    ..domain [0 66]
    ..range [0 50]
  data.sort (a, b) -> b.cenaZaGol - a.cenaZaGol
  parentElement.append \div .attr \class "graph"
    ..append \div .attr \class \lines
      ..selectAll \div.line .data data .enter!append \div
        ..attr \class \line
        ..append \div
          ..attr \class \title
          ..html -> "#{it.klub}"
          ..style \right -> "#{scale it.cenaZaGol}%"
        ..append \div
          ..attr \class \bar
          ..style \width -> "#{scale it.cenaZaGol}%"
        ..append \div
          ..attr \class \value
          ..html -> "#{ig.utils.formatNumber it.cenaZaGol, 2} Kč"
          ..style \left -> "#{100 - scale it.cenaZaGol}%"


