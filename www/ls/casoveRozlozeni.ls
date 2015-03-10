times =
  * id: 300, title: "00:00"
  * id: 600, title: "05:00"
  * id: 900, title: "10:00"
  * id: 1200, title: "15:00"
  * id: 1500, title: "20:00"
  * id: 1800, title: "25:00"
  * id: 2100, title: "30:00"
  * id: 2400, title: "35:00"
  * id: 2700, title: "40:00"
  * id: 3000, title: "45:00"
  * id: 3300, title: "50:00"
  * id: 3600, title: "55:00"
  * id: 3889, title: "60:00<br>prod."
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
          ..on \click (klub, i) ->
            d3.event.preventDefault!
            klubyItems.classed \active -> it is klub
            window.location.hash = '#klub-' + i
            draw klub
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
  countsLeft = leftsLines.append \span
    ..attr \class "counts counts-left"
  countsRight = rightLines.append \span
    ..attr \class "counts counts-right"

  draw = (klub) ->
    leftsLines.selectAll \div.active .data ((d, i) -> klub.times[i].dali)
      ..enter!append \div
        ..attr \class "entering active"
        ..transition!
          ..delay 10
          ..attr \class -> if it then "full active" else "active"
      ..exit!
        ..classed \exiting yes
        ..classed \active no
        ..transition!
          ..delay 800
          ..remove!
      ..classed "full" -> it
    rightLines.selectAll \div.active .data ((d, i) -> klub.times[i].dostali)
      ..enter!append \div
        ..attr \class "entering active"
        ..transition!
          ..delay 10
          ..attr \class -> if it then "full active" else "active"
      ..exit!
        ..classed \exiting yes
        ..classed \active no
        ..transition!
          ..delay 800
          ..remove!
      ..classed "full" -> it

    countsLeft
      ..html (d, i) -> klub.times[i].dali.length
      ..style \right (d, i) -> "#{klub.times[i].dali.length * 100 / 40}%"
    countsRight
      ..html (d, i) -> klub.times[i].dostali.length
      ..style \left (d, i) -> "#{klub.times[i].dostali.length * 100 / 40}%"
  toDrawId = parseInt do
    window.location.hash.substr 6
    10
  toDraw = data[toDrawId || 0] || data[0]
  draw toDraw
  klubyItems
    ..classed \active (d, i) -> d == toDraw
