resource "signalfx_detector" "failover_unavailable" {
  name = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}] GCP Cloud SQL failover"

  program_text = <<-EOF
    signal = data('database/available_for_failover', ${module.filter-tags.filter_custom})${var.failover_unavailable_aggregation_function}${var.failover_unavailable_transformation_function}.publish('signal')
    detect(when(signal < 1)).publish('MAJOR')
EOF

  rule {
    description           = "is unavailable"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.failover_unavailable_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.failover_unavailable_notifications, "major", []), var.notifications.major)
    parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
  }
}

