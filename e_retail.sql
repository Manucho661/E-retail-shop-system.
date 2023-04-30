-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 26, 2019 at 08:49 AM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.1.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `e_retail`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_count` (OUT `counter` INT, IN `customer_email` VARCHAR(255))  BEGIN
	SELECT COUNT(*) INTO counter
    FROM customers
    WHERE customers.customer_email = customer_email;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_stock` (OUT `stock` INT, IN `product_id` INT)  BEGIN
	SELECT p_qty INTO stock
    FROM products p
    WHERE P.product_id = product_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `admin_id` int(10) NOT NULL,
  `admin_name` varchar(255) NOT NULL,
  `admin_email` varchar(255) NOT NULL,
  `admin_pass` varchar(255) NOT NULL,
  `admin_image` varchar(255) NOT NULL,
  `admin_about` text NOT NULL,
  `admin_contact` int(10) NOT NULL,
  `admin_job` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`admin_id`, `admin_name`, `admin_email`, `admin_pass`, `admin_image`, `admin_about`, `admin_contact`, `admin_job`) VALUES
(1, 'manoj', 'manoj1@gmail.com', '12345', 'member3.jpg', 'The creator of the website', 1234567896, 'Developer'),
(2, 'akash', 'akash@gmail.com', '12345', 'member2.jpg', 'ewdfwefdsfewsdxc', 2147483647, 'developer');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `p_id` int(10) NOT NULL,
  `ip_add` varchar(255) NOT NULL,
  `qty` int(10) NOT NULL,
  `size` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `cart`
--
DELIMITER $$
CREATE TRIGGER `is_stock_available` AFTER INSERT ON `cart` FOR EACH ROW BEGIN
	DECLARE stock INT;
    CALL get_stock(stock,NEW.p_id);
    IF NEW.qty > stock THEN
    	DELETE FROM cart
        WHERE p_id = NEW.p_id;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `cat_id` int(10) NOT NULL,
  `cat_title` text NOT NULL,
  `cat_desc` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`cat_id`, `cat_title`, `cat_desc`) VALUES
(1, 'Men', 'Choose from our Wide range and best collection of products for men.'),
(2, 'Women', 'Choose from our Wide range and best collection of products for Women.'),
(3, 'Kids', 'Choose from our Wide range and best collection of products for Kids.'),
(4, 'home', 'Choose from our Wide range and best collection of products your homes.');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(10) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `customer_email` varchar(255) NOT NULL,
  `customer_pass` varchar(255) NOT NULL,
  `customer_city` text NOT NULL,
  `customer_contact` int(10) NOT NULL,
  `customer_address` text NOT NULL,
  `customer_image` text NOT NULL,
  `customer_ip` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `customer_name`, `customer_email`, `customer_pass`, `customer_city`, `customer_contact`, `customer_address`, `customer_image`, `customer_ip`) VALUES
(1, 'erika', 'erika@gmail.com', '123456', 'banglore', 2147483647, '6th main banglore karnataka', 'Erika.jpg', '::1'),
(7, 'akash', 'awnk@gmail.com', '123456', 'madrid', 2147483647, 'efdscgfdseesdf', 'Arief.jpeg', '127.0.0.1');

--
-- Triggers `customers`
--
DELIMITER $$
CREATE TRIGGER `CUSTOMER_AFTER_INSERT` AFTER INSERT ON `customers` FOR EACH ROW BEGIN
	DECLARE counter INT;
    CALL get_count(counter, NEW.customer_email);
    IF counter > 1 THEN
    	DELETE FROM customers 
        WHERE customer_id = NEW.customer_id;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customer_orders`
--

CREATE TABLE `customer_orders` (
  `order_id` int(10) NOT NULL,
  `customer_id` int(10) NOT NULL,
  `due_amount` int(100) NOT NULL,
  `invoice_no` int(100) NOT NULL,
  `qty` int(10) NOT NULL,
  `size` text NOT NULL,
  `order_date` date NOT NULL,
  `order_status` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer_orders`
