output "cache_rate" {
  description = "Detector resource for cache_rate"
  value       = signalfx_detector.cache_rate
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "http_errors" {
  description = "Detector resource for http_errors"
  value       = signalfx_detector.http_errors
}

output "probes_health" {
  description = "Detector resource for probes_health"
  value       = signalfx_detector.probes_health
}

output "waf_logs" {
  description = "Detector resource for waf_logs"
  value       = signalfx_detector.waf_logs
}

