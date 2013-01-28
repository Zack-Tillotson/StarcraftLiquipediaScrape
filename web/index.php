<html>
  <head>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script type="text/javascript" src="/resources/highcharts.js"></script>
    <script src="graphRaceWinsOverTime.js.php?container=graph1"></script>
    <script src="graphForeignVsKrRaceWinsOverTime.js.php?container=graph2"></script>
    <script src="graphKrVsKrRaceWinsOverTime.js.php?container=graph3"></script>
    <link href='http://fonts.googleapis.com/css?family=Inconsolata:400,700' rel='stylesheet' type='text/css'>
    <link href="style.css" rel="stylesheet" type="text/css" />
  </head>
  <body>
    <h1>SC Trends (Preview)</h1>
    <div class="graph" id="graph1"></div>
    <div class="graph" id="graph2"></div>
    <div class="graph" id="graph3"></div>
    <div id="player-list"><?php include('player_list.php'); ?></div>
  </body>
</html
