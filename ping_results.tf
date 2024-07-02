### Take all ping_result-*.log files and aggregate them into aggregated.log
resource "null_resource" "aggregate_ping_results" {
  depends_on = [null_resource.ping_scp]
  provisioner "local-exec" {
    command = <<EOT
      for file in ./ping_results/ping_result_*.log; do
        echo "Results from $file" >> ./ping_results/aggregated.log
        cat $file >> ./ping_results/aggregated.log
        echo "" >> ./ping_results/aggregated.log
      done
    EOT
  }
}

### Reference ping results (FAIL/PASS) in data external source
data "external" "check_ping_results" {
  depends_on = [null_resource.aggregate_ping_results]
  program    = ["bash", "./scripts/check_ping_results.sh"]
}

### Read aggregate.log, output it to JSON and reference the output in data external source
data "external" "read_log" {
  depends_on = [null_resource.aggregate_ping_results]
  program    = ["bash", "./scripts/read_log.sh"]
}