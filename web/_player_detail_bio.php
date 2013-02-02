<?php

$id = filter_input(INPUT_GET, 'id', FILTER_SANITIZE_STRING);
$url = "http://www.starcrafttrends.com/data/player_detail_bio.json.php?id=$id";
$curl = curl_init($url);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
$data_json = curl_exec($curl);
$data = json_decode($data_json, true);
?>
Player: 
<span class="name"><?php print $id; ?></span>
<span class="country"><img src="resources/<?php print $data[0]['country']; ?>.png" height=20 /></span>
<span class="race-icon <?php print $data[0]['race']; ?>"><?php print $data[0]['race']; ?></span>
