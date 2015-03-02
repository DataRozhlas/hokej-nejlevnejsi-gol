container = d3.select ig.containers.base
switch window.location.hash
  | \#ceny    => ig.drawCenaZaGol container
  | otherwise => ig.drawCasoveRozlozeni container
