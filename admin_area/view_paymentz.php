<?php 
    
    if(!isset($_SESSION['admin_email'])){
        
        echo "<script>window.open('login.php','_self')</script>";
        
    }else{

?>

<div class="row"><!-- row 1 begin -->
    <div class="col-lg-12"><!-- col-lg-12 begin -->
        <ol class="breadcrumb"><!-- breadcrumb begin -->
            <li class="active"><!-- active begin -->
                
                <i class="fa fa-dashboard"></i> Dashboard / View Reports
                
            </li><!-- active finish -->
        </ol><!-- breadcrumb finish -->
    </div><!-- col-lg-12 finish -->
</div><!-- row 1 finish -->

<div class="row"><!-- row 2 begin -->
    <div class="col-lg-12"><!-- col-lg-12 begin -->
        <div class="panel panel-default"><!-- panel panel-default begin -->
            <div class="panel-heading"><!-- panel-heading begin -->
               <h3 class="panel-title"><!-- panel-title begin -->
               
                   <i class="fa fa-tags"></i>  View Reports
                
               </h3><!-- panel-title finish --> 
            </div><!-- panel-heading finish -->
            
            <div class="panel-body"><!-- panel-body begin -->
                <div class="table-responsive"><!-- table-responsive begin -->
                    <table class="table table-striped table-bordered table-hover"><!-- table table-striped table-bordered table-hover begin -->
                        
                            <th>DAILY</th>
                            <th>DAILY</th>
                            <th>DAILY</th>
                        <tr>

                            <td style="text-align:center;">Sales
<br>
                            <?php
                            $currentday= date("z");
                            
                            //sum sales done today
                            $sql1= "SELECT SUM(amount) from payments WHERE current_day='$currentday'";
                            $sql2= mysqli_query($con, $sql1);
                            $result=mysqli_fetch_array($sql2);


                            $sql3= "SELECT amount from payments WHERE current_day='$currentday'";
                            $sql4= mysqli_query($con, $sql3);
                            $result1=mysqli_fetch_array($sql4);
                            $rows=mysqli_num_rows($sql4);

                            if ($rows>0) {
                                # code...
                                echo"ksh $result[0]";
                                
                            } else {
                                # code...
                                echo"No sales made today";
                            }
                            

                
                ?>
                            </td>
                            <td style="text-align:center;">Average transactional value
                            <?php
                            echo"<br>";
                            if ($rows>0) {
                                # code...
                                $avt=$result[0]/$rows;
                            echo"KSH $avt";
                            } else {
                                # code...
                                echo"No sales made today";
                            }
                            ?>
                            </td>
                            <td  style="text-align:center;">Average units sold
                                <?php
                            $sql5= "SELECT SUM(qty) from customer_orders WHERE current_day='$currentday'";
                            $sql6= mysqli_query($con, $sql5);
                            $result2=mysqli_fetch_array($sql6);


                            $sql7= "SELECT qty from customer_orders WHERE current_day='$currentday'";
                            $sql8= mysqli_query($con, $sql7);
                            $result3=mysqli_fetch_array($sql8);
                            $rows1=mysqli_num_rows($sql8);
                            echo"<br>";

                            if ($rows1>0) {
                                # code...
                                $aus=$result[0]/$result2[0];
                            echo"KSH $aus";
                                
                            } else {
                                # code...
                                echo"No sales made today";
                            }

                            ?>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:center;">Number of products sold

                            <?php
                            $sql5= "SELECT SUM(qty) from customer_orders WHERE current_day='$currentday'";
                            $sql6= mysqli_query($con, $sql5);
                            $result2=mysqli_fetch_array($sql6);


                            $sql7= "SELECT qty from customer_orders WHERE current_day='$currentday'";
                            $sql8= mysqli_query($con, $sql7);
                            $result3=mysqli_fetch_array($sql8);
                            $rows1=mysqli_num_rows($sql8);
                            echo"<br>";

                            if ($rows1>0) {
                                # code...
                                echo"$result2[0] items";
                                
                            } else {
                                # code...
                                echo"No sales made today";
                            }

                            ?>
                            </td>
                            <td style="text-align:center;">Units sold per transaction
                            <br>
                            <?php
                            if ($rows>0) {
                                # code...
                                $upt= $result2[0]/$rows;
                                echo"$upt";
                            } else {
                                # code...
                                echo"No sales made today";
                            }
                            
                            ?>

                            </td>
                            <td style="text-align:center;">Net Profit/loss</td>

                        </tr>
                        
                    </table><!-- table table-striped table-bordered table-hover finish -->
                    <table class="table table-striped table-bordered table-hover">
                        <th>WEEKLY</th>
                        <th>WEEKLY</th>
                        <th>WEEKLY</th>
                        <tr><td style="text-align:center;">Sales</td>
                    <td style="text-align:center;">Average transactional value</td>
                <td style="text-align:center;">Average units sold</td>
            </tr>
                        <tr>
                        <td style="text-align:center;">Number of Products Sold</td>
                    <td style="text-align:center;">Units Sold per transaction</td>
                <td style="text-align:center;">Net profit/loss</td>

                        </tr>
                        
                    </table>
                    <table class="table table-striped table-bordered table-hover">
                        <th>MONTHLY</th>
                        <th>MONTHLY</th>
                        <th>MONTHLY</th>
                        <tr><td style="text-align:center;">Sales</td>
                    <td style="text-align:center;">Average transactional value</td>
                <td style="text-align:center;">Average units sold</td>
            </tr>
                        <tr>
                        <td style="text-align:center;">Number of Products Sold</td>
                    <td style="text-align:center;">Units Sold per transaction</td>
                <td style="text-align:center;">Net profit/loss</td>

                        </tr>
                    </table>
                </div><!-- table-responsive finish -->
        
                <P style="margin-left:40%"><b>SAME TIME LAST YEAR</b></P>
                <table class="table table-striped table-bordered table-hover"><!-- table table-striped table-bordered table-hover begin -->
                        
                            <th>DAILY</th>
                            <th>DAILY</th>
                            <th>DAILY</th>
                        <tr>

                            <td style="text-align:center;">Sales
<br>
                            <?php
                            $currentday= date("z");
                            
                            //sum sales done today
                            $sql1= "SELECT SUM(amount) from payments WHERE current_day='$currentday'";
                            $sql2= mysqli_query($con, $sql1);
                            $result=mysqli_fetch_array($sql2);


                            $sql3= "SELECT amount from payments WHERE current_day='$currentday'";
                            $sql4= mysqli_query($con, $sql3);
                            $result1=mysqli_fetch_array($sql4);
                            $rows=mysqli_num_rows($sql4);

                            if ($rows>0) {
                                # code...
                                echo"ksh $result[0]";
                                
                            } else {
                                # code...
                                echo"No sales made today";
                            }
                            

                
                ?>
                            </td>
                            <td style="text-align:center;">Average transactional value
                            <?php
                            echo"<br>";
                            if ($rows>0) {
                                # code...
                                $avt=$result[0]/$rows;
                            echo"KSH $avt";
                            } else {
                                # code...
                                echo"No sales made today";
                            }
                            ?>
                            </td>
                            <td  style="text-align:center;">Average units sold
                                <?php
                            $sql5= "SELECT SUM(qty) from customer_orders WHERE current_day='$currentday'";
                            $sql6= mysqli_query($con, $sql5);
                            $result2=mysqli_fetch_array($sql6);


                            $sql7= "SELECT qty from customer_orders WHERE current_day='$currentday'";
                            $sql8= mysqli_query($con, $sql7);
                            $result3=mysqli_fetch_array($sql8);
                            $rows1=mysqli_num_rows($sql8);
                            echo"<br>";

                            if ($rows1>0) {
                                # code...
                                $aus=$result[0]/$result2[0];
                            echo"KSH $aus";
                                
                            } else {
                                # code...
                                echo"No sales made today";
                            }

                            ?>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:center;">Number of products sold

                            <?php
                            $sql5= "SELECT SUM(qty) from customer_orders WHERE current_day='$currentday'";
                            $sql6= mysqli_query($con, $sql5);
                            $result2=mysqli_fetch_array($sql6);


                            $sql7= "SELECT qty from customer_orders WHERE current_day='$currentday'";
                            $sql8= mysqli_query($con, $sql7);
                            $result3=mysqli_fetch_array($sql8);
                            $rows1=mysqli_num_rows($sql8);
                            echo"<br>";

                            if ($rows1>0) {
                                # code...
                                echo"$result2[0] items";
                                
                            } else {
                                # code...
                                echo"No sales made today";
                            }

                            ?>
                            </td>
                            <td style="text-align:center;">Units sold per transaction
                            <br>
                            <?php
                            if ($rows>0) {
                                # code...
                                $upt= $result2[0]/$rows;
                                echo"$upt";
                            } else {
                                # code...
                                echo"No sales made today";
                            }
                            
                            ?>

                            </td>
                            <td style="text-align:center;">Net Profit/loss</td>

                        </tr>
                        
                    </table><!-- table table-striped table-bordered table-hover finish -->
                    <table class="table table-striped table-bordered table-hover">
                        <th>WEEKLY</th>
                        <th>WEEKLY</th>
                        <th>WEEKLY</th>
                        <tr><td style="text-align:center;">Sales</td>
                    <td style="text-align:center;">Average transactional value</td>
                <td style="text-align:center;">Average units sold</td>
            </tr>
                        <tr>
                        <td style="text-align:center;">Number of Products Sold</td>
                    <td style="text-align:center;">Units Sold per transaction</td>
                <td style="text-align:center;">Net profit/loss</td>

                        </tr>
                        
                    </table>
                    <table class="table table-striped table-bordered table-hover">
                        <th>MONTHLY</th>
                        <th>MONTHLY</th>
                        <th>MONTHLY</th>
                        <tr><td style="text-align:center;">Sales</td>
                    <td style="text-align:center;">Average transactional value</td>
                <td style="text-align:center;">Average units sold</td>
            </tr>
                        <tr>
                        <td style="text-align:center;">Number of Products Sold</td>
                    <td style="text-align:center;">Units Sold per transaction</td>
                <td style="text-align:center;">Net profit/loss</td>

                        </tr>
                    </table>
                </div><!-- table-responsive finish -->
        
                    
            </div><!-- panel-body finish -->
            
        </div><!-- panel panel-default finish -->
    </div><!-- col-lg-12 finish -->
</div><!-- row 2 finish -->

<?php } ?>