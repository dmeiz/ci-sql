-- Find unmapped skus (excluding assembly products)
-- Assembly products are identified as having multiple part_groups in product_configuration_parts
WITH assembly_products AS (
  SELECT DISTINCT
    product_id,
    provider_name
  FROM
    rawdata.fulfillment_products_service_product_configuration_parts
  GROUP BY
    product_id,
    provider_name
  HAVING
    COUNT(DISTINCT part_group) > 1
),
styles_mapped_to_assemblies AS (
  SELECT DISTINCT
    fps_skus.mms_sku
  FROM
    rawdata.fulfillment_products_service_fulfillment_promo_product_skus AS fps_skus
    INNER JOIN assembly_products
      ON fps_skus.product_id = assembly_products.product_id
      AND fps_skus.provider_name = assembly_products.provider_name
)
SELECT
  mms_skus.id AS mms_sku_id,
  mms_skus.style_id,
  mms_skus.color_id,
  mms_styles.manufacturer,
  mms_styles.mill_no AS style_mill_no,
  mms_styles.name AS style_name,
  mms_colors.name AS color_name,
  mms_colors.status AS color_status
FROM
  rawdata.mms_skus AS mms_skus
  INNER JOIN rawdata.mms_styles AS mms_styles
    ON mms_skus.style_id = mms_styles.id
  INNER JOIN rawdata.mms_colors AS mms_colors
    ON mms_skus.color_id = mms_colors.id
  LEFT JOIN rawdata.fulfillment_products_service_fulfillment_promo_product_skus AS fps_skus
    ON mms_skus.id = fps_skus.mms_sku
  LEFT JOIN styles_mapped_to_assemblies
    ON mms_skus.id = styles_mapped_to_assemblies.mms_sku
WHERE
  mms_styles.manufacturer IN ('Bullet', 'Trimark', 'Leeds', 'Koozie Group', 'Bic', 'Norwood', 'Vitronic', 'Hit', 'Gemline', 'Snugz', 'Primeline')
  AND fps_skus.id IS NULL
  AND styles_mapped_to_assemblies.mms_sku IS NULL
  AND mms_styles.status IN ('active')
  AND mms_colors.status = 'active'
ORDER BY
  mms_styles.name,
  mms_colors.name,
  mms_skus.size_id

