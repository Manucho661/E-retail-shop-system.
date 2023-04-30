<?php 
    
    if(!isset($_SESSION['admin_email'])){
        
        echo "<script>window.open('login.php','_self')</script>";
        
    }else{
    ?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
<link rel="stylesheet" href="reports.css">
</head>
<body>
    <div class="ttable">
<table>
    <th></th>
    <tr>
        <td>Sales</td>
        <td>ATV</td>
        <td>Products sold</td>
    </tr>
    <tr>
        <td>Average unit sold price</td>
        <td>Units sold per transaction</td>
        <td>Out of stock items</td>
    </tr>
</table>
    </div>
    
</body>
</html>
<?php
    }
?>