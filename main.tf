# Manage gitlab repository
resource "gitlab_project" "this" {
  name        = var.settings_name
  description = var.settings_description

  path         = var.settings_path
  namespace_id = var.settings_namespace_id

  default_branch                                   = var.settings_default_branch
  allow_merge_on_skipped_pipeline                  = var.settings_allow_merge_on_skipped_pipeline
  analytics_access_level                           = var.settings_analytics_access_level
  approvals_before_merge                           = var.settings_approvals_before_merge
  archive_on_destroy                               = var.settings_archive_on_destroy
  archived                                         = var.settings_archived
  auto_cancel_pending_pipelines                    = var.settings_auto_cancel_pending_pipelines
  auto_devops_deploy_strategy                      = var.settings_auto_devops_deploy_strategy
  auto_devops_enabled                              = var.settings_auto_devops_enabled
  autoclose_referenced_issues                      = var.settings_autoclose_referenced_issues
  avatar                                           = var.settings_avatar
  avatar_hash                                      = var.settings_avatar != null ? filesha256(var.settings_avatar) : null
  build_git_strategy                               = var.settings_build_git_strategy
  build_timeout                                    = var.settings_build_timeout
  builds_access_level                              = var.settings_builds_access_level
  ci_config_path                                   = var.settings_ci_config_path
  ci_default_git_depth                             = var.settings_ci_default_git_depth
  ci_delete_pipelines_in_seconds                   = var.settings_ci_delete_pipelines_in_seconds
  ci_forward_deployment_enabled                    = var.settings_ci_forward_deployment_enabled
  ci_forward_deployment_rollback_allowed           = var.settings_ci_forward_deployment_rollback_allowed
  ci_id_token_sub_claim_components                 = var.settings_ci_id_token_sub_claim_components
  ci_push_repository_for_job_token_allowed         = var.settings_ci_push_repository_for_job_token_allowed
  ci_pipeline_variables_minimum_override_role      = var.settings_ci_pipeline_variables_minimum_override_role
  ci_restrict_pipeline_cancellation_role           = var.settings_ci_restrict_pipeline_cancellation_role
  ci_separated_caches                              = var.settings_ci_separated_caches
  container_registry_access_level                  = var.settings_container_registry_access_level
  emails_enabled                                   = var.settings_emails_enabled
  environments_access_level                        = var.settings_environments_access_level
  external_authorization_classification_label      = var.settings_external_authorization_classification_label
  feature_flags_access_level                       = var.settings_feature_flags_access_level
  forking_access_level                             = var.settings_forking_access_level
  group_runners_enabled                            = var.settings_group_runners_enabled
  use_custom_template                              = var.settings_use_custom_template
  group_with_project_templates_id                  = var.settings_group_with_project_templates_id
  infrastructure_access_level                      = var.settings_infrastructure_access_level
  initialize_with_readme                           = var.settings_initialize_with_readme
  issues_access_level                              = var.settings_issues_access_level
  issues_template                                  = var.settings_issues_template
  keep_latest_artifact                             = var.settings_keep_latest_artifact
  lfs_enabled                                      = var.settings_lfs_enabled
  merge_commit_template                            = var.settings_merge_commit_template
  merge_method                                     = var.settings_merge_method
  merge_pipelines_enabled                          = var.settings_merge_pipelines_enabled
  merge_requests_access_level                      = var.settings_merge_requests_access_level
  merge_requests_template                          = var.settings_merge_requests_template
  merge_trains_enabled                             = var.settings_merge_trains_enabled
  model_experiments_access_level                   = var.settings_model_experiments_access_level
  model_registry_access_level                      = var.settings_model_registry_access_level
  monitor_access_level                             = var.settings_monitor_access_level
  only_allow_merge_if_all_discussions_are_resolved = var.settings_only_allow_merge_if_all_discussions_are_resolved
  only_allow_merge_if_pipeline_succeeds            = var.settings_only_allow_merge_if_pipeline_succeeds
  packages_enabled                                 = var.settings_packages_enabled
  pages_access_level                               = var.settings_pages_access_level
  printing_merge_request_link_enabled              = var.settings_printing_merge_request_link_enabled
  public_jobs                                      = var.settings_public_jobs
  releases_access_level                            = var.settings_releases_access_level
  remove_source_branch_after_merge                 = var.settings_remove_source_branch_after_merge
  repository_access_level                          = var.settings_repository_access_level
  repository_storage                               = var.settings_repository_storage
  request_access_enabled                           = var.settings_request_access_enabled
  requirements_access_level                        = var.settings_requirements_access_level
  resolve_outdated_diff_discussions                = var.settings_resolve_outdated_diff_discussions
  security_and_compliance_access_level             = var.settings_security_and_compliance_access_level
  shared_runners_enabled                           = var.settings_shared_runners_enabled
  skip_wait_for_default_branch_protection          = var.settings_skip_wait_for_default_branch_protection
  snippets_access_level                            = var.settings_snippets_access_level
  squash_commit_template                           = var.settings_squash_commit_template
  squash_option                                    = var.settings_squash_option
  suggestion_commit_message                        = var.settings_suggestion_commit_message
  template_name                                    = var.settings_template_name
  template_project_id                              = var.settings_template_project_id
  topics                                           = var.settings_topics
  visibility_level                                 = var.settings_visibility_level
  wiki_access_level                                = var.settings_wiki_access_level

  dynamic "container_expiration_policy" {
    for_each = var.settings_container_expiration_policy

    content {
      cadence           = container_expiration_policy.value.cadence
      enabled           = container_expiration_policy.value.enabled
      keep_n            = container_expiration_policy.value.keep_n
      name_regex_delete = container_expiration_policy.value.name_regex_delete
      name_regex_keep   = container_expiration_policy.value.name_regex_keep
      older_than        = container_expiration_policy.value.older_than
    }
  }

  dynamic "timeouts" {
    for_each = var.settings_timeouts != null ? var.settings_timeouts : {}

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
    }
  }
}

