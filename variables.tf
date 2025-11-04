# Repository settings variables
# ------------------------------------------------------------------------
variable "settings_name" {
  type        = string
  description = "The name of the project."
}

variable "settings_description" {
  type        = string
  description = "A description of the project."

  nullable = false
}

variable "settings_path" {
  type        = string
  description = <<-EOM
  The path of the repository, will be set to `settings_name` if not provided.
  EOM

  default = null
}

variable "settings_namespace_id" {
  type        = number
  description = <<-EOM
  The namespace group or user of the project. Defaults to the user using this

  EOM

  default = null
}

variable "settings_default_branch" {
  type        = string
  description = "The default branch for the project."

  nullable = false
  default  = "main"
}

variable "settings_allow_merge_on_skipped_pipeline" {
  type        = bool
  description = <<-EOM
  Set to `false` if you do not want to treat skipped pipelines as if they
  finished with success.
  EOM

  nullable = false
  default  = false
}

variable "settings_analytics_access_level" {
  type        = string
  description = <<-EOM
  Set the analytics access level. Valid values are `disabled`, `private`, `enabled`.
  EOM

  nullable = false
  default  = "disabled"
}

variable "settings_approvals_before_merge" {
  type        = number
  description = <<-EOM
  Number of merge request approvals required for merging. Default is 1.

  Note: [From terraform resource](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project#approvals_before_merge):

  > This field does not work well in combination with the resource
  > `gitlab_project_approval_rule` resource and is most likely gonna be deprecated
  > in a future GitLab version (see [this upstream epic](https://gitlab.com/groups/gitlab-org/-/epics/7572)).
  >
  > In the meantime we recommend against using this attribute and use
  > `gitlab_project_approval_rule` instead.

  So for the moment, use this variable until deprecated in favor of variable
  `approval_rule`.
  EOM

  default = null
}

variable "settings_archive_on_destroy" {
  type        = bool
  description = <<-EOM
  Set to `true` to archive the project instead of deleting on destroy.

  If set to `true` it will entire omit the DELETE operation.
  EOM

  nullable = false
  default  = false
}

variable "settings_archived" {
  type        = bool
  description = <<-EOM
  Whether the project is in read-only mode (archived).

  Repositories can be archived/unarchived by toggling this parameter.
  EOM

  nullable = false
  default  = false
}

variable "settings_auto_cancel_pending_pipelines" {
  type        = string
  description = <<-EOM
  Auto-cancel pending pipelines. This isn’t a boolean, but `enabled/disabled`.
  EOM

  nullable = false
  default  = "enabled"
}

variable "settings_auto_devops_deploy_strategy" {
  type        = string
  description = <<-EOM
  Auto Deploy strategy. Valid values are `continuous`, `manual`,
  `timed_incremental`.
  EOM

  nullable = false
  default  = "manual"
}

variable "settings_auto_devops_enabled" {
  type        = bool
  description = "Enable Auto DevOps for this project."

  nullable = false
  default  = false
}

variable "settings_autoclose_referenced_issues" {
  type        = bool
  description = "Set whether auto-closing referenced issues on default branch."

  nullable = false
  default  = true
}

variable "settings_avatar" {
  type        = string
  description = <<-EOM
  A local path to the avatar image to upload.

  Note: not available for imported resources.
  EOM

  default = null
}

variable "settings_build_git_strategy" {
  type        = string
  description = <<-EOM
  The Git strategy. Defaults to fetch. Valid values are `clone`, `fetch`.
  EOM

  nullable = false
  default  = "fetch"
}

variable "settings_build_timeout" {
  type        = number
  description = "The maximum amount of time, in seconds, that a job can run."

  nullable = false
  default  = 3600
}

variable "settings_builds_access_level" {
  type        = string
  description = <<-EOM
  Set the builds access level. Valid values are `disabled`, `private`, `enabled`.
  EOM

  nullable = false
  default  = "disabled"
}

variable "settings_ci_config_path" {
  type        = string
  description = "Custom Path to CI config file."

  nullable = false
  default  = ".gitlab-ci.yml"
}

variable "settings_ci_default_git_depth" {
  type        = number
  description = "Default number of revisions for shallow cloning."

  nullable = false
  default  = 20
}

variable "settings_ci_delete_pipelines_in_seconds" {
  type        = number
  description = <<-EOM
  Pipelines older than the configured time are deleted.
  EOM

  nullable = false
  default  = 30 * 24 * 3600 # 30 days
}

variable "settings_ci_forward_deployment_enabled" {
  type        = bool
  description = <<-EOM
  When a new deployment job starts, skip older deployment jobs that are still
  pending.
  EOM

  nullable = false
  default  = true
}

variable "settings_ci_forward_deployment_rollback_allowed" {
  type        = bool
  description = <<-EOM
  Allow job retries even if the deployment job is outdated.
  EOM

  nullable = false
  default  = false
}

variable "settings_ci_id_token_sub_claim_components" {
  type        = list(string)
  description = <<-EOM
  Fields included in the sub claim of the ID Token. Accepts an array starting
  with project_path. The array might also include ref_type and ref. Defaults to
  ["project_path", "ref_type", "ref"]. Introduced in GitLab 17.10.
  EOM

  default = null
}

variable "settings_ci_pipeline_variables_minimum_override_role" {

  type        = string
  description = <<-EOM
  The minimum role required to set variables when running pipelines and jobs.
  Introduced in GitLab 17.1. Valid values are developer, maintainer, owner,
  no_one_allowed
  EOM

  nullable = false
  default  = "maintainer"
}

variable "settings_ci_push_repository_for_job_token_allowed" {
  type        = bool
  description = <<-EOM
  Allow Git push requests to your project repository that are authenticated with
  a CI/CD job token.
  EOM

  nullable = false
  default  = false
}

variable "settings_ci_restrict_pipeline_cancellation_role" {
  type        = string
  description = <<-EOM
  The role required to cancel a pipeline or job. Valid values are `developer`,
  `maintainer`, `no one`.

  Note: Introduced in GitLab 16.8. Premium and Ultimate only.
  EOM

  default = null
}

variable "settings_ci_separated_caches" {
  type        = bool
  description = "Use separate caches for protected branches."

  nullable = false
  default  = true
}

variable "settings_container_expiration_policy" {
  # Key is only a human readable identifier
  type = map(object({
    enabled      = optional(bool, true)
    cadence      = optional(string, "1d")
    keep_n       = optional(string)
    regex_delete = optional(string)
    regex_keep   = optional(string)
    older_than   = optional(string)
  }))

  description = <<-EOM
  Map of object, where key is just a human readable identifier, to set the image
  cleanup policy for this project. Objects support following attributes:

  * `enabled`: Boolean, optional, if true, the policy is enabled. Default to
    `true`.
  * `cadence`: String, optional, the cadence of the policy. Valid values are:
    `1d`, `7d`, `14d`, `1month`, `3month`. Default to `1d`.
  * `keep_n`: Number, optional, the number of image to keep. Valid values are:
    `1`, `5`, `10`, `25`, `50`, `100`. Default to `null`.
  * `regex_delete`: String, optional, the regular expression to match image
    names to delete. Default to `null`.
  * `regex_keep`: String, optional, the regular expression to match image
    names to keep. Default to `null`.
  * `older_than`: String, optional, the number of days to keep images. Valid
    values are: `7d`, `14d`, `30d`, `90d`. Default to `null`.

  Note: this field is sometimes named `container_expiration_policy_attributes`
  in the GitLab Upstream API.
  EOM

  nullable = false
  default  = {}
}

variable "settings_container_registry_access_level" {
  type        = string
  description = <<-EOM
  Set visibility of container registry, for this project. Valid values are
  `disabled`, `private`, `enabled`.
  EOM

  nullable = false
  default  = "disabled"
}

variable "settings_emails_enabled" {
  type        = bool
  description = "Enable email notifications."

  nullable = false
  default  = false
}

variable "settings_environments_access_level" {
  type        = string
  description = <<-EOM
  Set the environments access level. Valid values are `disabled`, `private`,
  `enabled`.
  EOM

  nullable = false
  default  = "disabled"
}

variable "settings_external_authorization_classification_label" {
  type        = string
  description = "The classification label for the project."

  default = null
}

variable "settings_feature_flags_access_level" {
  type        = string
  description = <<-EOM
  Set the feature flags access level. Valid values are `disabled`, `private`,
  `enabled`.
  EOM

  nullable = false
  default  = "disabled"
}

variable "settings_forking_access_level" {
  type        = string
  description = <<-EOM
  Set the forking access level. Valid values are `disabled`, `private`, `enabled`.
  EOM

  nullable = false
  default  = "disabled"
}

variable "settings_group_runners_enabled" {
  type        = bool
  description = "Enable group runners for this project."

  nullable = false
  default  = false
}

variable "settings_use_custom_template" {
  type        = bool
  description = <<-EOM
  Use either custom instance or group (with
  `settings_group_with_project_templates_id`, project template (enterprise
  edition).

  ~> When using a custom template, Group Tokens won't work. You must use a real
  user's Personal Access Token.
  EOM

  default = null
}


variable "settings_group_with_project_templates_id" {
  type        = number
  description = <<-EOM
  For group-level custom templates, specifies ID of group from which all the
  custom project templates are sourced.

  Leave empty for instance-level templates.

  Requires `settings_use_custom_template` to be true (enterprise edition).
  EOM

  default = null
}

variable "settings_infrastructure_access_level" {
  type        = string
  description = <<-EOM
  Set the infrastructure access level. Valid values are `disabled`, `private`,
  `enabled`.
  EOM

  nullable = false
  default  = "disabled"
}

variable "settings_initialize_with_readme" {
  type        = bool
  description = <<-EOM
  Create main branch with first commit containing a README.md file.

  Must be set to `true` if importing an uninitialized project with a different
  `settings_default_branch`.
  EOM

  nullable = false
  default  = false
}

variable "settings_issues_access_level" {
  type        = string
  description = <<-EOM
  Set the issues access level. Valid values are `disabled`, `private`, `enabled`.
  EOM

  nullable = false
  default  = "disabled"
}

variable "settings_issues_template" {
  type        = string
  description = "Sets the template for new issues in the project."

  default = null
}

variable "settings_keep_latest_artifact" {
  type        = bool
  description = <<-EOM
  Disable or enable the ability to keep the latest artifact for this project.
  EOM

  nullable = false
  default  = false
}

variable "settings_lfs_enabled" {
  type        = bool
  description = "Enable LFS for the project."

  nullable = false
  default  = false
}

variable "settings_merge_commit_template" {
  type        = string
  description = <<-EOM
  Template used to create merge commit message in merge requests.
  EOM

  nullable = false
  default  = <<-EOM
  %%{title} (%%{local_reference})

  %%{description}

  %%{issues}

  %%{reviewed_by}
  %%{approved_by}
  Merged-by: %%{merged_by}

  See merge request %%{url}
  EOM
}

variable "settings_merge_method" {
  type        = string
  description = <<-EOM
  Set the merge method. Valid values are `merge`, `rebase_merge`, `ff`.
  EOM

  nullable = false
  default  = "rebase_merge"
}

variable "settings_merge_pipelines_enabled" {
  type        = bool
  description = "Enable or disable merge pipelines."

  nullable = false
  default  = false
}

variable "settings_merge_requests_access_level" {
  type        = string
  description = <<-EOM
  Set the merge requests access level. Valid values are `disabled`, `private`,
  `enabled`.
  EOM

  nullable = false
  default  = "disabled"
}

variable "settings_merge_requests_template" {
  type        = string
  description = "Sets the template for new merge requests in the project."

  default = null
}

variable "settings_merge_trains_enabled" {
  type        = bool
  description = <<-EOM
  Enable or disable merge trains.

  Requires `settings_merge_pipelines_enabled` to be set to `true` to take effect.
  EOM

  nullable = false
  default  = false
}

variable "settings_model_experiments_access_level" {
  type        = string
  description = <<-EOM
  Set visibility of machine learning model experiments. Valid values are
  disabled, private, enabled.
  EOM

  nullable = false
  default  = "disabled"
}

variable "settings_model_registry_access_level" {
  type        = string
  description = <<-EOM
  Set visibility of machine learning model registry. Valid values are disabled,
  private, enabled.
  EOM

  nullable = false
  default  = "disabled"
}

variable "settings_monitor_access_level" {
  type        = string
  description = <<-EOM
  Set the monitor access level. Valid values are `disabled`, `private`, `enabled`.
  EOM

  nullable = false
  default  = "disabled"
}

variable "settings_only_allow_merge_if_all_discussions_are_resolved" {
  type        = bool
  description = <<-EOM
  Set to `true` if you want allow merges only if all discussions are resolved.
  EOM

  nullable = false
  default  = true
}

variable "settings_only_allow_merge_if_pipeline_succeeds" {
  type        = bool
  description = <<-EOM
  Set to `false` if you allow merges if a pipeline fails.
  EOM

  nullable = false
  default  = true
}

variable "settings_packages_enabled" {
  type        = bool
  description = "Enable packages repository for the project."

  nullable = false
  default  = false
}

variable "settings_pages_access_level" {
  type        = string
  description = <<-EOM
  Enable pages access control. Valid values are `public`, `private`, `enabled`,
  `disabled`.
  EOM

  nullable = false
  default  = "disabled"
}

variable "settings_printing_merge_request_link_enabled" {
  type        = bool
  description = <<-EOM
  Show/Hide link to create/view merge request when pushing from the command line
  EOM

  nullable = false
  default  = true
}

variable "settings_public_jobs" {
  type        = bool
  description = "If true, jobs can be viewed by non-project members."

  nullable = false
  default  = false
}

variable "settings_releases_access_level" {
  type        = string
  description = <<-EOM
  Set the releases access level. Valid values are `disabled`, `private`, `enabled`.
  EOM

  nullable = false
  default  = "disabled"
}

variable "settings_remove_source_branch_after_merge" {
  type        = bool
  description = <<-EOM
  Enable Delete source branch option by default for all new merge requests.
  EOM

  nullable = false
  default  = true
}

variable "settings_repository_access_level" {
  type        = string
  description = <<-EOM
  Set the repository access level. Valid values are `disabled`, `private`, `enabled`.
  EOM

  nullable = false
  default  = "private"
}

variable "settings_repository_storage" {
  type        = string
  description = <<-EOM
  Which storage shard the repository is on. (administrator only)
  EOM

  default = null
}

variable "settings_request_access_enabled" {
  type        = bool
  description = "Allow users to request member access."

  nullable = false
  default  = false
}

variable "settings_requirements_access_level" {
  type        = string
  description = <<-EOM
  Set the requirements access level. Valid values are `disabled`, `private`, `enabled`.
  EOM

  default = null
}

variable "settings_resolve_outdated_diff_discussions" {
  type        = bool
  description = <<-EOM
  Automatically resolve merge request diffs discussions on lines changed with a push.
  EOM

  nullable = false
  default  = false
}

variable "settings_security_and_compliance_access_level" {
  type        = string
  description = <<-EOM
  Set the security and compliance access level. Valid values are `disabled`,
  `private`, `enabled`.
  EOM

  nullable = false
  default  = "disabled"
}

variable "settings_shared_runners_enabled" {
  type        = bool
  description = "Enable shared runners for this project."

  nullable = false
  default  = false
}

variable "settings_skip_wait_for_default_branch_protection" {
  type        = bool
  description = <<-EOM
  If `true`, the default behavior to wait for the default branch protection to
  be created is skipped.

  This is necessary if the current user is not an admin and the default branch
  protection is disabled on an instance-level.

  There is currently no known way to determine if the default branch protection
  is disabled on an instance-level for non-admin users.

  This attribute is only used during resource creation, thus changes are
  suppressed and the attribute cannot be imported.
  EOM

  default = null
}

variable "settings_snippets_access_level" {
  type        = string
  description = <<-EOM
  Set the snippets access level. Valid values are `disabled`, `private`, `enabled`.
  EOM

  nullable = false
  default  = "disabled"
}

variable "settings_squash_commit_template" {
  type        = string
  description = <<-EOM
  Template used to create squash commit message in merge requests.
  EOM

  nullable = false
  default  = <<-EOM
  %%{title} (%%{local_reference})

  %%{description}

  %%{issues}

  %%{reviewed_by}
  %%{approved_by}
  Merged-by: %%{merged_by}

  See merge request %%{url}
  EOM
}

variable "settings_squash_option" {
  type        = string
  description = <<-EOM
  Squash commits when merge request. Valid values are `never`, `always`,
  `default_on`, or `default_off`.
  EOM

  nullable = false
  default  = "never"
}

variable "settings_suggestion_commit_message" {
  type        = string
  description = <<-EOM
  The commit message used to apply merge request suggestions.
  EOM

  default = null
}

variable "settings_template_name" {
  type        = string
  description = <<-EOM
  When used without `settings_use_custom_template`, name of a built-in project
  template. When used with `settings_use_custom_template`, name of a custom
  project template.

  This option is mutually exclusive with `settings_template_project_id`.
  EOM

  default = null
}

variable "settings_template_project_id" {
  type        = number
  description = <<-EOM
  When used with `settings_use_custom_template`, project ID of a custom project
  template.

  This is preferable to using `settings_template_name` since
  `settings_template_name` may be ambiguous (enterprise edition).

  This option is mutually exclusive with `settings_template_name`.

  See [gitlab_group_project_file_template](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group_project_file_template)
  to set a project as a template project.

  If a project has not been set as a template, using it here will result in an error.
  EOM

  default = null
}

variable "settings_timeouts" {
  type = object({
    create = string
    delete = string
  })
  description = <<-EOM
  Object with following attributes:

  * `create`: String
  * `delete`: String

  Note: At the time of writing, not so much information about this resource
  variable. See [Gitlab Project Resources - Timeouts](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project#timeouts)
  EOM

  default = null
}

variable "settings_topics" {
  type        = set(string)
  description = "The list of topics for the project."

  nullable = false
  default  = []
}

variable "settings_visibility_level" {
  type        = string
  description = <<-EOM
  Set to `public` to create a public project. Valid values are `private`,
  `internal`, `public`.
  EOM

  nullable = false
  default  = "private"
}

variable "settings_wiki_access_level" {
  type        = string
  description = <<-EOM
  Set the wiki access level. Valid values are `disabled`, `private`, `enabled`.
  EOM

  nullable = false
  default  = "disabled"
}

# Repository branch proection variables
# ------------------------------------------------------------------------
variable "branches_protection" {
  type = map(object({
    # Key is branch name
    allow_force_push             = optional(bool, false)
    code_owner_approval_required = optional(bool, false)
    merge_access_level           = optional(string, "maintainer")
    push_access_level            = optional(string, "no one")
    unprotect_access_level       = optional(string, "admin")
    allowed_to_merge = optional(object({
      user_id  = optional(set(number), [])
      group_id = optional(set(number), [])
    }), {})
    allowed_to_push = optional(object({
      user_id  = optional(set(number), [])
      group_id = optional(set(number), [])
    }), {})
    allowed_to_unprotect = optional(object({
      user_id  = optional(set(number), [])
      group_id = optional(set(number), [])
    }), {})
  }))

  description = <<-EOM
  Map of object, where the key is the branch name to protect and object is the
  branch protection configuration. The object support following attributes:

  * `allow_force_push`: Boolean, optional, Can be set to `true `to allow users
    with push access to force push. Default to `false`.
  * `code_owner_approval_required`: Boolean, optional, can be set to `true` to
    require code owner approval before merging. Default to `false`.

    NOTE: Only available for Premium and Ultimate instances.
  * `merge_access_level`: String, optional, access levels allowed to merge.
    Valid values are: `no one`, `developer`, `maintainer`. Default to
    `maintainer`
  * `allowed_to_merge`: Object, optional, sets of user(s)/group(s) allowed to
    merge to protected branch. Default to `null`. Object supports following
    attributes:
    * `group_id`: Set of number, optional, the IDs of GitLab groups allowed to
      perform the relevant action.
    * `user_id`: Set of number, optional, the IDs of GitLab users allowed to
      perform the relevant action.
  * `push_access_level`: String, optional, access levels allowed to push. Valid
    values are: `no one`, `developer`, `maintainer`. Default to `no one` forcing
    to pass through merge request.
  * `allowed_to_push`: Object, optional, sets of user(s)/group(s) allowed to
    push to protected branch. Default to `null`. Object supports following
    attributes:
    * `group_id`: Set of number, optional, the IDs of GitLab groups allowed to
      perform the relevant action.
    * `user_id`: Set of number, optional, the IDs of GitLab users allowed to
      perform the relevant action.
  * `unprotect_access_level`: String, optional, access levels allowed to
    unprotect. Valid values are: `developer`, `maintainer`, `admin`. Default to
    `admin`.
  * `allowed_to_unprotect`: Object, optional, sets of user(s)/group(s) allowed to
    unprotect protected branch. Default to `null`. Object supports following
    attributes:
    * `group_id`: Set of number, optional, the IDs of GitLab groups allowed to
      perform the relevant action.
    * `user_id`: Set of number, optional, the IDs of GitLab users allowed to
      perform the relevant action.
  EOM

  nullable = false
  default  = {}
}

# Repository tag proection variables
# ------------------------------------------------------------------------
variable "tags_protection" {
  # Key is the tag to protect
  type = map(object({
    create_access_level = optional(string, "maintainer")
    allowed_to_create = optional(object({
      user_id  = optional(set(number), [])
      group_id = optional(set(number), [])
    }), {})
  }))
  description = <<-EOM
  Map of object, where the key is the tag to be protected. Object support
  following attributes:

  * `create_access_level`: String, optional, access levels allowed to create.
    Default value of `maintainer`.

    The default value is always sent if not provided in the configuration.
    Valid values are: `no one`, `developer`, `maintainer`.
  * `allowed_to_create`: Object configuring tag protection rules. The object
    support following attributes:
    * `group_id`: Number, optional, List of Gitlab groups IDs allowed to
      perform the relevant action.
    * `user_id`: Number, optional, List of Gitlab users IDs allowed to
      perform the relevant action.
  EOM

  nullable = false
  default  = {}
}

# Repository labels variables
# ------------------------------------------------------------------------
variable "labels" {
  # Key is the label name
  type = map(object({
    color       = string
    description = string
  }))
  description = <<-EOM
  Map of objects, where key is the label name and the object describe the lable.
  Object support the following attributes:

  * `color`: String, the color of the label given in 6-digit hex notation with
    leading '#' sign (e.g. #FFAABB) or one of the CSS color names.
  * `description`: String, the description of the label.
  EOM

  nullable = false
  default  = {}
}

# Repository access tokens variables
# ------------------------------------------------------------------------
variable "access_tokens" {
  # Key is access token name
  type = map(object({
    scopes       = set(string)
    expires_at   = optional(string)
    access_level = optional(string, "no one")
    description  = string
    rotation_configuration = optional(object({
      expiration_days    = number
      rotate_before_days = number
    }), null)
    ci_variable = optional(object({
      description       = string
      name              = optional(string, null)
      environment_scope = optional(string, "*")
      hidden            = optional(bool, false)
      masked            = optional(bool, false)
      protected         = optional(bool, false)
      raw               = optional(bool, false)
      variable_type     = optional(string, "env_var")
    }), null)
  }))
  description = <<-EOM
  Map of object, where key is the name of the access token. Object describe
  access tokens, and if need, set it as CI variable. Object support following
  attributes:

  * `scopes`: Set of string, the scopes of the project access token.
    Valid values are: `api`, `read_api`, `read_registry`, `write_registry`,
    `read_repository`, `write_repository`, `create_runner`, `manage_runner`,
    `ai_features`, `k8s_proxy`, `read_observability`, `write_observability`.
  * `expires_at`: String, when the token will expire, YYYY-MM-DD format.
    Is automatically set when `rotation_configuration` is used.
  * `access_level`: String, optional, the access level for the project access
    token. Valid values are: `no one`, `minimal`, `guest`, `reporter`,
    `developer`, `maintainer`, `owner`. Default is `no one`.
  * `rotation_configuration`: Object, the configuration for when to rotate a
    token automatically. Will not rotate a token until terraform apply is run.
    Default to `null`. Object support following attributes:
    * `expiration_days`: Number, the duration (in days) the new token should be
      valid for.
    * `rotate_before_days`: Number, The duration (in days) before the expiration
      when the token should be rotated. As an example, if set to 7 days, the
      token will rotate 7 days before the expiration date, but only when
      terraform apply is run in that timeframe.
  * `ci_variable`: Object, optional, that expose the access token as CI
    variable. Default to `null`. Object support following attributes:
    * `value`: String, the value of the variable.
    * `description`: String, the description of the variable.
    * `environment_scope`: String, optional, the environment scope of the variable.
      Defaults to all environment `*`.

      Note: In Community Editions of Gitlab, values other than * will cause
      inconsistent plans.
    * `hidden`: Boolean, optional, if set to `true`, the value of the variable
      will be hidden in repository CI variables. The value must meet the
      hidden requirements. Defaults to `false`.
    * `masked`: Boolean, optional, if set to `true`, the value of the variable
      will be hidden in job logs. The value must meet the masking requirements.
      Defaults to `false`.
    * `protected`: Boolea, optional, if set to `true`, the variable will be passed
      only to pipelines running on protected branches and tags. Defaults to `false`.
    * `raw`: Boolean, optional, whether the variable is treated as a raw string.
      When `true`, variables in the value are not expanded. Default to `false`.
    * `variable_type`: String, optional, the type of a variable.
      Valid values are: `env_var, :`file`. Default is `env_var`.
  EOM

  nullable = false
  default  = {}
}

# Repository CI variable variables
# ------------------------------------------------------------------------
variable "variables" {
  # Key is the variable key/name
  type = map(object({
    value             = string
    description       = string
    environment_scope = optional(string, "*")
    hidden            = optional(bool, false)
    masked            = optional(bool, false)
    protected         = optional(bool, false)
    raw               = optional(bool, false)
    variable_type     = optional(string, "env_var")
  }))

  description = <<-EOM
  Map of object, where key is the variables key/name. Object describes variable
  and support following attributes:

  * `value`: String, the value of the variable.
  * `description`: String, the description of the variable.
  * `environment_scope`: String, optional, the environment scope of the variable.
    Defaults to all environment `*`.

    Note: In Community Editions of Gitlab, values other than * will cause
    inconsistent plans.
  * `hidden`: Boolean, optional, if set to `true`, the value of the variable
    will be hidden in repository CI variables. The value must meet the
    hidden requirements. Defaults to `false`.
  * `masked`: Boolean, optional, if set to `true`, the value of the variable
    will be hidden in job logs. The value must meet the masking requirements.
    Defaults to `false`.
  * `protected`: Boolea, optional, if set to `true`, the variable will be passed
    only to pipelines running on protected branches and tags. Defaults to `false`.
  * `raw`: Boolean, optional, whether the variable is treated as a raw string.
    When `true`, variables in the value are not expanded. Default to `false`.
  * `variable_type`: String, optional, the type of a variable.
    Valid values are: `env_var, :`file`. Default is `env_var`.
  EOM

  nullable = false
  default  = {}
}

# Repository mirroring variables
# ------------------------------------------------------------------------
variable "mirrors" {
  # Key is just a human readable identifier
  type = map(object({
    url                     = string
    enabled                 = optional(bool, true)
    keep_divergent_refs     = optional(bool, false)
    only_protected_branches = optional(bool, true)
  }))
  description = <<-EOM
  Map of object, where key is just a human readable identifier. Object support
  the following attributes:

  * `url`: String, sensitive, the URL of the remote repository to be mirrored.
  * `enabled`: Boolean, optional, determines if the mirror is enabled. Default
    to `true`.
  * `keep_divergent_refs`: Boolean, optional, determines if divergent refs are
    skipped. Default to `false`.
  * `only_protected_branches`: Boolean, optional, determines if only protected
    branches are mirrored. Default to `true`.
  EOM

  nullable = false
  default  = {}
}

# Repository hooks variables
# ------------------------------------------------------------------------
variable "hooks" {
  # Key is just a human readable identifier
  type = map(object({
    url                        = string
    token                      = optional(string)
    custom_webhook_template    = optional(string)
    confidential_issues_events = optional(bool, false)
    confidential_note_events   = optional(bool, false)
    deployment_events          = optional(bool, false)
    enable_ssl_verification    = optional(bool, true)
    issues_events              = optional(bool, false)
    job_events                 = optional(bool, false)
    merge_requests_events      = optional(bool, false)
    note_events                = optional(bool, false)
    pipeline_events            = optional(bool, false)
    push_events                = optional(bool, false)
    push_events_branch_filter  = optional(string)
    releases_events            = optional(bool, false)
    tag_push_events            = optional(bool, false)
    wiki_page_events           = optional(bool, false)
  }))

  description = <<-EOM
  Map of object, where key is only a human readable identifier. Object support
  following attributes:

  * `url`: String, the url of the hook to invoke.
  * `token`: String, optional, a token to present when invoking the hook.
    The token is not available for imported resources. Default to `null`.
  * `confidential_issues_events`: Boolean, optional, invoke the hook for
    confidential issues events. Default to `false`.
  * `confidential_note_events`: Boolean, optional, invoke the hook for
    confidential notes events. Default to `false`.
  * `custom_webhook_template`: String, optional, set a custom webhook template.
    Default to `false`.
  * `deployment_events`: Boolean, optional, invoke the hook for deployment events.
    Default to `false`.
  * `enable_ssl_verification`: Boolean, optional, enable ssl verification when
    invoking the hook. Default to `false`.
  * `issues_events`: Boolean, optional, invoke the hook for issues events.
    Default to `false`.
  * `job_events`: Boolean, optional, invoke the hook for job events.
    Default to `false`.
  * `merge_requests_events`: Boolean, optional, invoke the hook for merge
    requests. Default to `false`.
  * `note_events`: Boolean, optional, invoke the hook for notes events.
    Default to `false`.
  * `pipeline_events`: Boolean, optional, invoke the hook for pipeline events.
    Default to `false`.
  * `push_events`: Boolean, optional, invoke the hook for push events.
    Default to `false`.
  * `push_events_branch_filter`: String, optional, invoke the hook for push
    events on matching branches only. Default to `null`.
  * `releases_events`: Boolean, optional, invoke the hook for releases events.
    Default to `false`.
  * `tag_push_events`: Boolean, optional, invoke the hook for tag push events.
    Default to `false`.
  * `wiki_page_events`: Boolean, optional, invoke the hook for wiki page events.
    Default to `false`.
  EOM

  nullable = false
  default  = {}
}

# Repository badges variables
# ------------------------------------------------------------------------
variable "badges" {
  # Key is badges names
  type = map(object({
    image_url = string
    link_url  = string
  }))
  description = <<-EOM
  Map of object, where key is the badges name and object describces repo badges.
  Object support following attributes:

  * `image_url`: String, the image url which will be presented on project overview.
  * `link_url`: String, the url linked with the badge.
  EOM

  nullable = false
  default  = {}
}

# Repository custom attributes variables
# ------------------------------------------------------------------------
variable "custom_attributes" {
  type        = map(string)
  description = "Map of string representing key/values of custom attributes."


  nullable = false
  default  = {}
}

# Repository mr level approuval variables
# ------------------------------------------------------------------------
variable "level_mr_approval" {
  type = object({
    enabled                                        = bool
    disable_overriding_approvers_per_merge_request = optional(bool, false)
    merge_requests_author_approval                 = optional(bool, false)
    merge_requests_disable_committers_approval     = optional(bool, true)
    require_password_to_approve                    = optional(bool, false)
    reset_approvals_on_push                        = optional(bool, false)
    selective_code_owner_removals                  = optional(bool, true)
  })
  description = <<-EOM
  Map of object, where key is just an human readable identifier. Object support
  following attributes:

  * `disable_overriding_approvers_per_merge_request`: Boolean, optional, set to
    `true` to disable overriding approvers per merge request. Default to `false`.
  * `merge_requests_author_approval`: Boolean, optional, set to `true` to allow
    merge requests authors to approve their own merge requests. Default to `false`.
  * `merge_requests_disable_committers_approval`: Boolean, optional, set to
    `false` to allow merge request committers from approving their own merge
    requests. Default to `true`.
  * `require_password_to_approve`: Boolean, optional, set to `true` to require
    authentication to approve merge requests. Default to `false`.
  * `reset_approvals_on_push`: Boolean, optional, set to `true` to remove all
    approvals in a merge request when new commits are pushed to its source branch.
    Default to `true`.
  * `selective_code_owner_removals`: Boolean, optional, reset approvals from
    Code Owners if their files changed. Can be enabled only if
   `reset_approvals_on_push` is disabled. Default to `true`.

  NOTE: This resource requires a GitLab Enterprise instance.
  EOM

  nullable = false
  default = {
    enabled = false
  }
}

# Repository level notifications variables
# ------------------------------------------------------------------------
variable "preset_level_notifications" {
  type        = set(string)
  description = <<-EOM
  Set of String, level of the notification. Valid values are: `disabled`,
  `participating`, `watch`, `global`, `mention`.

  If you want to set custom level notification, see `custom_level_notifications`.
  EOM

  nullable = false
  default  = []
}

variable "custom_level_notifications" {
  # Key is just a human readable identifier
  type = map(object({
    close_issue                  = optional(bool, false)
    close_merge_request          = optional(bool, false)
    failed_pipeline              = optional(bool, false)
    fixed_pipeline               = optional(bool, false)
    issue_due                    = optional(bool, false)
    merge_merge_request          = optional(bool, false)
    merge_when_pipeline_succeeds = optional(bool, false)
    moved_project                = optional(bool, false)
    new_issue                    = optional(bool, false)
    new_merge_request            = optional(bool, false)
    new_note                     = optional(bool, false)
    push_to_merge_request        = optional(bool, false)
    reassign_issue               = optional(bool, false)
    reassign_merge_request       = optional(bool, false)
    reopen_issue                 = optional(bool, false)
    reopen_merge_request         = optional(bool, false)
    success_pipeline             = optional(bool, false)
  }))
  description = <<-EOM
  Map of object, where key is just a human readable identifier and object allow
  setting custom level notification. Object support following attributes:

  * `close_issue`: Boolean, optional, enable notifications for closed issues.
    Can only be used when level is `custom`. Default to `false`.
  * `close_merge_request`: Boolean, optional, enable notifications for closed
    merge requests. Can only be used when level is `custom`. Default to `false`.
  * `failed_pipeline`: Boolean, optional, enable notifications for failed
    pipelines. Can only be used when level is `custom`. Default to `false`.
  * `fixed_pipeline`: Boolean, optional, enable notifications for fixed
    pipelines. Can only be used when level is `custom`. Default to `false`.
  * `issue_due`: Boolean, optional, enable notifications for due issues. Can
    only be used when level is `custom`. Default to `false`.
  * `merge_merge_request`: Boolean, optional, enable notifications for merged
    merge requests. Can only be used when level is `custom`. Default to `false`.
  * `merge_when_pipeline_succeeds`: Boolean, optional, enable notifications for
    merged merge requests when the pipeline succeeds. Can only be used when
    level is `custom`. Default to `false`.
  * `moved_project`: Boolean, optional, enable notifications for moved projects.
    Can only be used when level is `custom`. Default to `false`.
  * `new_issue`: Boolean, optional, enable notifications for new issues. Can
    only be used when level is `custom`. Default to `false`.
  * `new_merge_request`: Boolean, optional, enable notifications for new merge
    requests. Can only be used when level is `custom`. Default to `false`.
  * `new_note`: Boolean, optional, enable notifications for new notes on merge
    requests. Can only be used when level is `custom`. Default to `false`.
  * `push_to_merge_request`: Boolean, optional, enable notifications for push to
    merge request branches. Can only be used when level is `custom`.
    Default to `false`.
  * `reassign_issue`: Boolean, optional, enable notifications for issue
    reassignments. Can only be used when level is `custom`. Default to `false`.
  * `reassign_merge_request`: Boolean, optional, enable notifications for merge
    request reassignments. Can only be used when level is `custom`.
    Default to `false`.
  * `reopen_issue`: Boolean, optional, enable notifications for reopened issues.
    Can only be used when level is `custom`. Default to `false`.
  * `reopen_merge_request`: Boolean, optional, enable notifications for reopened
    merge requests. Can only be used when level is `custom`. Default to `false`.
  * `success_pipeline`: Boolean, optional, Enable notifications for successful
    pipelines. Can only be used when level is `custom`. Default to `false`.
  EOM

  nullable = false
  default  = {}
}

# Repository deloy SSH keys
# ------------------------------------------------------------------------
variable "deploy_keys" {
  type = map(object({
    key      = string
    can_push = optional(bool, false)
  }))
  description = <<-EOM
  Map of object, where the key is the title of the key and object support
  following attributes:
  * `key`: String, content of the public SSH key allow to deploy git repository.
  * `can_push`: Boolean, allow this deploy key to be used to push changes to the
    project.
  EOM

  nullable = false
  default  = {}
}

# Repository deloy token
# ------------------------------------------------------------------------
variable "deploy_tokens" {
  type = map(object({
    scopes     = set(string)
    expires_at = optional(string, null)
    username   = optional(string, null)
  }))
  description = <<-EOM
  Map of object, where the key is the title name of the token and object support
  following attributes:
  * `scopes`: Set of String, scope access for the token, valid values:
    read_repository, read_registry, read_package_registry, write_registry,
    write_package_registry.
  * `expires_at`: String, optional, time the token will expire it, RFC3339
    format. Will not expire per default.
  * `username`: String, optional, a username for the deploy token. Default is
    gitlab+deploy-token-{n}.
  EOM

  nullable = false
  default  = {}
}
