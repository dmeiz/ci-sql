# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2025_11_01_191344) do

  create_table "anchor_complement_groups", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_anchor_complement_groups_on_name", unique: true
  end

  create_table "anchor_complements", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "anchor_style_id", null: false
    t.integer "complementary_style_id", null: false
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "anchor_complement_group_id", null: false
    t.index ["anchor_complement_group_id"], name: "index_anchor_complements_on_anchor_complement_group_id"
    t.index ["anchor_style_id", "anchor_complement_group_id", "complementary_style_id"], name: "index_anchor_complements_on_anchor_group_and_complement", unique: true
    t.index ["anchor_style_id"], name: "index_anchor_complements_on_anchor_style_id"
    t.index ["complementary_style_id"], name: "index_anchor_complements_on_complementary_style_id"
  end

  create_table "awsdms_apply_exceptions", id: false, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "TASK_NAME", limit: 128, null: false
    t.string "TABLE_OWNER", limit: 128, null: false
    t.string "TABLE_NAME", limit: 128, null: false
    t.datetime "ERROR_TIME", precision: 3, null: false
    t.text "STATEMENT", size: :long, null: false
    t.text "ERROR", size: :long, null: false
  end

  create_table "bulk_style_updates", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "status", default: "in-progress"
    t.text "csv_data"
    t.integer "total_styles"
    t.json "result"
    t.datetime "finished_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bulk_upload_files", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "path"
    t.integer "bulk_upload_id"
    t.text "last_error"
    t.string "status", default: "in-progress"
    t.datetime "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bulk_upload_id"], name: "index_bulk_upload_files_on_bulk_upload_id"
    t.index ["status"], name: "index_bulk_upload_files_on_status"
  end

  create_table "bulk_uploads", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "created_by"
    t.datetime "finished_at"
    t.string "status", default: "in-progress"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by"], name: "index_bulk_uploads_on_created_by"
    t.index ["status"], name: "index_bulk_uploads_on_status"
  end

  create_table "categories", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "parent_id"
    t.boolean "active"
    t.boolean "exclude_from_view_all"
    t.string "image_filename"
    t.string "image_md5"
    t.string "name"
    t.boolean "no_index"
    t.integer "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "lock_version"
    t.string "reporting_name", limit: 40
    t.boolean "order_styles_by_priority", default: true
    t.integer "default_quote_qty"
    t.index ["active"], name: "index_categories_on_active"
    t.index ["exclude_from_view_all"], name: "index_categories_on_exclude_from_view_all"
    t.index ["image_filename"], name: "index_categories_on_image_filename"
    t.index ["image_md5"], name: "index_categories_on_image_md5"
    t.index ["name"], name: "index_categories_on_name"
    t.index ["parent_id"], name: "index_categories_on_parent_id"
  end

  create_table "category_filter_groups", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "filter_group_id", null: false
    t.boolean "active", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "priority", default: 9999
    t.string "active_filter_tags"
    t.index ["category_id", "filter_group_id"], name: "index_category_filter_groups_on_category_id_and_filter_group_id", unique: true
    t.index ["category_id"], name: "index_category_filter_groups_on_category_id"
    t.index ["filter_group_id"], name: "index_category_filter_groups_on_filter_group_id"
  end

  create_table "colors", id: :integer, default: 0, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "style_id"
    t.integer "pricing_group_id"
    t.integer "alternative_id"
    t.boolean "abo_enabled"
    t.string "branding_method"
    t.string "mill_no"
    t.string "name"
    t.text "notes", size: :medium
    t.integer "priority"
    t.float "realb"
    t.boolean "singles_enabled", default: false, null: false
    t.float "singles_price"
    t.string "status", default: "inactive"
    t.text "suppliers", size: :medium
    t.boolean "alternative_id_leading_zero"
    t.boolean "id_leading_zero"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "lock_version"
    t.datetime "deployed_at"
    t.string "deploy_type"
    t.datetime "retired_at"
    t.boolean "low_temp", default: false, null: false
    t.boolean "underbase", default: false, null: false
    t.boolean "dtg_enabled", default: false, null: false
    t.boolean "inventory_enabled", default: false, null: false
    t.index ["abo_enabled"], name: "index_colors_on_abo_enabled"
    t.index ["alternative_id"], name: "index_colors_on_alternative_id"
    t.index ["alternative_id_leading_zero"], name: "index_colors_on_alternative_id_leading_zero"
    t.index ["mill_no"], name: "index_colors_on_mill_no"
    t.index ["name"], name: "index_colors_on_name"
    t.index ["pricing_group_id"], name: "index_colors_on_pricing_group_id"
    t.index ["priority"], name: "index_colors_on_priority"
    t.index ["singles_enabled"], name: "index_colors_on_singles_enabled"
    t.index ["status"], name: "index_colors_on_status"
    t.index ["style_id"], name: "index_colors_on_style_id"
  end

  create_table "constraints", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "view_id"
    t.integer "bottom", default: 0
    t.float "height"
    t.integer "left", default: 0
    t.integer "right", default: 0
    t.integer "top", default: 0
    t.float "width"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["height"], name: "index_constraints_on_height"
    t.index ["view_id"], name: "index_constraints_on_view_id", unique: true
    t.index ["width"], name: "index_constraints_on_width"
  end

  create_table "decorator_metadata", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "style_id"
    t.string "name"
    t.boolean "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_decorator_metadata_on_name"
    t.index ["style_id"], name: "index_decorator_metadata_on_style_id"
  end

  create_table "default_unit_prices", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "quantity"
    t.integer "color_id"
    t.integer "style_id"
    t.string "algorithm"
    t.decimal "price", precision: 8, scale: 2
    t.string "last_errors"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "pricing_group_id"
    t.decimal "regular_unit_price", precision: 8, scale: 2
    t.index ["style_id"], name: "index_default_unit_prices_on_style_id"
  end

  create_table "distortions", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "view_id"
    t.string "kind", null: false
    t.string "mode"
    t.float "radius"
    t.float "pitch"
    t.float "taper"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["view_id"], name: "index_distortions_on_view_id"
  end

  create_table "filter_groups", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug"
    t.boolean "thematic", default: true, null: false
    t.index ["slug"], name: "index_filter_groups_on_slug", unique: true
  end

  create_table "filter_tags", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name", null: false
    t.integer "filter_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "priority", default: 1, null: false
  end

  create_table "guidelines", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "view_id"
    t.integer "bottom", default: 0
    t.float "height"
    t.integer "left", default: 0
    t.string "name"
    t.integer "right", default: 0
    t.integer "top", default: 0
    t.float "width"
    t.string "old_position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["view_id"], name: "index_guidelines_on_view_id"
  end

  create_table "hazmat_categories", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "placements", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.decimal "left_chest", precision: 10, scale: 2
    t.decimal "full_front", precision: 10, scale: 2
    t.decimal "full_back", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_placements_on_name", unique: true
  end

  create_table "price_point_sets", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "pricing_group_id", null: false
    t.datetime "start_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pricing_group_id", "start_at"], name: "index_price_point_sets_on_pg_id_and_start_at", unique: true
    t.index ["pricing_group_id"], name: "index_price_point_sets_on_pricing_group_id"
    t.index ["start_at"], name: "index_price_point_sets_on_start_at"
  end

  create_table "price_points", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "quantity", null: false
    t.integer "color_count"
    t.decimal "first_side", precision: 8, scale: 2
    t.decimal "extra_side", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "price_point_set_id", null: false
    t.index ["price_point_set_id", "quantity", "color_count"], name: "index_price_points_on_pps_id_and_quantity_and_color_count", unique: true
    t.index ["price_point_set_id"], name: "index_price_points_on_price_point_set_id"
  end

  create_table "pricing_groups", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "style_id"
    t.integer "min_qty"
    t.string "name"
    t.float "pricing_factor_b"
    t.float "pricing_factor_d"
    t.float "pricing_factor_f"
    t.float "pricing_factor_s"
    t.float "pricing_factor_x"
    t.float "proposed_realb"
    t.string "proposed_realb_suppliers"
    t.datetime "realb_last_changed"
    t.string "realb_suppliers"
    t.float "singles_base_price"
    t.string "decoration_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float "realb"
    t.index ["decoration_type"], name: "index_pricing_groups_on_type"
    t.index ["id"], name: "index_pricing_groups_on_id"
    t.index ["name"], name: "index_pricing_groups_on_name"
    t.index ["style_id"], name: "index_pricing_groups_on_style_id"
  end

  create_table "pricing_lever_sets", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "pricing_group_id", null: false
    t.decimal "b", precision: 8, scale: 3
    t.decimal "multiplier", precision: 5, scale: 3, default: "1.0"
    t.decimal "addend", precision: 8, scale: 2, default: "0.0"
    t.datetime "start_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pricing_group_id", "start_at"], name: "index_pricing_lever_factors_on_pg_id_and_start_at", unique: true
    t.index ["pricing_group_id"], name: "index_pricing_lever_sets_on_pricing_group_id"
    t.index ["start_at"], name: "index_pricing_lever_sets_on_start_at"
  end

  create_table "products", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "key_benefits"
  end

  create_table "reporting_groups", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "rgbs", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "color_id"
    t.integer "blue"
    t.integer "green"
    t.integer "red"
    t.boolean "trim"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "views", size: :medium
    t.index ["color_id"], name: "index_rgbs_on_color_id"
    t.index ["trim"], name: "index_rgbs_on_trim"
  end

  create_table "settings", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.string "description", limit: 280, null: false
    t.string "value", null: false
    t.boolean "active", default: false, null: false
    t.index ["name"], name: "index_settings_on_name"
  end

  create_table "sizes", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "color_id"
    t.boolean "abo_singles"
    t.boolean "abo_bulk"
    t.string "gtin"
    t.string "name"
    t.string "status", default: "inactive"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "position"
    t.boolean "in_stock", default: false
    t.integer "last_known_supplier_quantity"
    t.integer "oos_threshold", default: 0
    t.index ["color_id", "name"], name: "index_sizes_on_color_id_and_name", unique: true
    t.index ["color_id"], name: "index_sizes_on_color_id"
    t.index ["position"], name: "index_sizes_on_position"
  end

  create_table "sizing_charts", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "style_id"
    t.boolean "active"
    t.integer "height"
    t.text "html", size: :medium
    t.integer "width"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["active"], name: "index_sizing_charts_on_active"
    t.index ["style_id"], name: "index_sizing_charts_on_style_id", unique: true
  end

  create_table "skus", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "style_id"
    t.integer "color_id"
    t.string "size_id"
    t.string "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["color_id", "size_id"], name: "index_skus_on_color_id_and_size_id"
    t.index ["size_id"], name: "idx_skus_size_id"
    t.index ["style_id", "color_id", "size_id"], name: "index_skus_on_style_id_and_color_id_and_size_id", unique: true
  end

  create_table "style_categories", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "category_id"
    t.integer "style_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "position"
    t.index ["category_id"], name: "index_style_categories_on_category_id"
    t.index ["position"], name: "index_style_categories_on_position"
    t.index ["style_id", "category_id"], name: "index_style_categories_on_style_id_and_category_id", unique: true
    t.index ["style_id"], name: "index_style_categories_on_style_id"
  end

  create_table "style_filter_taggings", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "style_id", null: false
    t.integer "filter_tag_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["filter_tag_id"], name: "index_style_filter_taggings_on_filter_tag_id"
    t.index ["style_id", "filter_tag_id"], name: "unique_style_filter_group_filter_tag", unique: true
    t.index ["style_id"], name: "index_style_filter_taggings_on_style_id"
  end

  create_table "style_hazmat_categories", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "style_id", null: false
    t.bigint "hazmat_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hazmat_category_id"], name: "index_style_hazmat_categories_on_hazmat_category_id"
    t.index ["style_id"], name: "index_style_hazmat_categories_on_style_id"
  end

  create_table "style_sizes", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "style_id"
    t.string "name", null: false
    t.decimal "shipping_weight", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "position", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["style_id"], name: "index_style_sizes_on_style_id"
  end

  create_table "styles", id: :integer, default: 0, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "primary_category_id"
    t.string "additional_print_areas"
    t.boolean "allow_blank"
    t.string "back_art_location"
    t.integer "back_art_point"
    t.integer "color_limit"
    t.text "constraints", size: :medium
    t.string "decoration_method"
    t.text "features"
    t.boolean "fitted"
    t.string "front_art_location"
    t.integer "front_art_point"
    t.text "general_comments"
    t.boolean "has_lineup"
    t.boolean "has_singles_enabled_colors"
    t.boolean "id_leading_zero"
    t.boolean "ihp_bulk_enabled"
    t.string "manufacturer"
    t.string "material", limit: 500
    t.string "mill_no"
    t.integer "min_qty"
    t.string "name"
    t.text "notes", size: :medium
    t.integer "price_level"
    t.integer "priority"
    t.integer "rush_decoration_days"
    t.boolean "singles_alternative_id_leading_zero"
    t.string "sizing"
    t.boolean "specialty"
    t.boolean "sponsorship"
    t.integer "standard_decoration_days"
    t.string "status", default: "in-progress"
    t.string "subheading"
    t.text "supplier_notes", size: :medium
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "lock_version"
    t.text "sizes", size: :medium
    t.string "catalog_detail_image_filename"
    t.string "catalog_detail_image_md5"
    t.integer "singles_alternative_id"
    t.integer "rating_count", default: 0
    t.decimal "rating_score", precision: 3, scale: 2, default: "0.0"
    t.datetime "deployed_at"
    t.string "deploy_type"
    t.datetime "retired_at"
    t.string "complements_badge"
    t.string "style_type", default: "apparel", null: false
    t.text "art_notes"
    t.integer "tp_rating_count", default: 0
    t.decimal "tp_rating_score", precision: 3, scale: 2, default: "0.0"
    t.string "commodity_code", limit: 12
    t.boolean "auto_art_enabled", default: false, null: false
    t.integer "placement_id"
    t.integer "sold_as_sample", default: 0
    t.string "role"
    t.string "brand"
    t.string "brand_type"
    t.string "origin_country_code", limit: 2
    t.string "unit_of_measure", limit: 2, default: "EA"
    t.integer "quantity_per_unit", default: 1
    t.bigint "reporting_group_id"
    t.boolean "individual_ship_eligible", default: false, null: false
    t.string "product_type", default: "Unisex", null: false
    t.boolean "international_ship_eligible", default: false, null: false
    t.string "branding_method"
    t.bigint "product_id"
    t.string "region"
    t.string "origin"
    t.boolean "kit_eligible", default: false, null: false
    t.integer "super_rush_turntime"
    t.integer "super_rush_decoration_days"
    t.index ["catalog_detail_image_filename"], name: "index_styles_on_catalog_detail_image_filename"
    t.index ["catalog_detail_image_md5"], name: "index_styles_on_catalog_detail_image_md5"
    t.index ["color_limit"], name: "index_styles_on_color_limit"
    t.index ["decoration_method"], name: "index_styles_on_decoration_method"
    t.index ["fitted"], name: "index_styles_on_fitted"
    t.index ["id_leading_zero"], name: "index_styles_on_id_leading_zero"
    t.index ["ihp_bulk_enabled"], name: "index_styles_on_ihp_bulk_enabled"
    t.index ["manufacturer"], name: "index_styles_on_manufacturer"
    t.index ["mill_no"], name: "index_styles_on_mill_no"
    t.index ["min_qty"], name: "index_styles_on_min_qty"
    t.index ["name"], name: "index_styles_on_name"
    t.index ["placement_id"], name: "index_styles_on_placement_id"
    t.index ["price_level"], name: "index_styles_on_price_level"
    t.index ["primary_category_id"], name: "index_styles_on_primary_category_id"
    t.index ["product_id"], name: "index_styles_on_product_id"
    t.index ["reporting_group_id"], name: "index_styles_on_reporting_group_id"
    t.index ["rush_decoration_days"], name: "index_styles_on_rush_decoration_days"
    t.index ["singles_alternative_id"], name: "index_styles_on_singles_alternative_id"
    t.index ["specialty"], name: "index_styles_on_specialty"
    t.index ["standard_decoration_days"], name: "index_styles_on_standard_decoration_days"
    t.index ["status", "primary_category_id"], name: "idx_styles_primary_category_id_status"
    t.index ["status"], name: "index_styles_on_status"
    t.index ["style_type"], name: "index_styles_on_style_type"
  end

  create_table "subtle_ink_groups", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "color_id", null: false
    t.string "print_type", limit: 30, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["color_id", "print_type"], name: "index_subtle_ink_groups_on_color_id_and_print_type", unique: true
  end

  create_table "subtle_inks", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "subtle_ink_group_id", null: false
    t.integer "ink_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subtle_ink_group_id", "ink_id"], name: "index_subtle_inks_on_subtle_ink_group_id_and_ink_id", unique: true
  end

  create_table "supplier_unique_ids", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "size_id"
    t.integer "supplier_id"
    t.string "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "part_group"
    t.index ["size_id"], name: "index_supplier_unique_ids_on_size_id"
    t.index ["supplier_id"], name: "index_supplier_unique_ids_on_supplier_id"
    t.index ["uid"], name: "index_supplier_unique_ids_on_uid"
  end

  create_table "supporting_images", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "style_id"
    t.string "name"
    t.string "full_size_filename"
    t.string "full_size_md5"
    t.string "thumb_filename"
    t.string "thumb_md5"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "position"
    t.boolean "pla_image", default: false
    t.index ["full_size_filename"], name: "index_supporting_images_on_full_size_filename"
    t.index ["full_size_md5"], name: "index_supporting_images_on_full_size_md5"
    t.index ["position"], name: "index_supporting_images_on_position"
    t.index ["style_id", "name"], name: "index_supporting_images_on_style_id_and_name"
    t.index ["style_id"], name: "index_supporting_images_on_style_id"
  end

  create_table "turntimes", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "style_id"
    t.integer "rush"
    t.integer "standard"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["style_id"], name: "index_turntimes_on_style_id", unique: true
  end

  create_table "version_associations", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "version_id"
    t.string "foreign_key_name", null: false
    t.integer "foreign_key_id"
    t.string "foreign_type"
    t.index ["foreign_key_name", "foreign_key_id", "foreign_type"], name: "index_version_associations_on_foreign_key"
    t.index ["version_id"], name: "index_version_associations_on_version_id"
  end

  create_table "versions", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "item_type", limit: 191, null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", size: :long
    t.text "object_changes"
    t.datetime "created_at", precision: 6
    t.integer "transaction_id"
    t.string "item_subtype"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["transaction_id"], name: "index_versions_on_transaction_id"
  end

  create_table "view_images", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "color_id"
    t.string "image_filename"
    t.string "image_md5"
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "alt_image_filename"
    t.string "alt_image_md5"
    t.text "color_note", size: :medium
    t.index ["color_id"], name: "index_view_images_on_color_id"
    t.index ["image_filename"], name: "index_view_images_on_image_filename"
    t.index ["image_md5"], name: "index_view_images_on_image_md5"
  end

  create_table "views", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "style_id"
    t.string "replacement_for"
    t.string "name"
    t.float "scale"
    t.boolean "active", default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "note", size: :medium
    t.integer "promostd_location_id"
    t.index ["active"], name: "index_views_on_active"
    t.index ["name"], name: "index_views_on_name"
    t.index ["replacement_for"], name: "index_views_on_replacement_for"
    t.index ["style_id"], name: "index_views_on_style_id"
  end

  add_foreign_key "styles", "products"
  add_foreign_key "styles", "reporting_groups"
  add_foreign_key "subtle_ink_groups", "colors"
  add_foreign_key "subtle_inks", "subtle_ink_groups"
end
