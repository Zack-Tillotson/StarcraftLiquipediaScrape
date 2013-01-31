<?php

$listSize = (isset($PLAYER_LIST_SIZE) ? $PLAYER_LIST_SIZE : '99999');

$url = "http://www.starcrafttrends.com/data/player_list.json.php";
$curl = curl_init($url);
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
    </tr>
  </thead>
  <tbody>
<?php foreach(array_slice($data, 0, $listSize) as $row) { ?>
  <tr>
    <td><a href="player_detail.php?id=<?php print $row['name']; ?>"><?php print $row["name"]; ?></a></td>
    <td><?php print $row["country"]; ?></td>
    <td><?php print $row["race"]; ?></td>
    <td><?php print $row["win_count"]; ?></td>
    <td><?php print $row["loss_count"]; ?></td>
<?php } ?>
  </tbody>
</table>