# Manage gitlab repository branch protection rules
resource "gitlab_branch_protection" "this" {
  for_each = var.branches_protection

  project = gitlab_project.this.id
  branch  = each.key

  allow_force_push             = each.value.allow_force_push
  code_owner_approval_required = each.value.code_owner_approval_required
  push_access_level            = each.value.push_access_level
  merge_access_level           = each.value.merge_access_level
  unprotect_access_level       = each.value.unprotect_access_level

  dynamic "allowed_to_merge" {
    for_each = each.value.allowed_to_merge.group_id

    content {
      group_id = allowed_to_merge.value
    }
  }

  dynamic "allowed_to_merge" {
    for_each = each.value.allowed_to_merge.user_id

    content {
      user_id = allowed_to_merge.value
    }
  }

  dynamic "allowed_to_push" {
    for_each = each.value.allowed_to_push.group_id

    content {
      group_id = allowed_to_push.value
    }
  }

  dynamic "allowed_to_push" {
    for_each = each.value.allowed_to_push.user_id

    content {
      user_id = allowed_to_push.value
    }
  }

  dynamic "allowed_to_unprotect" {
    for_each = each.value.allowed_to_unprotect.group_id

    content {
      group_id = allowed_to_unprotect.value
    }
  }

  dynamic "allowed_to_unprotect" {
    for_each = each.value.allowed_to_unprotect.user_id

    content {
      user_id = allowed_to_unprotect.value
    }
  }

}

# Manage gitlab repository branch protection rules
resource "gitlab_tag_protection" "this" {
  for_each = var.tags_protection

  project = gitlab_project.this.id
  tag     = each.key

  create_access_level = each.value.create_access_level

  dynamic "allowed_to_create" {
    for_each = each.value.allowed_to_create.user_id

    content {
      access_level = allowed_to_create.value.access_level
      user_id      = allowed_to_create.value.user_id
    }
  }

  dynamic "allowed_to_create" {
    for_each = each.value.allowed_to_create.group_id

    content {
      access_level = allowed_to_create.value.access_level
      group_id     = allowed_to_create.value.group_id
    }
  }
}

# Manage repo labels for issues and merge requests
resource "gitlab_project_label" "this" {
  for_each = var.labels

  project = gitlab_project.this.id
  name    = each.key

  color       = each.value.color
  description = each.value.description
}

# Manage repo access tokens
resource "gitlab_project_access_token" "this" {
  # Variables are not deployed if project is archived
  for_each = var.settings_archived == false ? var.access_tokens : {}

  project                = gitlab_project.this.id
  name                   = each.key
  expires_at             = each.value.expires_at
  description            = each.value.description
  access_level           = each.value.access_level
  scopes                 = each.value.scopes
  rotation_configuration = each.value.rotation_configuration
}

