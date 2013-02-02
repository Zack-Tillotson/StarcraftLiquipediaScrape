<?php
$player_id = filter_input(INPUT_GET, 'id', FILTER_SANITIZE_STRING);
?>
<html>
  <head>
    <?php include '_header.php'; ?>
    <?php include '_google_analytics.php'; ?>
  </head>
  <body>
    <div id="header"><a href="/">Starcraft Trends</a></div>
    <div id="body">
      <h1><?php include '_player_detail_bio.php'; ?></h1>
      <div id="games-graph"></div>
      <div id="games-list">
        <h2>Games List</h2>
        <?php include '_player_detail_games.php'; ?>
      </div>
    </div>
    <script type="text/javascript">
      makeGraphRaceWinCountsOverTime('games-graph', '<?php print $player_id; ?> Matches vs Each Race', '3 Month Moving Average, Source: <a href="http://wiki.liquipedia.net/starcraft2/Premier_Tournaments">Liquipedia, 2012 Premier Tournaments</a>', "http://www.starcrafttrends.com/data/player_detail_allgraph.json.php?id=<?php print $player_id; ?>");
    </script>
  </body>
</html
