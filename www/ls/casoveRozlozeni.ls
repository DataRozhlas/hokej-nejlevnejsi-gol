times =
  * id: 300, title: "5"
  * id: 600, title: "10"
  * id: 900, title: "15"
  * id: 1200, title: "20"
  * id: 1500, title: "25"
  * id: 1800, title: "30"
  * id: 2100, title: "35"
  * id: 2400, title: "40"
  * id: 2700, title: "45"
  * id: 3000, title: "50"
  * id: 3300, title: "55"
  * id: 3600, title: "60"
  * id: 3889, title: "prod."
  * id: 3900, title: "náj."
ig.drawCasoveRozlozeni = (parentElement) ->
  data = ig.getCasoveRozlozeni!
  container = parentElement.append \div
    ..attr \class \casove-rozlozeni
  kluby = container.append \div .attr \class \kluby
    ..append \h3 .html "Vybrat klub"
    ..append \ul .attr \class \kluby
      ..selectAll \li .data data .enter!append \li
        ..append \a
          ..attr \href \#
          ..html -> it.klub
          ..on \click (klub) ->
            d3.event.preventDefault!
            klubyItems.classed \active -> it is klub
            draw klub
        ..classed \active (d, i) -> 0 == i
  klubyItems = kluby.selectAll \li
  container
    ..append \div
      ..attr \class \left
        ..append \h3 .html "Góly, které dali protihráčům"
    ..append \div
      ..attr \class \right
        ..append \h3 .html "Góly, které tým dostal"
  lines = container.append \div .attr \class \lines
  lineElements = lines.selectAll \div.line .data times .enter!append \div
    .attr \class \line
  leftsLines = lineElements.append \div .attr \class \left
  markerLines = lineElements.append \dvi .attr \class \marker .html (.title)
  rightLines = lineElements.append \div .attr \class \right

  draw = (klub) ->
    leftsLines.selectAll \div .data ((d, i) -> klub.times[i].dali)
      ..enter!append \div
      ..exit!remove!
      ..classed "full" -> it
    rightLines.selectAll \div .data ((d, i) -> klub.times[i].dostali)
      ..enter!append \div
      ..exit!remove!
      ..classed "full" -> it

  draw data.0
