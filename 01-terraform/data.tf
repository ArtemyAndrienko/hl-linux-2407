
# data "yandex_vpc" "selected" {
#   tags {
#     Name = "${var.vpc_name}"
#   }
# }

# data "yandex_subnet_ids" "private" {
#   vpc_id = "${data.yandex_vpc.selected.id}"
# }
