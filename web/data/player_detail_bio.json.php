<?php
include_once '_mysql_connect.php'

$id = $_GET['id'];
$query = sprintf("select a.name, a.country, b.race from (select name, country, count(*) cnt from ((select p1_name name, p1_country country from games where p1_name like binary '%s' and p1_country != '') union all (select p2_name name, p2_country country from games where p2_name like binary '%s' and p2_country != '')) a group by name, country order by cnt desc limit 1) a left join (select name, race, count(*) cnt from ((select p1_name name, p1_race race from games where p1_name like binary '%s'     and p1_race != '') union all (select p2_name name, p2_race race from games where p2_name like binary '%s' and p2_race != '')) a group by name, race order by cnt desc     limit 1) b on a.name = b.name", mysql_real_escape_string($id), mysql_real_escape_string($id), mysql_real_escape_string($id), mysql_real_escape_string($id));

$result = mysql_query($query) or die(mysql_error());
$rows = array();
while($row = mysql_fetch_array( $result )) {
  $rows[] = $row;
}
print json_encode(array_reverse($rows));
?>
