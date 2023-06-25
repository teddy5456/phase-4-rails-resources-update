class BirdsController < ApplicationController
  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # GET /birds/:id
  def show
    bird = Bird.find_by(id: params[:id])
    if bird
      render json: bird
    else
      render json: { error: 'Bird not found' }, status: :not_found
    end
  end

  # POST /birds
  def create
    bird = Bird.new(bird_params)
    if bird.save
      render json: bird, status: :created
    else
      render json: bird.errors, status: :unprocessable_entity
    end
  end

  # PATCH /birds/:id
  def update
    bird = Bird.find_by(id: params[:id])
    if bird
      bird.update(bird_params)
      render json: bird
    else
      render json: { error: 'Bird not found' }, status: :not_found
    end
  end

  # PATCH /birds/:id/like
  def increment_likes
    bird = Bird.find_by(id: params[:id])
    if bird
      bird.update(likes: bird.likes + 1)
      render json: bird
    else
      render json: { error: 'Bird not found' }, status: :not_found
    end
  end

  private

  def bird_params
    params.permit(:name, :species, :likes)
  end
end
