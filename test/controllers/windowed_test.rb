require "test_helper"

# Rori::Windowed and Rori::WindowHelper through the host's own pages
# (the dummy's NotesController), as the demo's resource controller tests do.
class WindowedTest < ActionDispatch::IntegrationTest
  test "full page load renders the desk with the page as its first window" do
    get notes_path

    assert_response :success
    assert_select "main.rori-viewport .rori-floating > dialog.rori-win[open] turbo-frame#win_main[src=?][complete]", notes_path
    assert_equal "notes", window_meta(frame: "win_main")["key"]
    assert_select "title", "Notes"
  end

  test "index in a window asks for a large window keyed by controller" do
    get_in_window notes_path

    assert_response :success
    assert_select "main.rori-viewport", count: 0
    assert_equal({ "size" => "lg", "mode" => "tile", "key" => "notes", "title" => "Notes" }, window_meta)
    assert_select "a[href=?][data-turbo-frame=_top]", note_path(notes(:groceries))
  end

  test "show is titled after the note and shares the notes key" do
    get_in_window note_path(notes(:groceries))

    assert_equal({ "size" => "md", "mode" => "tile", "key" => "notes", "title" => "Groceries" }, window_meta)
  end

  test "new opens as an unkeyed modal" do
    get_in_window new_note_path

    assert_equal({ "size" => "sm", "mode" => "modal", "key" => nil, "title" => "New note" }, window_meta)
  end

  test "an explicit key overrides the controller's" do
    get_in_window folder_path(folders(:inbox))

    assert_equal [ "folder_#{folders(:inbox).id}", "Inbox" ], window_meta.values_at("key", "title")
  end
end
