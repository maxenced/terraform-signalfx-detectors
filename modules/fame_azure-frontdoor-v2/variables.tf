# waf_actions detector

variable "waf_actions_notifications" {
  description = "Notification recipients list per severity overridden for waf_actions detector"
  type        = map(list(string))
  default     = {}
}

variable "waf_actions_aggregation_function" {
  description = "Aggregation function and group by for waf_actions detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "waf_actions_transformation_function" {
  description = "Transformation function for waf_actions detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "waf_actions_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "waf_actions_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "waf_actions_disabled" {
  description = "Disable all alerting rules for waf_actions detector"
  type        = bool
  default     = null
}

variable "waf_actions_disabled_major" {
  description = "Disable major alerting rule for waf_actions detector"
  type        = bool
  default     = null
}

variable "waf_actions_current_window_duration" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}
