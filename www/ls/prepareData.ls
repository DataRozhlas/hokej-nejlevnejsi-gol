ig.getCasoveRozlozeni = ->
  d3.tsv.parse ig.data.casoveRozlozeni, (row) ->
    out = klub: row.klub
    out.times = for time in <[300 600 900 1200  1500  1800  2100  2400  2700  3000  3300  3600  3889  3900]>
      dali = parseInt row["dali#{time}"], 10
      dostali = parseInt row["dostali#{time}"], 10
      {dali, dostali}
    out
