

--
-- Table structure for table `brand_followers`
--

DROP TABLE IF EXISTS `brand_followers`;
CREATE TABLE `brand_followers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `brand_id` int NOT NULL,
  `follower_id` int NOT NULL,
  `time_followed` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pk_brandFollowers_connect_brands` (`brand_id`),
  KEY `pk_brandFollowers_connect_users` (`follower_id`),
  CONSTRAINT `brand_followers_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`),
  CONSTRAINT `brand_followers_ibfk_2` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`)
);

--
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
CREATE TABLE `brands` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `short_name` varchar(255) NOT NULL,
  `image_url` text,
  `joined_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
CREATE TABLE `carts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
);

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
);

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
CREATE TABLE `cities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `country_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cities_connect_countries` (`country_id`),
  CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`)
);

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
CREATE TABLE `countries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

--
-- Table structure for table `delivers`
--

DROP TABLE IF EXISTS `delivers`;
CREATE TABLE `delivers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `is_enable` int NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
);

--
-- Table structure for table `favourite_products`
--

DROP TABLE IF EXISTS `favourite_products`;
CREATE TABLE `favourite_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_favouriteProducts_connect_products` (`product_id`),
  KEY `fk_favouriteProducts_connect_users` (`user_id`),
  CONSTRAINT `favourite_products_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `favourite_products_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
);

--
-- Table structure for table `feedback_images`
--

DROP TABLE IF EXISTS `feedback_images`;
CREATE TABLE `feedback_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_feedback_id` int NOT NULL,
  `image_url` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_feedbackImages_connect_productFeedbacks` (`product_feedback_id`),
  CONSTRAINT `feedback_images_ibfk_1` FOREIGN KEY (`product_feedback_id`) REFERENCES `product_feedbacks` (`id`)
);

--
-- Table structure for table `login_histories`
--

DROP TABLE IF EXISTS `login_histories`;
CREATE TABLE `login_histories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `time_login` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_loginHistories_connect_users` (`user_id`),
  CONSTRAINT `login_histories_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
);

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `title` text NOT NULL,
  `description` text,
  `is_seen` int NOT NULL,
  `time_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pk_notifications_connect_users` (`user_id`),
  KEY `pk_notifications_connect_products` (`product_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
);

--
-- Table structure for table `order_status`
--

DROP TABLE IF EXISTS `order_status`;
CREATE TABLE `order_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` text,
  PRIMARY KEY (`id`)
);

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `receiver_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_attributes_info` text,
  `quantity` int NOT NULL,
  `total_price` int NOT NULL,
  `address` text NOT NULL,
  `deliver_id` int NOT NULL,
  `payment_method_id` int NOT NULL,
  `time_order_placed` datetime DEFAULT CURRENT_TIMESTAMP,
  `time_order_confirmed` datetime DEFAULT NULL,
  `time_order_shipped_out` datetime DEFAULT NULL,
  `time_order_received` datetime DEFAULT NULL,
  `time_order_completed` datetime DEFAULT NULL,
  `time_order_cancelled` datetime DEFAULT NULL,
  `order_status_id` int NOT NULL,
  `note` text,
  PRIMARY KEY (`id`),
  KEY `fk_orders_connect_receivers` (`receiver_id`),
  KEY `fk_orders_connect_products` (`product_id`),
  KEY `fk_orders_connect_delivers` (`deliver_id`),
  KEY `fk_orders_connect_paymentMethods` (`payment_method_id`),
  KEY `fk_orders_connect_orderStatus` (`order_status_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`receiver_id`) REFERENCES `receivers` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `orders_ibfk_5` FOREIGN KEY (`deliver_id`) REFERENCES `delivers` (`id`),
  CONSTRAINT `orders_ibfk_6` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`),
  CONSTRAINT `orders_ibfk_7` FOREIGN KEY (`order_status_id`) REFERENCES `order_status` (`id`)
);

--
-- Table structure for table `payment_methods`
--

