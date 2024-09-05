module Api
    module V1
      class MovementsController < ApplicationController
        before_action :set_movement, only: %i[show update destroy]
  
        def index
          @movements = Movement.all.order(:description)
          render json: @movements
        end
  
        def show
          render json: @movement
        end
  
        def create
          @movement = Movement.new(movement_params)
          if @movement.save
            render json: @movement, status: :created
          else
            render json: @movement.errors, status: :unprocessable_entity
          end
        end
  
        def update
          if @movement.update(movement_params)
            render json: @movement
          else
            render json: @movement.errors, status: :unprocessable_entity
          end
        end
  
        def destroy
          @movement.destroy
          head :no_content
        end
  
        private
  
        def set_movement
          @movement = Movement.find(params[:id])
        end
  
        def movement_params
          params.permit(:type, :description, :amount, :active)
        end
      end
    end
  end
  
