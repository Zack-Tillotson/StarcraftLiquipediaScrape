<?php
$player_id = filter_input(INPUT_GET, 'id', FILTER_SANITIZE_STRING);
?>
<html>
  <head>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script type="text/javascript" src="/resources/highcharts.js"></script>
    <script src="graph.js"></script>
    <link href='http://fonts.googleapis.com/css?family=Inconsolata:400,700' rel='stylesheet' type='text/css'>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <?php include '_google_analytics.php'; ?>
  </head>
  <body>
    <h1><?php print $player_id; ?></h1>
    <div id="player-bio"><?php include '_player_detail_bio.php'; ?></div>
    <div id="games-graph"></div>
    <div id="games-list"><?php include '_player_detail_games.php'; ?></div>
    <script type="text/javascript">
      makeGraphRaceOverTime('games-graph', '<?php print $player_id; ?> Matches vs Each Race', '3 Month Moving Average, Source: <a href="http://wiki.liquipedia.net/starcraft2/Premier_Tournaments">Liquipedia, 2012 Premier Tournaments</a>', "http://www.starcrafttrends.com/data/player_detail_allgraph.json.php?id=<?php print $player_id; ?>");
    </script>
  </body>
</html
