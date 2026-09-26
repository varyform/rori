Rails.application.configure do
  config.enable_reloading = true
  config.eager_load = false

  config.consider_all_requests_local = true
  config.cache_store = :null_store
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load

  config.i18n.raise_on_missing_translations = true
end
