<!DOCTYPE html>
<html>
<head>
 <title>Table with database</title>
 <style>
  table {
   border-collapse: collapse;
   width: 100%;
   color: #588c7e;
   font-family: monospace;
   font-size: 25px;
   text-align: left;
     }
  th {
   background-color: #588c7e;
   color: white;
    }
  tr:nth-child(even) {background-color: #f2f2f2}
 </style>
</head>
<body>
 <table>
 <tr>
  <th>id</th>
  <th>name</th>
  <th>lastname</th>
  <th>age</th>
 </tr>
<?php
$database ="inbay";  
$user = "root";  
$password = "rashmika";  
$host = "my-sql-db";  
$connection = new PDO("mysql:host={$host};dbname={$database};charset=utf8", $user, $password);
$sql = "SELECT id, name, lastname, age FROM register {% if PEOPLE_AGE is defined %} where age = {{ PEOPLE_AGE }} {% endif %}";
$result = $connection->query($sql);  
   if ($result->num_rows > 0) {
   // output data of each row
   while($row = $result->fetch_assoc()) {
    echo "<tr><td>" . $row["id"]. "</td><td>" . $row["name"] . "</td><td>"
. $row["lastname"]. "</td><td>" . $row["age"]. "</td></tr>";
  }
    echo "</table>";
  } else { echo "0 results"; }

$connection->close();
echo "Rashmika Manawadu";

?>
</table>
</body>
</html>