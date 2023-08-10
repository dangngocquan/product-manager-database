-- CREATE TABLES 

-- Create table `accounts`
create table `accounts` (
    `id` bigint unsigned not null auto_increment primary key,
    `username` varchar(255) not null,
    `password` varchar(255) not null,
    `status` enum("normal", "banned", "deleted") not null default "normal",
    `type` enum("user", "admin") not null default "user",
    `time_registered` datetime not null default current_timestamp
);

-- Create table `clients`
create table `clients` (
    `id` bigint unsigned not null auto_increment primary key,
    `account_id` bigint unsigned not null,
    `nickname` varchar(255) not null,
    `email` varchar(255),
    `phone_number` varchar(255),
    `gender` enum("male", "female", "other"),
    `birthday` datetime not null default current_timestamp,
    `portrait` text
);

-- Create table `cities`
create table `cities` (
    `id` bigint unsigned not null auto_increment primary key,
    `name` varchar(255) not null,
    `status` enum("normal", "deleted") not null default "normal"
);

-- Create table `districts`
create table `districts` (
    `id` bigint unsigned not null auto_increment primary key,
    `name` varchar(255) not null,
    `city_id` bigint unsigned not null,
    `status` enum("normal", "deleted") not null default "normal"
);

-- Create table `wards`
create table `wards` (
    `id` bigint unsigned not null auto_increment primary key,
    `name` varchar(255) not null,
    `district_id` bigint unsigned not null,
    `status` enum("normal", "deleted") not null default "normal"
);

-- Create table `addresses`
create table `addresses` (
    `id` bigint unsigned not null auto_increment primary key,
    `user_id` bigint unsigned not null,
    `phone_number` varchar(255) not null,
    `ward_id` bigint unsigned not null,
    `district_id` bigint unsigned not null,
    `city_id` bigint unsigned not null,
    `address` text,
    `is_deliver_address` enum("0", "1") not null,
    `time_created` datetime not null default current_timestamp,
    `status` enum("normal", "deleted") not null default "normal"
);

-- Create table `history_logins`
create table `history_logins` (
    `id` bigint unsigned not null auto_increment primary key,
    `account_id` bigint unsigned not null,
    `time` datetime not null default current_timestamp
);

-- Create table `user_notifications`
create table `user_notifications` (
    `id` bigint unsigned not null auto_increment primary key,
    `user_id` bigint unsigned not null,
    `title` varchar(255) not null,
    `description` text,
    `details_info` json not null,
    `time_created` datetime not null default current_timestamp,
    `is_seen` enum("0", "1") not null default "0"
);

-- Create table `history_searchs`
create table `history_searchs` (
    `id` bigint unsigned not null auto_increment primary key,
    `user_id` bigint unsigned not null,
    `content` varchar(255) not null,
    `time_searched` datetime not null default current_timestamp
);

-- Create table `shops`
create table `shops` (
    `id` bigint unsigned not null auto_increment primary key,
    `owner_id` bigint unsigned not null,
    `username` varchar(255) not null,
    `brand_name` varchar(255) not null,
    `time_created` datetime not null default current_timestamp,
    `logo` text,
    `status` enum("normal", "banned", "deleted") not null default "normal"
);

-- Create table `carts`
create table `carts` (
    `id` bigint unsigned not null auto_increment primary key,
    `owner_id` bigint unsigned not null,
    `time_created` datetime not null default current_timestamp
);

-- Create table `followers_of_users`
create table `followers_of_users` (
    `id` bigint unsigned not null auto_increment primary key,
    `user_id` bigint unsigned not null,
    `follower_id` bigint unsigned not null,
    `time_followed` datetime not null default current_timestamp
);

-- Create table `followers_of_shops`
create table `followers_of_shops` (
    `id` bigint unsigned not null auto_increment primary key,
    `shop_id` bigint unsigned not null,
    `follower_id` bigint unsigned not null,
    `time_followed` datetime not null default current_timestamp
);