DROP TABLE IF EXISTS `payment_methods`;
CREATE TABLE `payment_methods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `method_name` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
);

--
-- Table structure for table `product_attributes_and_prices`
--

DROP TABLE IF EXISTS `product_attributes_and_prices`;
CREATE TABLE `product_attributes_and_prices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `attributes` json DEFAULT NULL,
  `price` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_productAttributesAndPrices_connect_products` (`product_id`),
  CONSTRAINT `product_attributes_and_prices_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
);

--
-- Table structure for table `product_feedbacks`
--

DROP TABLE IF EXISTS `product_feedbacks`;
CREATE TABLE `product_feedbacks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `user_id` int NOT NULL,
  `number_star` int NOT NULL,
  `comment` text NOT NULL,
  `time_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_productFeedbacks_connect_products` (`product_id`),
  KEY `fk_productFeedbacks_connect_users` (`user_id`),
  CONSTRAINT `product_feedbacks_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `product_feedbacks_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
);

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
CREATE TABLE `product_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `image_url` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_productImages_connect_products` (`product_id`),
  CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
);

--
-- Table structure for table `product_in_carts`
--

DROP TABLE IF EXISTS `product_in_carts`;
CREATE TABLE `product_in_carts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cart_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_size_id` int NOT NULL,
  `product_color_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_productInCarts_connect_carts` (`cart_id`),
  KEY `fk_productInCarts_connect_products` (`product_id`),
  KEY `fk_productInCarts_connect_productSizes` (`product_size_id`),
  KEY `fk_productInCarts_connect_productColors` (`product_color_id`),
  CONSTRAINT `product_in_carts_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`),
  CONSTRAINT `product_in_carts_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
);

--
-- Table structure for table `product_of_categories`
--

DROP TABLE IF EXISTS `product_of_categories`;
CREATE TABLE `product_of_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `sub_category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_productOfCategories_connect_products` (`product_id`),
  KEY `fk_productOfCategories_connect_subCategories` (`sub_category_id`),
  CONSTRAINT `product_of_categories_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `product_of_categories_ibfk_2` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`)
);

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `image_url` text NOT NULL,
  `price` int NOT NULL,
  `brand_id` int NOT NULL,
  `origin_country_id` int NOT NULL,
  `description` text,
  `is_enable` int NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `fk_products_connect_shops` (`brand_id`),
  KEY `fk_products_connect_countries` (`origin_country_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`),
  CONSTRAINT `products_ibfk_4` FOREIGN KEY (`origin_country_id`) REFERENCES `countries` (`id`)
);

--
-- Table structure for table `receivers`
--

DROP TABLE IF EXISTS `receivers`;
CREATE TABLE `receivers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `is_default_receiver` int NOT NULL,
  `is_enable` int NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `pk_receivers_connect_users` (`user_id`),
  CONSTRAINT `receivers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
);

--
-- Table structure for table `search_histories`
--

DROP TABLE IF EXISTS `search_histories`;
CREATE TABLE `search_histories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `content` text NOT NULL,
  `time_searched` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_searchHistories_connect_users` (`user_id`),
  CONSTRAINT `search_histories_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
);

--
-- Table structure for table `sub_categories`
--

DROP TABLE IF EXISTS `sub_categories`;
CREATE TABLE `sub_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `parent_category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_subCategories_connect_categories` (`parent_category_id`),
  CONSTRAINT `sub_categories_ibfk_1` FOREIGN KEY (`parent_category_id`) REFERENCES `categories` (`id`)
);

--
-- Table structure for table `user_followers`
--

DROP TABLE IF EXISTS `user_followers`;
CREATE TABLE `user_followers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `follower_id` int NOT NULL,
  `time_followed` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pk_userFollowers_connect_users` (`user_id`),
  KEY `pk_userFollowers_connect_users2` (`follower_id`),
  CONSTRAINT `user_followers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_followers_ibfk_2` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`)
);

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `account_created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `gender` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) NOT NULL,
  `country_id` int NOT NULL,
  `city_id` int NOT NULL,
  `address_details` text,
  `is_enable` int NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `fk_users_connect_countries` (`country_id`),
  KEY `fk_users_connect_cities` (`city_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`),
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`)
);

-- Dump completed on 2023-08-07 13:45:56
