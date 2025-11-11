This repository stores database schemas for two databases:

* @mms-schema.rb
* @fps-schema.rb

These databases are available in our datawarehouse where we can do cross-database queries. The tables names are prefixed with the database name. Here's an example of a cross-database query:

```
SELECT
  "mms_skus"."id" AS "mms_sku",
  "mms_skus"."style_id" AS "style_id",
  "mms_skus"."color_id" AS "color_id",
  "mms_skus"."size_id" AS "size_id",
  "mms_skus"."status" AS "status",
  "fps_skus"."part_id" AS "part_id",
  "mms_colors"."mill_no" AS "color_mill_no",
  "mms_colors"."name" AS "color_name"
FROM
  "rawdata"."mms_skus" AS "mms_skus"
  INNER JOIN "rawdata"."fulfillment_products_service_fulfillment_promo_product_skus" AS "fps_skus" ON "mms_skus"."id" = "fps_skus"."mms_sku"
  INNER JOIN "rawdata"."mms_colors" AS "mms_colors" ON "mms_skus"."color_id" = "mms_colors"."id"
WHERE
  size_id = 'One Size' AND part_id NOT LIKE CONCAT('%', CONCAT(color_mill_no, '%'))
  and fps_skus.provider_name <> 'customink'
  AND color_id <> 1176700
LIMIT
  1048575
```

Double-quotes are not required (they just happen to be in this example).

Notice tables are referenced with `rawdata`. This is a requirement of the datawarehouse.

Notice tables are prefixed with the database name: `fulfillment_products_service_fulfillment_promo_product_skus` is a combination of `fulfillment_products_service` and `fulfillment_promo_product_skus`

`fps` is short for `fulfillment_products_service`.
