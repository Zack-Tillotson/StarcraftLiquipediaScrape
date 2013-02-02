<?php

$id = filter_input(INPUT_GET, 'id', FILTER_SANITIZE_STRING);
$url = "http://www.starcrafttrends.com/data/player_detail_games.json.php?id=$id";
$curl = curl_init($url);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
$data_json = curl_exec($curl);
$data = json_decode($data_json, true);
?>
<table class="sortable">
  <thead>
    <tr>
      <td class="result">Result</td>
      <td class="name">Opponent</td>
      <td class="date">Date</td>
      <td class="event">Event</td>
    </tr>
  </thead>
  <tbody>
<?php foreach($data as $row) { ?>
    <tr class="<?php print strcmp($row["p1_name"], $id) == 0 ? "win" : "loss"?>">
      <td class="result <?php print strcmp($row["p1_name"], $id) == 0 ? "win" : "loss"?>"><?php print strcmp($row["p1_name"], $id) == 0 ? "W" : "L"; ?></td>
    <?php if(strcmp($row["p1_name"], $id) == 0) { ?>
      <td class="name">
        <span class="country"><img src="resources/<?php print $row["p2_country"]; ?>.png"></span>
        <span class="race race-icon <?php print $row["p2_race"]; ?>"><?php print $row["p2_race"]; ?></span>
        <a href="player_detail.php?id=<?php print $row["p2_name"]; ?>"><?php print $row["p2_name"]; ?></a>
      </td>
    <?php } else { ?>
      <td class="name">
        <span class="country"><img src="resources/<?php print $row["p1_country"]; ?>.png"></span>
        <span class="race race-icon <?php print $row["p1_race"]; ?>"><?php print $row["p1_race"]; ?></span>
        <a href="player_detail.php?id=<?php print $row["p1_name"]; ?>"><?php print $row["p1_name"]; ?></a>
      </td>
    <?php } ?>
      <td class="event"><?php print $row["event_id"]; ?></td>
      <td class="date"><?php print $row["date"]; ?></td>
    </tr>
<?php } ?>
  </tbody>
</table>
