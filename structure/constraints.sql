-- ADD CONSTRAINT FOR TABLES

-- Add constraint for table "clients"
alter table "clients" add constraint "fk_clients_accounts" foreign key ("account_id") references "accounts"("id");

-- Add constraint for table "history_logins"
alter table "history_logins" add constraint "fk_historyLogins_accounts" foreign key ("account_id") references "accounts"("id");

-- Add constraint for table "districts"
alter table "districts" add constraint "fk_districts_cities" foreign key ("city_id") references "cities"("id");

-- Add constraint for table "wards"
alter table "wards" add constraint "fk_wards_districts" foreign key ("district_id") references "districts"("id");

-- Add constraint for table "addresses"
alter table "addresses" add constraint "fk_addresses_clients" foreign key ("user_id") references "clients"("id");
alter table "addresses" add constraint "fk_addresses_cities" foreign key ("city_id") references "cities"("id");
alter table "addresses" add constraint "fk_addresses_districts" foreign key ("district_id") references "districts"("id");
alter table "addresses" add constraint "fk_addresses_wards" foreign key ("ward_id") references "wards"("id");

-- Add constraints for table "user_notifications"
alter table "user_notifications" add constraint "fk_userNotifications_clients" foreign key ("user_id") references "clients"("id");

-- Add constraints for table "history_searchs"
alter table "history_searchs" add constraint "fk_historySearchs_clients" foreign key ("user_id") references "clients"("id");

-- Add constraints for table "shops"
alter table "shops" add constraint "fk_shops_accounts" foreign key ("owner_id") references "accounts"("id");

-- Add constraints for table "favourite_products"
alter table "favourite_products" add constraint "fk_favouriteProducts_clients" foreign key ("user_id") references "clients"("id");
alter table "favourite_products" add constraint "fk_favouriteProducts_products" foreign key ("product_id") references "products"("id");

-- Add constraints for table "carts"
alter table "carts" add constraint "fk_carts_clients" foreign key ("owner_id") references "clients"("id");

-- Add constraints for table "followers_of_users"
alter table "followers_of_users" add constraint "fk_followersOfUsers_clients1" foreign key ("user_id") references "clients"("id");
alter table "followers_of_users" add constraint "fk_followersOfUsers_clients2" foreign key ("follower_id") references "clients"("id");

-- Add constraint for table "products_of_carts"
alter table "products_of_carts" add constraint "fk_productsOfCarts_carts" foreign key ("cart_id") references "carts"("id");

-- Add constraint for table "products"
alter table "products" add constraint "fk_products_shops" foreign key ("shop_id") references "shops"("id");

-- Add constraint for table "product_variants"
alter table "product_variants" add constraint "fk_producVariants_products" foreign key ("product_id") references "products"("id");

-- Add constraint for table "variant_values"
alter table "variant_values" add constraint "fk_variantValues_variants" foreign key ("variant_id") references "variants"("id");
alter table "variant_values" add constraint "variants_variant_id_value_unique" unique("variant_id", "value")

-- Add constraint for table "variants"
alter table "variants" add constraint "variants_variant_name_unique" unique("variant_name")

-- Add constraint for table "product_variant_details"
alter table "product_variant_details" add constraint "fk_productVariantDetails_productVariants" foreign key ("product_variant_id") references "product_variants"("id");

-- Add constraint for table "product_images"
alter table "product_images" add constraint "fk_producImages_products" foreign key ("product_id") references "products"("id");

-- Add constraint for table "shop_notifications"
alter table "shop_notifications" add constraint "fk_shopNotifications_shops" foreign key ("shop_id") references "shops"("id");

-- Add constraint for table "followers_of_shops"
alter table "followers_of_shops" add constraint "fk_folowersOfShops_shops" foreign key ("shop_id") references "shops"("id");
alter table "followers_of_shops" add constraint "fk_folowersOfShops_clients" foreign key ("follower_id") references "clients"("id");

-- Add constraint for table "orders"
alter table "orders" add constraint "fk_orders_addresses" foreign key ("receiver_id") references "addresses"("id");
alter table "orders" add constraint "fk_orders_productVariants" foreign key ("product_variation_id") references "product_variants" ("id");
alter table "orders" add constraint "fk_orders_deliveryCenters" foreign key ("delivery_center_id") references "delivery_centers" ("id");
alter table "orders" add constraint "fk_orders_orderProcesses" foreign key ("process_id") references "order_processes"("id");
alter table "orders" add constraint "fk_orders_orderPaymentsInfo" foreign key ("payment_info_id") references "order_payments_info" ("id");

-- Add constraints for table "order_payments_info"
alter table "order_payments_info" add constraint "fk_orderPaymentsInfo_paymentMethods" foreign key ("payment_method_id") references "payment_methods"("id");