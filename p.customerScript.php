<?php 

    $active='Account';
    include("includes/header.php");
    $con = mysqli_connect("localhost","root","","e_retail");
    if(isset($_POST['register'])){
    
        $c_name = $_POST['c_name'];
        
        $c_email = $_POST['c_email'];
        
        $c_pass = $_POST['c_pass'];
        
        $c_city = $_POST['c_city'];
        
        $c_contact = $_POST['c_contact'];
        
        $c_address = $_POST['c_address'];
        $town = $_POST['town'];

        echo"$town ";
        
        $c_image = $_FILES['c_image']['name'];
        
        $c_image_tmp = $_FILES['c_image']['tmp_name'];
        
        $c_ip = getRealIpUser();
        
        $sql_u = "select * from customeri where customer_email='$c_email' ";
        
        $res_e=mysqli_query($con,$sql_u);
        
        if(mysqli_num_rows($res_e)>0)
        {
             echo "<script>alert('This email already has an account registered')</script>";
               // echo "<script>window.open('customer_register.php'_self')</script>";
        }
        else{
        
        move_uploaded_file($c_image_tmp,"customer/customer_images/$c_image");
        
        $insert_customer = "insert into customeri(customer_name,customer_email,customer_pass,customer_city,customer_contact,customer_address,customer_image,customer_ip,town) values ('$c_name','$c_email','$c_pass','$town','$c_contact','$c_address','$c_image','$c_ip','$town')";
        
        $run_customer = mysqli_query($con,$insert_customer);
        
        $sel_cart = "select * from cart where ip_add='$c_ip'";
        
        $run_cart = mysqli_query($con,$sel_cart);
        
        $check_cart = mysqli_num_rows($run_cart);
        
        if($check_cart>0){
            
            /// If register have items in cart ///
            
            $_SESSION['customer_email']=$c_email;
            
            echo "<script>alert('You have been Registered Sucessfully')</script>";
            
            echo "<script>window.open('checkout.php','_self')</script>";
            
        }else{
            
            /// If register without items in cart ///
            
            $_SESSION['customer_email']=$c_email;
            
            echo "<script>alert('You have been Registered Sucessfully')</script>";
            
            echo "<script>window.open('index.php','_self')</script>";
            
            }
        
        }
    }
    
?>