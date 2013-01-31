<?php
  $PLAYER_LIST_SIZE = 15;
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
    <h1>SC Trends (Preview)</h1>
    <div class="graph" id="graph1"></div>
    <div class="graph" id="graph2"></div>
    <div class="graph" id="graph3"></div>
    <div id="player-list">
      <h2><a href="player_list.php">Players</a></h2>
      <?php include('_player_list.php'); ?>
    </div>
    <script type="text/javascript">
      makeGraphRaceOverTime('graph1', 'All Matches', '3 Month Moving Average, Source: <a href="http://wiki.liquipedia.net/starcraft2/Premier_Tournaments">Liquipedia, 2012 Premier Tournaments</a>', "http://www.starcrafttrends.com/data/race_wins.json.php");
      makeGraphRaceOverTime('graph2', 'Foreigners vs Korean Opponents', '3 Month Moving Average, Source: <a href="http://wiki.liquipedia.net/starcraft2/Premier_Tournaments">Liquipedia, 2012 Premier Tournaments</a>', "http://www.starcrafttrends.com/data/forvskr.json.php");
      makeGraphRaceOverTime('graph3', 'Koreans vs Korean Opponents', '3 Month Moving Average, Source: <a href="http://wiki.liquipedia.net/starcraft2/Premier_Tournaments">Liquipedia, 2012 Premier Tournaments</a>', "http://www.starcrafttrends.com/data/krvskr.json.php");
    </script>
  </body>
</html
