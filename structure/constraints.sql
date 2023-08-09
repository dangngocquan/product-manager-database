-- ADD CONSTRAINT FOR TABLES

-- Add constraint for table `users`
alter table `users` add constraint `fk_users_accounts` foreign key (`account_id`) references `accounts`(`id`);

-- Add constraint for table `history_logins`
alter table `history_logins` add constraint `fk_historyLogins_accounts` foreign key (`account_id`) references `accounts`(`id`);

-- Add constraint for table `districts`
alter table `districts` add constraint `fk_districts_cities` foreign key (`city_id`) references `cities`(`id`);

-- Add constraint for table `wards`
alter table `wards` add constraint `fk_wards_districts` foreign key (`district_id`) references `districts`(`id`);

-- Add constraint for table `addresses`
alter table `addresses` add constraint `fk_addresses_users` foreign key (`user_id`) references `users`(`id`);
alter table `addresses` add constraint `fk_addresses_cities` foreign key (`city_id`) references `cities`(`id`);
alter table `addresses` add constraint `fk_addresses_districts` foreign key (`district_id`) references `districts`(`id`);
alter table `addresses` add constraint `fk_addresses_wards` foreign key (`ward_id`) references `wards`(`id`);

-- Add constraints for table `user_notifications`
alter table `user_notifications` add constraint `fk_userNotifications_users` foreign key (`user_id`) references `users`(`id`);

-- Add constraints for table `history_searchs`
alter table `history_searchs` add constraint `fk_historySearchs_users` foreign key (`user_id`) references `users`(`id`);

-- Add constraints for table `shops`
alter table `shops` add constraint `fk_shops_users` foreign key (`owner_id`) references `users`(`id`);

-- Add constraints for table `favourite_products`
alter table `favourite_products` add constraint `fk_favouriteProducts_users` foreign key (`user_id`) references `users`(`id`);
alter table `favourite_products` add constraint `fk_favouriteProducts_products` foreign key (`product_id`) references `products`(`id`);

-- Add constraints for table `carts`
alter table `carts` add constraint `fk_carts_users` foreign key (`owner_id`) references `users`(`id`);

-- Add constraints for table `followers_of_users`
alter table `followers_of_users` add constraint `fk_followersOfUsers_users1` foreign key (`user_id`) references `users`(`id`);
alter table `followers_of_users` add constraint `fk_followersOfUsers_users2` foreign key (`follower_id`) references `users`(`id`);

-- Add constraint for table `products_of_carts`
alter table `products_of_carts` add constraint `fk_productsOfCarts_carts` foreign key (`cart_id`) references `carts`(`id`);

-- Add constraint for table `products`
alter table `products` add constraint `fk_products_shops` foreign key (`shop_id`) references `shops`(`id`);

-- Add constraint for table `shop_notifications`
alter table `shop_notifications` add constraint `fk_shopNotifications_shops` foreign key (`shop_id`) references `shops`(`id`);

-- Add constraint for table `followers_of_shops`
alter table `followers_of_shops` add constraint `fk_folowersOfShops_shops` foreign key (`shop_id`) references `shops`(`id`);
alter table `followers_of_shops` add constraint `fk_folowersOfShops_users` foreign key (`follower_id`) references `users`(`id`);

-- Add constraint for table `orders`
alter table `orders` add constraint `fk_orders_addresses` foreign key (`receiver_id`) references `addresses`(`id`);
alter table `orders` add constraint `fk_orders_productVariations` foreign key (`product_variation_id`) references `product_variations` (`id`);
alter table `orders` add constraint `fk_orders_deliveryCenters` foreign key (`delivery_center_id`) references `delivery_centers` (`id`);
alter table `orders` add constraint `fk_orders_orderProcesses` foreign key (`process_id`) references `order_processes`(`id`);
alter table `orders` add constraint `fk_orders_orderPaymentsInfo` foreign key (`payment_info_id`) references `order_payments_info` (`id`);

-- Add constraints for table `order_payments_info`
alter table `order_payments_info` add constraint `fk_orderPaymentsInfo_paymentMethods` foreign key (`payment_method_id`) references `payment_methods`(`id`);

-- Add constraints for table `category_relations`
alter table `category_relations` add constraint `fk_categoryRelations_categories1` foreign key (`parent_category_id`) references `categories`(`id`);
alter table `category_relations` add constraint `fk_categoryRelations_categories2` foreign key (`child_category_id`) references `categories`(`id`);