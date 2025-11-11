-- Find sizes that have inventory status mismatches between MMS and FPS
-- Case 1: Inactive in MMS but has enough inventory in FPS
-- Case 2: Active in MMS but doesn't have enough inventory in FPS
SELECT
  fps_skus.provider_name,
  mms_skus.style_id,
  mms_skus.color_id,
  mms_sizes.name AS size_name,
  mms_sizes.status AS size_status,
  mms_sizes.oos_threshold,
  mms_sizes.last_known_supplier_quantity,
  fps_inventory.quantity_available AS fps_quantity_available,
  fps_skus.part_id,
  CASE
    WHEN mms_sizes.status = 'inactive' AND fps_inventory.quantity_available > mms_sizes.oos_threshold THEN 'Inactive but has inventory'
    WHEN mms_sizes.status = 'active' AND (fps_inventory.quantity_available IS NULL OR fps_inventory.quantity_available <= mms_sizes.oos_threshold) THEN 'Active but no inventory'
    ELSE 'Other'
  END AS mismatch_type
FROM
  rawdata.mms_sizes AS mms_sizes
  INNER JOIN rawdata.mms_skus AS mms_skus
    ON mms_sizes.name = mms_skus.size_id
    AND mms_sizes.color_id = mms_skus.color_id
  INNER JOIN rawdata.fulfillment_products_service_fulfillment_promo_product_skus AS fps_skus
    ON mms_skus.id = fps_skus.mms_sku
  INNER JOIN rawdata.fulfillment_products_service_part_inventories AS fps_inventory
    ON fps_skus.product_id = fps_inventory.product_id
    AND fps_skus.provider_name = fps_inventory.provider_name
    AND fps_skus.part_id = fps_inventory.part_id
  INNER JOIN rawdata.mms_colors AS mms_colors
    ON mms_skus.color_id = mms_colors.id
  INNER JOIN rawdata.mms_styles AS mms_styles
    ON mms_skus.style_id = mms_styles.id
WHERE
  (
    -- Case 1: Size is marked inactive in MMS but FPS shows inventory available above the threshold
    (mms_sizes.status = 'inactive'
     AND fps_inventory.quantity_available IS NOT NULL
     AND fps_inventory.quantity_available > mms_sizes.oos_threshold)
    OR
    -- Case 2: Size is marked active in MMS but FPS shows inventory at or below the threshold (or null)
    (mms_sizes.status = 'active'
     AND (fps_inventory.quantity_available IS NULL
          OR fps_inventory.quantity_available <= mms_sizes.oos_threshold))
  )
ORDER BY
  mismatch_type,
  mms_styles.mill_no,
  mms_colors.mill_no,
  mms_sizes.name
LIMIT 1048575
