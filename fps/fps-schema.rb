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

ActiveRecord::Schema[7.1].define(version: 2025_08_21_133330) do
  create_table "alembic_version", primary_key: "version_num", id: { type: :string, limit: 32 }, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
  end

  create_table "auxiliary_product_details", primary_key: ["product_id", "provider_name"], charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "provider_id", null: false
    t.string "provider_name", limit: 50, null: false
    t.string "product_id", limit: 64, null: false
    t.string "description", limit: 500
    t.text "features"
    t.string "hazmat"
    t.index ["product_id", "provider_name"], name: "idx_on_product_id_provider_name_16b5cc6566", unique: true
  end

  create_table "categories", primary_key: "category_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "product_id", limit: 64, null: false
    t.integer "provider_id", null: false
    t.string "provider_name", limit: 50, null: false
    t.string "category_name", limit: 256
    t.string "subcategory", limit: 256
    t.index ["product_id", "provider_id"], name: "ix_categories"
    t.index ["product_id", "provider_name"], name: "categories_idx1"
    t.index ["provider_id"], name: "provider_id"
  end

  create_table "fulfillment_promo_product_skus", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "product_id", limit: 64, null: false
    t.string "provider_name", limit: 50, null: false
    t.string "part_id", limit: 50, null: false
    t.integer "decoration_id", null: false
    t.integer "mms_sku", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "disabled_at"
    t.integer "provider_id", null: false
    t.integer "part_group"
    t.index ["mms_sku"], name: "index_fulfillment_promo_product_skus_on_mms_sku"
    t.index ["provider_id", "product_id", "part_id", "decoration_id"], name: "idx_on_provider_id_product_id_part_id_decoration_id_5691dfea80"
  end

  create_table "fulfillment_promo_product_views", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider_name", limit: 50, null: false
    t.string "product_id", limit: 64, null: false
    t.integer "location_id", null: false
    t.integer "decoration_id", null: false
    t.string "mms_view_name", null: false
    t.index ["provider_name", "product_id", "location_id", "decoration_id"], name: "idx_on_provider_name_product_id_location_id_decorat_f50aef334c", unique: true
  end

  create_table "inventory_future_availabilities", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "product_id", limit: 64, null: false
    t.integer "provider_id", null: false
    t.string "provider_name", limit: 50, null: false
    t.string "part_id", limit: 64, null: false
    t.string "inventory_location_id", limit: 64, null: false
    t.decimal "quantity", precision: 12, scale: 4
    t.string "quantity_uom", limit: 2
    t.datetime "available_on", precision: nil
    t.index ["product_id", "provider_id", "part_id", "inventory_location_id"], name: "ix_inventory_future_availabilities"
    t.index ["product_id", "provider_name", "part_id", "inventory_location_id"], name: "idx_inventory_future_availabilities_pid_pn_partid_invlocid"
    t.index ["provider_id"], name: "provider_id"
  end

  create_table "media_class_types", primary_key: "media_class_type_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "product_media_id", null: false
    t.string "product_id", limit: 64, null: false
    t.integer "provider_id", null: false
    t.string "provider_name", limit: 50, null: false
    t.integer "class_type_id"
    t.string "class_type_name", limit: 64
    t.string "media_type", limit: 250, null: false
    t.index ["product_id", "provider_id", "media_type"], name: "ix_media_class_types"
    t.index ["product_id", "provider_name", "media_type"], name: "media_class_types_idx1"
    t.index ["provider_id"], name: "provider_id"
  end

  create_table "part_colors", primary_key: ["product_id", "provider_id", "part_id", "ordinal"], charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "product_id", limit: 64, null: false
    t.integer "provider_id", null: false
    t.string "part_id", limit: 64, null: false
    t.integer "ordinal", null: false
    t.string "color_name", limit: 64
    t.string "color_hex", limit: 64
    t.string "color_standard_name", limit: 64
    t.string "approximate_pms", limit: 64
    t.string "provider_name", limit: 64, null: false
    t.index ["product_id", "provider_id", "part_id"], name: "ix_part_colors"
    t.index ["product_id", "provider_name", "part_id"], name: "ix_part_colors_provider_name"
    t.index ["provider_id"], name: "provider_id"
    t.index ["provider_name"], name: "provider_name"
  end

  create_table "part_inventories", primary_key: ["product_id", "provider_name", "part_id"], charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "product_id", limit: 64, null: false
    t.integer "provider_id", null: false
    t.string "provider_name", limit: 50, null: false
    t.string "part_id", limit: 64, null: false
    t.boolean "main_part"
    t.string "part_color", limit: 64
    t.string "label_size", limit: 6
    t.string "part_description", limit: 256
    t.decimal "quantity_available", precision: 12, scale: 4
    t.string "quantity_uom", limit: 2
    t.boolean "manufactured_item"
    t.boolean "buy_to_order"
    t.integer "replenishment_lead_time"
    t.string "attribute_selection", limit: 64
    t.datetime "last_modified", precision: nil
    t.index ["product_id", "provider_id", "part_id"], name: "ix_part_inventories", unique: true
    t.index ["provider_id"], name: "provider_id"
  end

  create_table "part_inventory_locations", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "product_id", limit: 64, null: false
    t.integer "provider_id", null: false
    t.string "provider_name", limit: 64, null: false
    t.string "part_id", limit: 64, null: false
    t.string "inventory_location_id", limit: 64, null: false
    t.string "inventory_location_name", limit: 64
    t.string "postal_code", limit: 10
    t.string "country", limit: 2
    t.decimal "quantity", precision: 12, scale: 4
    t.string "quantity_uom", limit: 2
    t.index ["product_id", "provider_id", "part_id"], name: "ix_part_inventory_locations"
    t.index ["product_id", "provider_name", "part_id"], name: "idx_part_inventory_locations_product_id"
    t.index ["provider_id"], name: "provider_id"
  end

  create_table "part_packages", primary_key: "part_package_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "product_id", limit: 64, null: false
    t.integer "provider_id", null: false
    t.string "provider_name", limit: 50, null: false
    t.string "part_id", limit: 64, null: false
    t.boolean "default"
    t.string "package_type", limit: 260
    t.text "description"
    t.integer "quantity"
    t.string "dimension_uom", limit: 10
    t.decimal "depth", precision: 10, scale: 2
    t.decimal "height", precision: 10, scale: 2
    t.decimal "width", precision: 10, scale: 2
    t.string "weight_uom", limit: 10
    t.decimal "weight", precision: 10, scale: 2
    t.index ["product_id", "provider_id", "part_id"], name: "ix_part_packages"
    t.index ["product_id", "provider_name", "part_id"], name: "part_packages_idx1"
    t.index ["provider_id"], name: "provider_id"
  end

  create_table "part_shipping_packages", primary_key: "part_shipping_package_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "product_id", limit: 64, null: false
    t.integer "provider_id", null: false
    t.string "provider_name", limit: 50, null: false
    t.string "part_id", limit: 64, null: false
    t.string "package_type", limit: 260
    t.integer "quantity"
    t.string "dimension_uom", limit: 10
    t.decimal "depth", precision: 10, scale: 2
    t.decimal "height", precision: 10, scale: 2
    t.decimal "width", precision: 10, scale: 2
    t.string "weight_uom", limit: 10
    t.decimal "weight", precision: 10, scale: 2
    t.index ["product_id", "provider_id", "part_id"], name: "ix_part_shipping_packages"
    t.index ["product_id", "provider_name", "part_id"], name: "part_shipping_packages_idx1"
    t.index ["provider_id"], name: "provider_id"
  end

  create_table "parts", primary_key: ["product_id", "provider_name", "part_id"], charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "product_id", limit: 64, null: false
    t.integer "provider_id", null: false
    t.string "provider_name", limit: 50, null: false
    t.string "part_id", limit: 64, null: false
    t.string "description", limit: 2048
    t.string "country_of_origin", limit: 2
    t.datetime "effective_date", precision: nil
    t.string "color_name", limit: 64
    t.string "color_hex", limit: 64
    t.string "color_standard_name", limit: 64
    t.string "primary_material", limit: 64
    t.string "dimension_uom", limit: 2
    t.decimal "depth", precision: 10, scale: 2
    t.decimal "height", precision: 10, scale: 2
    t.decimal "width", precision: 10, scale: 2
    t.string "weight_uom", limit: 2
    t.decimal "weight", precision: 10, scale: 2
    t.boolean "rush_service"
    t.boolean "closeout"
    t.boolean "hazmat"
    t.string "shape", limit: 64
    t.string "apparel_style", limit: 64
    t.string "label_size", limit: 6
    t.string "custom_size", limit: 64
    t.integer "lead_time"
    t.string "unspsc", limit: 8
    t.string "gtin", limit: 14
    t.datetime "end_date", precision: nil
    t.boolean "is_caution"
    t.string "caution_comment", limit: 1024
    t.string "nmfc_code", limit: 30
    t.string "nmfc_description", limit: 1024
    t.string "nmfc_number", limit: 64
    t.boolean "is_on_demand"
    t.index ["product_id", "provider_id", "part_id"], name: "ix_parts", unique: true
    t.index ["provider_id"], name: "provider_id"
  end

  create_table "product_configuration_charges", primary_key: "product_charge_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "product_id", limit: 50, null: false
    t.integer "provider_id", null: false
    t.string "provider_name", limit: 50, null: false
    t.integer "location_id"
    t.integer "decoration_id"
    t.integer "charge_id"
    t.string "charge_name", limit: 200
    t.string "charge_description", limit: 2048
    t.string "charge_type", limit: 50
    t.integer "x_min_qty"
    t.string "x_uom", limit: 10
    t.integer "y_min_qty"
    t.string "y_uom", limit: 20
    t.decimal "price", precision: 10, scale: 2
    t.decimal "repeat_price", precision: 10, scale: 2
    t.datetime "price_effective_date", precision: nil
    t.datetime "price_expiry_date", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "charges_applies_ltm"
    t.integer "charges_per_location"
    t.integer "charges_per_color"
    t.index ["product_id", "provider_id", "location_id", "decoration_id", "charge_id"], name: "ix_product_configuration_charges"
    t.index ["product_id", "provider_name", "location_id", "decoration_id", "charge_id"], name: "product_configuration_charges_idx1"
    t.index ["provider_id"], name: "provider_id"
  end

  create_table "product_configuration_parts", primary_key: "product_part_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "product_id", limit: 50, null: false
    t.integer "provider_id", null: false
    t.string "provider_name", limit: 50, null: false
    t.string "part_id", limit: 50
    t.string "part_description", limit: 300
    t.integer "part_group"
    t.string "part_group_description", limit: 300
    t.boolean "part_group_required"
    t.integer "part_ratio"
    t.datetime "updated_at", precision: nil
    t.index ["product_id", "provider_id", "part_id"], name: "ix_product_configuration_parts"
    t.index ["product_id", "provider_name", "part_id"], name: "product_configuration_parts_idx1"
    t.index ["provider_id"], name: "provider_id"
  end

  create_table "product_configurations", primary_key: "product_configuration_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "product_id", limit: 50, null: false
    t.integer "provider_id", null: false
    t.string "provider_name", limit: 50, null: false
    t.integer "location_id"
    t.string "location_name", limit: 100
    t.integer "location_rank"
    t.string "default_location", limit: 5
    t.integer "decorations_included"
    t.integer "max_decoration"
    t.integer "min_decoration"
    t.integer "decoration_id"
    t.string "decoration_name", limit: 100
    t.string "decoration_geometry", limit: 50
    t.decimal "decoration_height", precision: 10, scale: 2
    t.decimal "decoration_width", precision: 10, scale: 2
    t.decimal "decoration_diameter", precision: 10, scale: 2
    t.string "decoration_uom", limit: 50
    t.boolean "allow_sub_for_default_location"
    t.boolean "allow_sub_for_default_method"
    t.decimal "item_part_quantity_ltm", precision: 10, scale: 2
    t.decimal "decoration_units_included", precision: 10, scale: 2
    t.string "decoration_units_included_uom", limit: 50
    t.decimal "decoration_units_max", precision: 10, scale: 2
    t.boolean "default_decoration"
    t.decimal "lead_time", precision: 10, scale: 2
    t.decimal "rush_lead_time", precision: 10, scale: 2
    t.datetime "updated_at", precision: nil
    t.index ["product_id", "provider_id", "location_id", "decoration_id"], name: "ix_product_configurations"
    t.index ["product_id", "provider_name", "location_id", "decoration_id"], name: "product_configurations_idx1"
    t.index ["provider_id"], name: "provider_id"
  end

  create_table "product_fobs", primary_key: "product_fob_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "product_id", limit: 64, null: false
    t.integer "provider_id", null: false
    t.string "provider_name", limit: 50, null: false
    t.string "fob_id", limit: 64
    t.string "fob_city", limit: 50
    t.string "fob_state", limit: 5
    t.string "fob_postal_code", limit: 25
    t.index ["product_id", "provider_id", "fob_id"], name: "ix_product_fobs"
    t.index ["product_id", "provider_name", "fob_id"], name: "product_fobs_idx1"
    t.index ["provider_id"], name: "provider_id"
  end

  create_table "product_media_contents", primary_key: "product_media_content_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "product_id", limit: 64, null: false
    t.integer "provider_id", null: false
    t.string "provider_name", limit: 50, null: false
    t.string "part_id", limit: 64
    t.string "url", limit: 1030
    t.string "media_type", limit: 250, null: false
    t.decimal "file_size", precision: 20, scale: 5
    t.integer "width"
    t.integer "height"
    t.integer "dpi"
    t.string "color", limit: 256
    t.string "description", limit: 1030
    t.boolean "single_part"
    t.datetime "updated_at", precision: nil
    t.index ["product_id", "provider_id", "part_id"], name: "ix_product_media_contents"
    t.index ["product_id", "provider_name", "part_id"], name: "product_media_contents_idx1"
    t.index ["provider_id"], name: "provider_id"
  end

  create_table "product_parts_locations", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "product_id", limit: 64, null: false
    t.integer "provider_id", null: false
    t.string "provider_name", limit: 50, null: false
    t.string "part_id", limit: 64, null: false
    t.string "location_id", limit: 64, null: false
    t.index ["product_id", "provider_id", "location_id"], name: "ix_product_parts_locations"
    t.index ["product_id", "provider_id", "part_id", "location_id"], name: "ix_product_parts_locations_2"
    t.index ["product_id", "provider_name", "location_id"], name: "product_parts_locations_idx1"
    t.index ["product_id", "provider_name", "part_id", "location_id"], name: "product_parts_locations_idx2"
    t.index ["provider_id"], name: "provider_id"
  end

  create_table "product_prices", primary_key: "product_price_id", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "product_id", limit: 64, null: false
    t.integer "provider_id", null: false
    t.string "provider_name", limit: 50, null: false
    t.string "currency", limit: 64
    t.string "group_desc", limit: 2028
    t.string "group_name", limit: 512
    t.string "discount_code", limit: 5
    t.decimal "price", precision: 12, scale: 4
    t.integer "quantity_min"
    t.integer "quantity_max"
    t.index ["product_id", "provider_id"], name: "ix_product_prices"
    t.index ["product_id", "provider_name"], name: "product_prices_idx1"
    t.index ["provider_id"], name: "provider_id"
  end

  create_table "products", primary_key: ["product_id", "provider_name"], charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "product_id", limit: 64, null: false
    t.integer "provider_id", null: false
    t.string "provider_name", limit: 50, null: false
    t.string "product_name", limit: 256
    t.string "description", limit: 2048
    t.string "product_brand", limit: 64
    t.boolean "export"
    t.datetime "last_change_date", precision: nil
    t.datetime "creation_date", precision: nil
    t.datetime "end_date", precision: nil
    t.datetime "effective_date", precision: nil
    t.boolean "is_caution"
    t.string "caution_comment", limit: 1024
    t.boolean "is_closeout"
    t.string "line_name", limit: 64
    t.string "primary_image_url", limit: 1024
    t.string "unspsc_commodity_code", limit: 12
    t.index ["product_id", "provider_id"], name: "ix_products", unique: true
    t.index ["provider_id"], name: "provider_id"
    t.index ["provider_name"], name: "idx_products_provider_name"
  end

  create_table "providers", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "provider_name", limit: 64, null: false
    t.index ["provider_name"], name: "idx_providers_provider_name"
  end

  create_table "related_products", primary_key: ["product_id", "provider_name", "related_product_id"], charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "product_id", limit: 64, null: false
    t.integer "provider_id", null: false
    t.string "provider_name", limit: 50, null: false
    t.string "relation_type", limit: 100
    t.string "related_product_id", limit: 64, null: false
    t.index ["product_id", "provider_id", "related_product_id"], name: "ix_related_products", unique: true
    t.index ["product_id", "provider_name", "related_product_id"], name: "related_products_idx1"
    t.index ["provider_id"], name: "provider_id"
  end

  add_foreign_key "categories", "providers", name: "categories_ibfk_1"
  add_foreign_key "inventory_future_availabilities", "providers", name: "inventory_future_availabilities_ibfk_1"
  add_foreign_key "media_class_types", "providers", name: "media_class_types_ibfk_1"
  add_foreign_key "part_colors", "providers", name: "part_colors_ibfk_1"
  add_foreign_key "part_inventories", "providers", name: "part_inventories_ibfk_1"
  add_foreign_key "part_inventory_locations", "providers", name: "part_inventory_locations_ibfk_1"
  add_foreign_key "part_packages", "providers", name: "part_packages_ibfk_1"
  add_foreign_key "part_shipping_packages", "providers", name: "part_shipping_packages_ibfk_1"
  add_foreign_key "parts", "providers", name: "parts_ibfk_1"
  add_foreign_key "product_configuration_charges", "providers", name: "product_configuration_charges_ibfk_1"
  add_foreign_key "product_configuration_parts", "providers", name: "product_configuration_parts_ibfk_1"
  add_foreign_key "product_configurations", "providers", name: "product_configurations_ibfk_1"
  add_foreign_key "product_fobs", "providers", name: "product_fobs_ibfk_1"
  add_foreign_key "product_media_contents", "providers", name: "product_media_contents_ibfk_1"
  add_foreign_key "product_parts_locations", "providers", name: "product_parts_locations_ibfk_1"
  add_foreign_key "product_prices", "providers", name: "product_prices_ibfk_1"
  add_foreign_key "products", "providers", name: "products_ibfk_1"
  add_foreign_key "related_products", "providers", name: "related_products_ibfk_1"
end
