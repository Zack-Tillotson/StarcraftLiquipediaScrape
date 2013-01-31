<?php
include_once '_mysql_connect.php'

$id = $_GET['id'];
$query = sprintf("select p1_name, p1_country, p1_race, p2_name, p2_country, p2_race, event_id, date_format(play_date, '%%b %%Y') play_date, map from games where p1_name like binary '%s' or p2_name like binary '%s' order by play_date, event_id asc", mysql_real_escape_string($id), mysql_real_escape_string($id));
$result = mysql_query($query) or die(mysql_error());

$rows = array();
while($row = mysql_fetch_array( $result )) {
  $rows[] = $row;
}
print json_encode(array_reverse($rows));
?>