--

INSERT INTO `customer_orders` (`order_id`, `customer_id`, `due_amount`, `invoice_no`, `qty`, `size`, `order_date`, `order_status`) VALUES
(6, 1, 300, 1200584179, 1, 'Medium', '2019-11-06', 'Complete'),
(7, 1, 600, 1803508524, 2, 'Medium', '2019-11-06', 'pending'),
(8, 1, 300, 1970970519, 1, 'Large', '2019-11-07', 'pending'),
(9, 1, 200, 1873611678, 1, 'Large', '2019-11-07', 'pending'),
(11, 1, 300, 366217573, 1, 'Small', '2019-11-13', 'pending'),
(12, 7, 200, 2075871979, 1, 'Large', '2019-11-24', 'Complete'),
(13, 7, 300, 2075871979, 1, 'Medium', '2019-11-24', 'Complete');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(10) NOT NULL,
  `invoice_no` int(10) NOT NULL,
  `amount` int(10) NOT NULL,
  `payment_mode` text NOT NULL,
  `ref_no` int(10) NOT NULL,
  `code` int(10) NOT NULL,
  `payment_date` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `invoice_no`, `amount`, `payment_mode`, `ref_no`, `code`, `payment_date`) VALUES
(2, 1200584179, 300, 'Paytm', 1200584179, 0, '6.11.19'),
(3, 2075871979, 200, 'Paytm', 1200584179, 0, '6.11.19'),
(4, 2075871979, 300, 'Offline', 1200584179, 0, '6.11.19');

-- --------------------------------------------------------

--
-- Table structure for table `pending_orders`
--

