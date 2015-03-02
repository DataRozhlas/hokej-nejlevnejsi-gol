ig.drawGoly = (parentElement) ->
  data = ig.getCenaZaGol!
  data .= sort (a, b) -> a.domacichGolu - b.domacichGolu
  parentElement.append \div .attr \class \goly
    ..selectAll \div.klub .data data .enter!append \div
      ..attr \class \klub
      ..append \div
        ..attr \class \title
        ..html -> it.klub
      ..append \div
        ..attr \class \percentage
        ..html -> "#{ig.utils.formatNumber (1 - it.domacichGolu) * 100, 2} %"
      ..append \div
        ..attr \class \centerline
      ..append \div
        ..attr \class \bar
        ..classed \positive -> it.domacichGolu <= 0.5
        ..style \width -> "#{300 * Math.abs 0.5 - it.domacichGolu}%"
