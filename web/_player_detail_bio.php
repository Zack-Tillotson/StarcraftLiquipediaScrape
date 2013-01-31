<?php

$id = filter_input(INPUT_GET, 'id', FILTER_SANITIZE_STRING);
$url = "http://www.starcrafttrends.com/data/player_detail_bio.json.php?id=$id";
$curl = curl_init($url);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
$data_json = curl_exec($curl);
$data = json_decode($data_json, true);
?>
<div class="country">Country: <?php print $data[0]['country']; ?></div>
<div class="race">Race: <?php print $data[0]['race']; ?></div>
