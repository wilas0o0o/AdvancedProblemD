class SearchesController < ApplicationController
  before_action :authenticate_user!
  def search
    @content = params[:content]
    @records = Book.search_for(@content)
    @book = Book.new
  end
  
end
