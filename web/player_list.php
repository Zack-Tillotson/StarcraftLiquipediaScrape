<?php

$listSize = isset($_GET['size']) ? $_GET['size'] : '99999';

$curl = curl_init('http://zacherytillotson.com/sctrends/data/player_list.json.php');
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
$data_json = curl_exec($curl);
$data = json_decode($data_json, true);
?>
<table>
  <thead>
    <tr>
      <td>Name</td>
      <td>Country</td>
      <td>Race</td>
      <td>Win Count</td>
      <td>Loss Count</td>
      <td>Game Count</td>
    </tr>
  </thead>
  <tbody>
<?php foreach(array_slice($data, 0, $listSize) as $row) { ?>
  <tr>
    <td><?php print $row["name"]; ?></td>
    <td><?php print $row["country"]; ?></td>
    <td><?php print $row["race"]; ?></td>
    <td><?php print $row["win_count"]; ?></td>
    <td><?php print $row["loss_count"]; ?></td>
    <td><?php print $row["win_count"] + $row["loss_count"]; ?></td>
<?php } ?>
  </tbody>
</table>
