class AuthorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    authors = Author.all 
    render json: authors.to_json(only: [:name], include: [profile: {only: [:username, :email, :bio, :avatar_url]}])
  end

  def show
    author = Author.find(params[:id])
    render json: author, serializer: AuthorSerializer
  end

  private

  def render_not_found_response
    render json: { error: "Author not found" }, status: :not_found
  end

end
