class FoldersController < ApplicationController
  def show
    @folder = Folder.find(params.expect(:id))
  end
end