# Manage repo variables accessible for CI
resource "gitlab_project_variable" "this" {
  # Variables are not deployed if project is archived, see locals.tf
  for_each = local.variables

  project     = gitlab_project.this.id
  key         = each.key
  value       = sensitive(each.value.value)
  description = each.value.description

  environment_scope = each.value.environment_scope
  hidden            = each.value.hidden
  masked            = each.value.masked
  protected         = each.value.protected
  raw               = each.value.raw
  variable_type     = each.value.variable_type
}

# Manage repo mirroring to another git server
resource "gitlab_project_mirror" "this" {
  for_each = var.mirrors

  project = gitlab_project.this.id
  url     = each.value.url

  enabled                 = each.value.enabled
  keep_divergent_refs     = each.value.keep_divergent_refs
  only_protected_branches = each.value.only_protected_branches
}

# Manage repo hooks
resource "gitlab_project_hook" "this" {
  for_each = var.hooks

  project = gitlab_project.this.id
  url     = each.value.url

  token                      = each.value.token
  custom_webhook_template    = each.value.custom_webhook_template
  confidential_issues_events = each.value.confidential_issues_events
  confidential_note_events   = each.value.confidential_note_events
  deployment_events          = each.value.deployment_events
  enable_ssl_verification    = each.value.enable_ssl_verification
  issues_events              = each.value.issues_events
  job_events                 = each.value.job_events
  merge_requests_events      = each.value.merge_requests_events
  note_events                = each.value.note_events
  pipeline_events            = each.value.pipeline_events
  push_events                = each.value.push_events
  push_events_branch_filter  = each.value.push_events_branch_filter
  releases_events            = each.value.releases_events
  tag_push_events            = each.value.tag_push_events
  wiki_page_events           = each.value.wiki_page_events
}

# Manage repo badges
resource "gitlab_project_badge" "this" {
  for_each = var.badges

  project   = gitlab_project.this.id
  name      = each.key
  image_url = each.value.image_url
  link_url  = each.value.link_url
}

# Manage repo custom attributes
resource "gitlab_project_custom_attribute" "this" {
  for_each = var.custom_attributes

  project = gitlab_project.this.id
  key     = each.key
  value   = each.value
}

# Manage repo mr level approval
resource "gitlab_project_level_mr_approvals" "this" {
  count = var.level_mr_approval.enabled ? 1 : 0

  project = gitlab_project.this.id

  disable_overriding_approvers_per_merge_request = var.level_mr_approval.disable_overriding_approvers_per_merge_request
  merge_requests_author_approval                 = var.level_mr_approval.merge_requests_author_approval
  merge_requests_disable_committers_approval     = var.level_mr_approval.merge_requests_disable_committers_approval
  require_password_to_approve                    = var.level_mr_approval.require_password_to_approve
  reset_approvals_on_push                        = var.level_mr_approval.reset_approvals_on_push
  selective_code_owner_removals                  = var.level_mr_approval.selective_code_owner_removals
}

# Manage repo notification levels
resource "gitlab_project_level_notifications" "preset" {
  for_each = var.preset_level_notifications

  project = gitlab_project.this.id
  level   = each.value
}

resource "gitlab_project_level_notifications" "custom" {
  for_each = var.custom_level_notifications

  project                      = gitlab_project.this.id
  level                        = "custom"
  close_issue                  = each.value.close_issue
  close_merge_request          = each.value.close_merge_request
  failed_pipeline              = each.value.failed_pipeline
  fixed_pipeline               = each.value.fixed_pipeline
  issue_due                    = each.value.issue_due
  merge_merge_request          = each.value.merge_merge_request
  merge_when_pipeline_succeeds = each.value.merge_when_pipeline_succeeds
  moved_project                = each.value.moved_project
  new_issue                    = each.value.new_issue
  new_merge_request            = each.value.new_merge_request
  new_note                     = each.value.new_note
  push_to_merge_request        = each.value.push_to_merge_request
  reassign_issue               = each.value.reassign_issue
  reassign_merge_request       = each.value.reassign_merge_request
  reopen_issue                 = each.value.reopen_issue
  reopen_merge_request         = each.value.reopen_merge_request
  success_pipeline             = each.value.success_pipeline
}

resource "gitlab_deploy_key" "this" {
  for_each = var.deploy_keys

  project  = gitlab_project.this.id
  title    = each.key
  key      = each.value.key
  can_push = each.value.can_push
}

resource "gitlab_deploy_token" "this" {
  for_each = var.deploy_tokens

  project    = gitlab_project.this.id
  name       = each.key
  scopes     = each.value.key
  expires_at = each.value.expires_at
  username   = each.value.username
}
