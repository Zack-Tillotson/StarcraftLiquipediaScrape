<?php

$listSize = filter_input(INPUT_GET, 'length', FILTER_SANITIZE_STRING);

$url = "http://www.starcrafttrends.com/data/player_list.json.php";
$curl = curl_init($url);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
$data_json = curl_exec($curl);
$data = json_decode($data_json, true);
$odd = true;
?>
<table class="sortable">
  <thead>
    <tr>
      <td class="name">Player</td>
      <td class="race">Race</td>
      <td class="country">Country</td>
      <td class="wins">Wins</td>
      <td class="losses">Losses</td>
    </tr>
  </thead>
  <tbody>
<?php foreach(array_slice($data, 0, $listSize) as $row) { ?>
<tr <?php if($odd = !$odd) { ?>class="odd"<?php } ?>>
    <td class="name"><a href="player_detail.php?id=<?php print $row['name']; ?>"><?php print $row["name"]; ?></a></td>
    <td class=-"race"><span class="race-icon <?php print $row["race"]; ?>"><?php print $row["race"]; ?></span></td>
    <td class="country"><img src="/resources/<?php print $row["country"]; ?>.png" /></td>
    <td class="wins"><?php print $row["win_count"]; ?></td>
    <td class="wins"><?php print $row["loss_count"]; ?></td>
<?php } ?>
  </tbody>
</table>
