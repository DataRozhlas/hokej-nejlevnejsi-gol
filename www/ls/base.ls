container = d3.select ig.containers.base
switch window.location.hash
  | \#ceny    => ig.drawCenaZaGol container
  | \#goly    => ig.drawGoly container
  | otherwise => ig.drawCasoveRozlozeni container
