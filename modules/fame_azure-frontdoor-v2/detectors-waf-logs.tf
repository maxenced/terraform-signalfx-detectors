resource "signalfx_detector" "waf_logs" {
  name = format("%s %s", local.detector_name_prefix, "Azure FrontDoor v2 waf logs")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.against_recent import against_recent
    A = data('fame.azure.frontdoor.waf_logs', filter=${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.waf_logs_aggregation_function}${var.waf_logs_transformation_function}
    signal = (A.sum()).fill(0).publish('signal')
    against_recent.detector_mean_std(signal, current_window=duration('${var.waf_logs_current_window_duration}')).publish('MAJOR')
EOF

  rule {
    description           = "Sudden change of WAF logs activity"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.waf_logs_disabled_major, var.waf_logs_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.waf_logs_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.waf_logs_runbook_url, var.runbook_url), "")
    tip                   = var.waf_logs_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

#against_recent.detector_mean_std(signal, current_window=duration('3m'), historical_window=duration('2h'), fire_num_stddev=6).publish('MAJOR')

