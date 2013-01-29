<?php

$id = filter_input(INPUT_GET, 'id', FILTER_SANITIZE_STRING);
$url = "http://zacherytillotson.com/sctrends/data/player_detail_games.json.php?id=$id";
$curl = curl_init($url);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
$data_json = curl_exec($curl);
$data = json_decode($data_json, true);
?>
<table>
  <thead>
    <tr>
      <td colspan=3>Opponent</td>
      <td>Event</td>
      <td>Date</td>
    </tr>
  </thead>
  <tbody>
<?php foreach($data as $row) { ?>
  <tr class="<?php print strcmp($row["p1_name"], $id) == 0 ? "win" : "loss"?>">
    <?php if(strcmp($row["p1_name"], $id) == 0) { ?>
    <td><?php print $row["p2_name"]; ?></td>
    <td><?php print $row["p2_country"]; ?></td>
    <td><?php print $row["p2_race"]; ?></td>
    <?php } else { ?>
    <td><?php print $row["p1_name"]; ?></td>
    <td><?php print $row["p1_country"]; ?></td>
    <td><?php print $row["p1_race"]; ?></td>
    <?php } ?>
    <td><?php print $row["event_id"]; ?></td>
    <td><?php print $row["play_date"]; ?></td>
<?php } ?>
  </tbody>
</table>
