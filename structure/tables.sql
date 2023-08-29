-- CREATE TABLES 

-- Create type enum
CREATE TYPE enum_status_1 AS enum('normal', 'banned', 'deleted');
CREATE TYPE enum_status_2 AS enum('normal', 'deleted');
CREATE TYPE enum_status_3 AS enum('normal', 'unable', 'deleted');
CREATE TYPE enum_status_4 AS enum('normal', 'hidden', 'deleted');
CREATE TYPE enum_status_5 AS enum('cancelled', 'ordered', 'prepared', 'completed');
CREATE TYPE enum_types_1 AS enum('user', 'admin');
CREATE TYPE enum_gender_1 AS enum('male', 'female', 'other');
CREATE TYPE enum_0_1 AS enum('0', '1');

-- CREATE TABLES 

-- Create table "accounts"
create table "accounts" (
    "id" bigserial not null primary key,
    "username" varchar(255) not null,
    "password" varchar(255) not null,
    "status" enum_status_1 not null default 'normal',
    "type" enum_types_1 not null default 'user',
    "time_registered" timestamp not null default current_timestamp
);

-- Create table "clients"
create table "clients" (
    "id" bigserial not null primary key,
    "account_id" bigint not null,
    "nickname" varchar(255) not null,
    "email" varchar(255),
    "phone_number" varchar(255),
    "gender" enum_gender_1 default 'other',
    "birthday" timestamp not null default current_timestamp,
    "portrait" text default 'default-portrait.jpg'
);

-- Create table "cities"
create table "cities" (
    "id" bigserial not null primary key,
    "name" varchar(255) not null,
    "status" enum_status_2 not null default 'normal'
);

-- Create table "districts"
create table "districts" (
    "id" bigserial not null primary key,
    "name" varchar(255) not null,
    "city_id" bigint not null,
    "status" enum_status_2 not null default 'normal'
);

-- Create table "wards"
create table "wards" (
    "id" bigserial not null primary key,
    "name" varchar(255) not null,
    "district_id" bigint not null,
    "status" enum_status_2 not null default 'normal'
);

-- Create table "addresses"
create table "addresses" (
    "id" bigserial not null primary key,
    "user_id" bigint not null,
    "phone_number" varchar(255) not null,
    "ward_id" bigint not null,
    "district_id" bigint not null,
    "city_id" bigint not null,
    "address" text,
    "is_deliver_address" enum_0_1 not null,
    "time_created" timestamp not null default current_timestamp,
    "status" enum_status_2 not null default 'normal'
);

-- Create table "history_logins"
create table "history_logins" (
    "id" bigserial not null primary key,
    "account_id" bigint not null,
    "time" timestamp not null default current_timestamp
);

-- Create table "user_notifications"
create table "user_notifications" (
    "id" bigserial not null primary key,
    "user_id" bigint not null,
    "title" varchar(255) not null,
    "description" text,
    "details_info" json not null,
    "time_created" timestamp not null default current_timestamp,
    "is_seen" enum_0_1 not null default '0'
);

-- Create table "history_searchs"
create table "history_searchs" (
    "id" bigserial not null primary key,
    "user_id" bigint not null,
    "content" varchar(255) not null,
    "time_searched" timestamp not null default current_timestamp
);

-- Create table "shops"
create table "shops" (
    "id" bigserial not null primary key,
    "owner_id" bigint not null,
    "username" varchar(255) not null,
    "brand_name" varchar(255) not null,
    "time_created" timestamp not null default current_timestamp,
    "logo" text,
    "status" enum_status_1 not null default 'normal'
);

-- Create table "carts"
create table "carts" (
    "id" bigserial not null primary key,
    "owner_id" bigint not null,
    "time_created" timestamp not null default current_timestamp
);

-- Create table "followers_of_users"
create table "followers_of_users" (
    "id" bigserial not null primary key,
    "user_id" bigint not null,
    "follower_id" bigint not null,
    "time_followed" timestamp not null default current_timestamp
);

-- Create table "followers_of_shops"
create table "followers_of_shops" (
    "id" bigserial not null primary key,
    "shop_id" bigint not null,
    "follower_id" bigint not null,
    "time_followed" timestamp not null default current_timestamp
);

-- Create table "shop_notifications"
create table "shop_notifications" (
    "id" bigserial not null primary key,
    "shop_id" bigint not null,
    "title" varchar(255) not null,
    "description" varchar(255),
    "details_info" json not null,
    "time_created" timestamp not null default current_timestamp,
    "is_seen" enum_0_1 not null default '0'
);

-- Create table "products"
create table "products" (
    "id" bigserial not null primary key,
    "shop_id" bigint not null,
    "name" varchar(255) not null,
    "image" text,
    "price" bigint not null,
    "currency" varchar(255) not null default 'VND',
    "stock" bigint not null,
    "time_added" timestamp not null default current_timestamp,
    "description" text,
    "status" enum_status_2 not null default 'normal'
);

-- Create table "favourite_products"
create table "favourite_products" (
    "id" bigserial not null primary key,
    "product_id" bigint not null,
    "user_id" bigint not null,
    "time_liked" timestamp not null default current_timestamp
);

-- Create table "products_of_carts"
create table "products_of_carts" (
    "id" bigserial not null primary key,
    "product_id" bigint not null,
    "cart_id" bigint not null,
    "time_added" timestamp not null default current_timestamp
);

-- Create table "categories"
create table "categories" (
    "id" bigserial not null primary key,
    "name" varchar(255) not null,
    "image" text,
    "level" int not null,
    "parent_category_id" bigint not null,
    "time_added" timestamp not null default current_timestamp,
    "status" enum_status_4 not null default 'normal'
);

-- Create table "products_of_categories"
create table "products_of_categories" (
    "id" bigserial not null primary key,
    "category_id" bigint not null,
    "product_id" bigint not null
);

-- Create table "product_images"
create table "product_images" (
    "id" bigserial not null primary key,
    "product_id" bigint not null,
    "image" text not null,
    "time_added" timestamp not null default current_timestamp
);

-- Create table "product_variations"
create table "product_variations" (
    "id" bigserial not null primary key,
    "product_id" bigint not null,
    "attributes" json not null,
    "price" bigint not null,
    "status" enum_status_2 not null default 'normal'
);

-- Create table "orders"
create table "orders" (
    "id" bigserial not null primary key,
    "product_variation_id" bigint not null,
    "receiver_id" bigint not null,
    "delivery_center_id" bigint not null,
    "process_id" bigint not null,
    "payment_info_id" bigint not null,
    "status" enum_status_5 not null default 'ordered'
);

-- Create table "delivery_centers"
create table "delivery_centers" (
    "id" bigserial not null primary key,
    "name" varchar(255) not null,
    "fee" bigint not null,
    "status" enum_status_3 not null default 'normal'
);

-- Create table "order_payments_info"
create table "order_payments_info" (
    "id" bigserial not null primary key,
    "product_price" bigint not null,
    "quantity" bigint not null,
    "deliver_fee" bigint not null,
    "payment_method_id" bigint not null
);

-- Create table "payment_methods"
create table "payment_methods" (
    "id" bigserial not null primary key,
    "name" varchar(255) not null,
    "status" enum_status_3 not null default 'normal'
);

-- Create table "order_processes"
create table "order_processes" (
    "id" bigserial not null primary key,
    "time_ordered" timestamp,
    "time_prepared" timestamp,
    "time_completed" timestamp,
    "time_cancelled" timestamp
);

-- Create table "sliders"
create table "sliders" (
    "id" bigserial not null primary key,
    "image" text not null
);