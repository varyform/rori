class NotesController < ApplicationController
  before_action :set_note, only: %i[ show edit ]

  def index
    @notes = Note.order(:title)
  end

  def show
  end

  def new
    @note = Note.new
  end

  def edit
  end

  private
    def set_note
      @note = Note.find(params.expect(:id))
    end
end
