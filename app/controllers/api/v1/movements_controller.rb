module Api
    module V1
      class MovementsController < ApplicationController
        before_action :set_movement, only: %i[show update destroy]
  
        def index
            if params[:type] == 'sales'
              @movements = Movement.sales.includes(:branch).order(movement_date: :desc).limit(50)
            elsif params[:type] == 'expenses'
              @movements = Movement.expenses.includes(:branch).order(movement_date: :desc).limit(50)
            else
              @movements = Movement.includes(:branch).all.order(movement_date: :desc).limit(50)
            end
            render json: @movements.as_json(include: { branch: { only: :name } })
        end
          
  
        def show
          render json: @movement
        end
  
        def create
          @movement = Movement.new(movement_params)
          if @movement.save
            render json: @movement.as_json(include: :branch), status: :created
          else
            render json: @movement.errors, status: :unprocessable_entity
          end
        end
  
        def update
          if @movement.update(movement_params)
            render json: @movement.as_json(include: :branch)
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
          params.permit(:movement_type, :description, :amount, :active, :movement_date, :branch_id)
        end
      end
    end
  end
  
