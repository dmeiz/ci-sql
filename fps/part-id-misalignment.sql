-- Find part_id alignment status between parts and part_inventories tables
-- Shows all parts and indicates whether they exist in both tables or just one
-- Filtered to only products with recycled colors that have SKUs mapped

WITH products_with_recycled_colors AS (
  SELECT DISTINCT
    fps_skus.product_id,
    fps_skus.provider_name
  FROM
    parts AS parts_inner
    INNER JOIN fulfillment_promo_product_skus AS fps_skus
      ON parts_inner.product_id = fps_skus.product_id
      AND parts_inner.provider_name = fps_skus.provider_name
  WHERE
    parts_inner.color_name LIKE '%RECYCLED%'

  UNION

  SELECT DISTINCT
    fps_skus.product_id,
    fps_skus.provider_name
  FROM
    part_inventories AS part_inv
    INNER JOIN fulfillment_promo_product_skus AS fps_skus
      ON part_inv.product_id = fps_skus.product_id
      AND part_inv.provider_name = fps_skus.provider_name
  WHERE
    part_inv.part_color LIKE '%RECYCLED%'
)

SELECT
    COALESCE(p.provider_name, pi.provider_name) AS provider_name,
    COALESCE(p.product_id, pi.product_id) AS product_id,
    p.part_id AS part_id_from_parts,
    p.color_name AS color_name_from_parts,
    pi.part_id AS part_id_from_inventories,
    pi.part_color AS color_name_from_inventories
FROM parts p
LEFT JOIN part_inventories pi
    ON p.product_id = pi.product_id
    AND p.provider_name = pi.provider_name
    AND p.part_id = pi.part_id
WHERE EXISTS (
    SELECT 1 FROM products_with_recycled_colors pwrc
    WHERE pwrc.product_id = p.product_id
    AND pwrc.provider_name = p.provider_name
  )
  AND pi.part_id IS NULL  -- Only show misalignments
  AND p.provider_name = 'hitpromo'

UNION

SELECT
    COALESCE(p.provider_name, pi.provider_name) AS provider_name,
    COALESCE(p.product_id, pi.product_id) AS product_id,
    p.part_id AS part_id_from_parts,
    p.color_name AS color_name_from_parts,
    pi.part_id AS part_id_from_inventories,
    pi.part_color AS color_name_from_inventories
FROM part_inventories pi
LEFT JOIN parts p
    ON pi.product_id = p.product_id
    AND pi.provider_name = p.provider_name
    AND pi.part_id = p.part_id
WHERE EXISTS (
    SELECT 1 FROM products_with_recycled_colors pwrc
    WHERE pwrc.product_id = pi.product_id
    AND pwrc.provider_name = pi.provider_name
  )
  AND p.part_id IS NULL  -- Only show misalignments
  AND pi.provider_name = 'hitpromo'

ORDER BY provider_name, product_id, part_id_from_parts, part_id_from_inventories;
