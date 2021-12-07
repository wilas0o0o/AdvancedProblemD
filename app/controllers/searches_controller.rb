class SearchesController < ApplicationController
  before_action :authenticate_user!
  def search
    @model = params["model"]
    @method = params["method"]
    @content = params["content"]
    if @model == "user"
      @records = User.search_for(@method, @content)
    elsif @model == "book"
      @records = Book.search_for(@method, @content)
    end
  end
end
