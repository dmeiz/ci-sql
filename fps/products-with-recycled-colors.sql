SELECT DISTINCT
  fps_skus.product_id,
  fps_skus.provider_name
FROM
  rawdata.fulfillment_products_service_parts AS parts
  INNER JOIN rawdata.fulfillment_products_service_fulfillment_promo_product_skus AS fps_skus
    ON parts.product_id = fps_skus.product_id
    AND parts.provider_name = fps_skus.provider_name
WHERE
  parts.color_name LIKE '%RECYCLED%'

UNION

SELECT DISTINCT
  fps_skus.product_id,
  fps_skus.provider_name
FROM
  rawdata.fulfillment_products_service_part_inventories AS part_inv
  INNER JOIN rawdata.fulfillment_products_service_fulfillment_promo_product_skus AS fps_skus
    ON part_inv.product_id = fps_skus.product_id
    AND part_inv.provider_name = fps_skus.provider_name
WHERE
  part_inv.part_color LIKE '%RECYCLED%'

