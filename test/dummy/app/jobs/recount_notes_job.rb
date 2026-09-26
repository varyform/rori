# The work behind the `recount_notes` server-side command: notifies every open
# desk when it's done.
class RecountNotesJob < ActiveJob::Base
  def perform
    Rori.notify I18n.t("recount_notes.finished"), I18n.t("recount_notes.count", count: Note.count), kind: :success
  end
end
