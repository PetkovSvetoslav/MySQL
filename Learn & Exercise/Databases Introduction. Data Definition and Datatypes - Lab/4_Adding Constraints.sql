USE gamebar;

ALTER TABLE products
ADD CONSTRAINT `fk_categories_id_products_category_id`
FOREIGN KEY `products` (`category_id`) REFERENCES `categories`(`id`);