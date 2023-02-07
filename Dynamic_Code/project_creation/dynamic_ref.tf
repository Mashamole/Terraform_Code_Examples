# -------------------------------------------------
#            Dynamic Creation
# -------------------------------------------------

resource "google_bigquery_table" "tables" {
  for_each = local.tables
  project = "gsc-gc-prj-dev-dna-ext"
  dataset_id = each.value["dataset_id"]
  table_id = each.value["table_id"]
  clustering = try(each.value["clustering"], [])

  dynamic "time_partitioning" {
    for_each = [
      var.time_partitioning
    ]
    content {
      type = try(each.value["partition_type"], time_partitioning.value["type"])
      field = try(each.value["partition_field"], time_partitioning.value["field"])
    }
  }

  schema = file("${path.module}/schema/${each.value["schema_path"]}")
}
