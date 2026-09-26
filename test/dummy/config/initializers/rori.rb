Rori.configure do |rori|
  rori.app_name = "Dummy"
  rori.records = %w[ Note Folder ]
  rori.hover_keys = true

  rori.command :recount_notes, confirm: true do
    RecountNotesJob.perform_later
    I18n.t("recount_notes.started")
  end
end
