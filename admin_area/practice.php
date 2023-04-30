<?php 

$con = mysqli_connect("localhost","root","","e_retail");
$admin_email= 'akash@gmail.com';
$sql= "SELECT admin_about, admin_contact, admin_job FROM admins WHERE admin_email= '$admin_email'";
            $sql1= mysqli_query($con,$sql);
            $results= mysqli_fetch_array($sql1);
    
            $_SESSION['admin_about']= $results[0];
            $_SESSION['admin_contact']= $results[1];
            $_SESSION['admin_job']= $results[2];
            echo"$results[1]";

?>