CREATE TABLE `pending_orders` (
  `order_id` int(10) NOT NULL,
  `customer_id` int(10) NOT NULL,
  `invoice_no` int(10) NOT NULL,
  `product_id` text NOT NULL,
  `qty` int(10) NOT NULL,
  `size` text NOT NULL,
  `order_status` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pending_orders`
--

INSERT INTO `pending_orders` (`order_id`, `customer_id`, `invoice_no`, `product_id`, `qty`, `size`, `order_status`) VALUES
(6, 1, 1200584179, '5', 1, 'Medium', 'Complete'),
(7, 1, 1803508524, '4', 2, 'Medium', 'pending'),
(8, 1, 1970970519, '5', 1, 'Large', 'pending'),
(9, 1, 1873611678, '1', 1, 'Large', 'pending'),
(12, 7, 2075871979, '1', 1, 'Large', 'Complete'),
(13, 7, 2075871979, '4', 1, 'Medium', 'Complete');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(10) NOT NULL,
  `p_cat_id` int(10) NOT NULL,
  `cat_id` int(10) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `product_title` text NOT NULL,
  `product_img1` text NOT NULL,
  `product_img2` text NOT NULL,
  `product_img3` text NOT NULL,
  `product_price` int(10) NOT NULL,
  `p_qty` int(10) NOT NULL,
  `product_desc` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `p_cat_id`, `cat_id`, `date`, `product_title`, `product_img1`, `product_img2`, `product_img3`, `product_price`, `p_qty`, `product_desc`) VALUES
(1, 1, 1, '2019-11-07 04:54:16', 'polo jacket', 'Man-Geox-Winter-jacket-1.jpg', 'Man-Geox-Winter-jacket-2.jpg', 'Man-Geox-Winter-jacket-3.jpg', 200, 100, 'Navy blue solid bomber, has a mock collar, two insert pockets, one internal pocket , zip closure, long sleeves, straight hem'),
(2, 3, 2, '2019-11-07 04:54:47', 'corsica high heels', 'High Heels Women Pantofel Brukat-2.jpg', 'High Heels Women Pantofel Brukat-3.jpg', 'High Heels Women Pantofel Brukat-1.jpg', 100, 50, 'A pair of beige pointed toe pumps, has regular styling, closed back detail\r\nSynthetic upper\r\nCushioned footbed\r\nTextured and patterned outsole, has a stiletto heel'),
(3, 3, 1, '2019-11-07 04:55:07', 'mont blank belt', 'Mont-Blanc-Belt-man-1.jpg', 'Mont-Blanc-Belt-man-2.jpg', 'Mont-Blanc-Belt-man-3.jpg', 50, 10, 'Black solid belt\r\nReversible: No\r\nStretchable: No\r\nSecured with a tang\r\nWarranty: 6 months\r\nWarranty provided by brand/manufacturer'),
(4, 1, 2, '2019-11-07 04:55:26', 'levis jacket', 'Red-Winter-jacket-1.jpg', 'Red-Winter-jacket-2.jpg', 'Red-Winter-jacket-3.jpg', 300, 30, 'Pink solid jacket, has a hooded, 2 pockets, zip closure, long sleeves, straight hem, and polyester lining'),
(5, 4, 1, '2019-11-07 04:55:46', 'polo jeans', 'Man-Polo-1.jpg', 'Man-Polo-2.jpg', 'Man-Polo-3.jpg', 300, 15, 'Blue dark wash 5-pocket mid-rise jeans, clean look with heavy fade, has a button and zip closure, waistband with belt loops');

-- --------------------------------------------------------

--
-- Table structure for table `product_categories`
--

CREATE TABLE `product_categories` (
  `p_cat_id` int(10) NOT NULL,
  `p_cat_title` text NOT NULL,
  `p_cat_desc` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product_categories`
--

INSERT INTO `product_categories` (`p_cat_id`, `p_cat_title`, `p_cat_desc`) VALUES
(1, 'Jackets', 'Wide Range of Jackets to choose from ,From all the Brands you love.'),
(2, 'Shirts', 'Wide Range of Shirts to choose from ,From all the Brands you love.'),
(3, 'Accessories', 'Wide Range of Accessories to choose from ,From all the Brands you love.'),
(4, 'Jeans', 'Wide Range of Jeans to choose from ,From all the Brands you love.');

-- --------------------------------------------------------

--
-- Table structure for table `slider`
--

CREATE TABLE `slider` (
  `slide_id` int(10) NOT NULL,
  `slide_name` varchar(255) NOT NULL,
  `slide_image` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `slider`
--

INSERT INTO `slider` (`slide_id`, `slide_name`, `slide_image`) VALUES
(1, 'Slide number 1', 'slider-1.jpg'),
(2, 'Slide number 2', 'slide-5.jpg'),
(3, 'Slide number 3', 'slide-4.jpg'),
(5, 'slide number 4', 'slide-7.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`p_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`cat_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `customer_orders`
--
ALTER TABLE `customer_orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `fk_cust_Id` (`customer_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`);

--
-- Indexes for table `pending_orders`
--
ALTER TABLE `pending_orders`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `fk_p_cat_Id` (`p_cat_id`),
  ADD KEY `fk_cat_id` (`cat_id`);

--
-- Indexes for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`p_cat_id`);

--
-- Indexes for table `slider`
--
ALTER TABLE `slider`
  ADD PRIMARY KEY (`slide_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `admin_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `cat_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `customer_orders`
--
ALTER TABLE `customer_orders`
  MODIFY `order_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `pending_orders`
--
ALTER TABLE `pending_orders`
  MODIFY `order_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `product_categories`
--
ALTER TABLE `product_categories`
  MODIFY `p_cat_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `slider`
--
ALTER TABLE `slider`
  MODIFY `slide_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer_orders`
--
ALTER TABLE `customer_orders`
  ADD CONSTRAINT `fk_cust_Id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_cat_id` FOREIGN KEY (`cat_id`) REFERENCES `categories` (`cat_id`),
  ADD CONSTRAINT `fk_p_cat_Id` FOREIGN KEY (`p_cat_id`) REFERENCES `product_categories` (`p_cat_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
