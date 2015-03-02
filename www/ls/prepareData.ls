ig.getCasoveRozlozeni = ->
  d3.tsv.parse ig.data.casoveRozlozeni, (row) ->
    out = klub: row.klub
    out.times = for time in <[300 600 900 1200  1500  1800  2100  2400  2700  3000  3300  3600  3889  3900]>
      daliCount = parseInt row["dali#{time}"], 10
      dostaliCount = parseInt row["dostali#{time}"], 10
      dali = for i in [0 to daliCount]
        i < daliCount - dostaliCount
      dostali = for i in [0 to dostaliCount]
        i < dostaliCount - daliCount
      {dali, dostali}
    out

ig.getCenaZaGol = ->
  d3.tsv.parse ig.data.cenaZaGol, (row) ->
    for i in <[branek domaci zapasu cena]>
      row[i] = parseInt row[i], 10
    row.cenaZaGol = row.zapasu * row.cena / row.branek
    row
