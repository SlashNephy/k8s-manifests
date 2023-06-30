resource "mackerel_monitor" "cpu_temperature" {
  name = "CPU 温度が高すぎる"

  host_metric {
    metric             = "custom.telegraf.temp.host-lily_sensor-coretemp_package_id_0.temp"
    operator           = ">"
    warning            = "60"
    critical           = "70"
    duration           = 3
    max_check_attempts = 1
    scopes             = ["Production:Server"]
  }
}
