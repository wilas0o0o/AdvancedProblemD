class SearchesController < ApplicationController
  def search
    @model = params["model"]
    @method = params["method"]
    @content = params["content"]
    @records = search_for(@model, @method, @content)
  end

  private
  def search_for(model, method, content)
    if model == "user"
      if method == "perfect"
        User.where(name: content)
      elsif method == "partial"
        User.where("name LIKE ?","%"+content+"%" )
      elsif method == "forward_match"
        User.where("name LIKE ?",content+"%" )
      elsif method == "backward_match"
        User.where("name LIKE ?","%"+content )
      end
    elsif model == "book"
      if method == "perfect"
        Book.where(title: content)
      elsif method == "partial"
        Book.where("title LIKE ?","%"+content+"%" )
      elsif method == "forward_match"
        Book.where("title LIKE ?",content+"%" )
      elsif method == "backward_match"
        Book.where("title LIKE ?","%"+content )
      end
    end
  end
end