-- Create table `shop_notifications`
create table `shop_notifications` (
    `id` bigint unsigned not null auto_increment primary key,
    `shop_id` bigint unsigned not null,
    `title` varchar(255) not null,
    `description` varchar(255),
    `details_info` json not null,
    `time_created` datetime not null default current_timestamp,
    `is_seen` enum("0", "1") not null default "0"
);

-- Create table `products`
create table `products` (
    `id` bigint unsigned not null auto_increment primary key,
    `shop_id` bigint unsigned not null,
    `name` varchar(255) not null,
    `image` text,
    `price` bigint unsigned not null,
    `currency` varchar(255) not null default "VND",
    `stock` bigint unsigned not null,
    `time_added` timestamp not null default current_timestamp,
    `description` text,
    `status` enum("normal", "deleted") not null default "normal"
);

-- Create table `favourite_products`
create table `favourite_products` (
    `id` bigint unsigned not null auto_increment primary key,
    `product_id` bigint unsigned not null,
    `user_id` bigint unsigned not null,
    `time_liked` timestamp not null default current_timestamp
);

-- Create table `products_of_carts`
create table `products_of_carts` (
    `id` bigint unsigned not null auto_increment primary key,
    `product_id` bigint unsigned not null,
    `cart_id` bigint unsigned not null,
    `time_added` timestamp not null default current_timestamp
);

-- Create table `categories`
create table `categories` (
    `id` bigint unsigned not null auto_increment primary key,
    `name` varchar(255) not null,
    `image` text,
    `level` int not null,
    `parent_category_id` bigint unsigned not null,
    `time_added` timestamp not null default current_timestamp,
    `status` enum("normal", "hidden", "deleted") not null default "normal"
);

-- Create table `products_of_categories`
create table `products_of_categories` (
    `id` bigint unsigned not null auto_increment primary key,
    `category_id` bigint unsigned not null,
    `product_id` bigint unsigned not null
);

-- Create table `product_images`
create table `product_images` (
    `id` bigint unsigned not null auto_increment primary key,
    `product_id` bigint unsigned not null,
    `image` text not null,
    `time_added` datetime not null default current_timestamp
);

-- Create table `product_variations`
create table `product_variations` (
    `id` bigint unsigned not null auto_increment primary key,
    `product_id` bigint unsigned not null,
    `attributes` json not null,
    `price` bigint unsigned not null,
    `status` enum("normal", "deleted") not null default "normal"
);

-- Create table `orders`
create table `orders` (
    `id` bigint unsigned not null auto_increment primary key,
    `product_variation_id` bigint unsigned not null,
    `receiver_id` bigint unsigned not null,
    `delivery_center_id` bigint unsigned not null,
    `process_id` bigint unsigned not null,
    `payment_info_id` bigint unsigned not null,
    `status` enum("cancelled", "ordered", "prepared", "completed") not null default "ordered"
);

-- Create table `delivery_centers`
create table `delivery_centers` (
    `id` bigint unsigned not null auto_increment primary key,
    `name` varchar(255) not null,
    `fee` bigint unsigned not null,
    `status` enum("normal", "unable", "deleted") not null default "normal"
);

-- Create table `order_payments_info`
create table `order_payments_info` (
    `id` bigint unsigned not null auto_increment primary key,
    `product_price` bigint unsigned not null,
    `quantity` bigint unsigned not null,
    `deliver_fee` bigint unsigned not null,
    `payment_method_id` bigint unsigned not null
);

-- Create table `payment_methods`
create table `payment_methods` (
    `id` bigint unsigned not null auto_increment primary key,
    `name` varchar(255) not null,
    `status` enum("normal", "unable", "deleted") not null default "normal"
);

-- Create table `order_processes`
create table `order_processes` (
    `id` bigint unsigned not null auto_increment primary key,
    `time_ordered` timestamp,
    `time_prepared` timestamp,
    `time_completed` timestamp,
    `time_cancelled` timestamp
);

