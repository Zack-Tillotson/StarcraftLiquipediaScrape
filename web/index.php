<html>
  <head>
    <?php include '_header.php'; ?>
    <?php include '_google_analytics.php'; ?>
  </head>
  <body>
    <div id="header"><a href="/">Starcraft Trends</a><span class="links"><a href="http://us.blizzard.com/en-us/games/sc2/">SC</a>|<a href="http://wiki.teamliquid.net/starcraft2/Premier_Tournaments">Data</a>|<a href="http://zacherytillotson.com">Me</a></span></div>
    <div id="body">
      <div class="graph" id="graph1"><img class="loading" src="resources/loading.gif" /></div>
      <div class="graph" id="graph2"><img class="loading" src="resources/loading.gif" /></div>
      <div class="graph" id="graph3"><img class="loading" src="resources/loading.gif" /></div>
      <div id="player-list">
        <h2>Most Active Players<span class="more-link"><a href="player_list.php">more</a></span></h2>
        <div id="player-list-table"><img class="loading" src="resources/loading.gif" /></div>
      </div>
    </div>
    <div id="about">About: I love Starcraft and had a few minutes spare.<span class="cc">&copy <a href="http://www.zacherytillotson.com">Zack Tillotson</a></span></div>
    <script type="text/javascript">
      makeGraphRaceOverTime('graph1', 'All Matches', '3 Month Moving Average, Source: <a href="http://wiki.liquipedia.net/starcraft2/Premier_Tournaments">Liquipedia, 2012 Premier Tournaments</a>', "http://www.starcrafttrends.com/data/race_wins.json.php");
      makeGraphRaceOverTime('graph2', 'Foreigners vs Korean Opponents', '3 Month Moving Average, Source: <a href="http://wiki.liquipedia.net/starcraft2/Premier_Tournaments">Liquipedia, 2012 Premier Tournaments</a>', "http://www.starcrafttrends.com/data/forvskr.json.php");
      makeGraphRaceOverTime('graph3', 'Koreans vs Korean Opponents', '3 Month Moving Average, Source: <a href="http://wiki.liquipedia.net/starcraft2/Premier_Tournaments">Liquipedia, 2012 Premier Tournaments</a>', "http://www.starcrafttrends.com/data/krvskr.json.php");
      $('#player-list-table').load('_player_list.php?length=50');
    </script>
  </body>
</html
