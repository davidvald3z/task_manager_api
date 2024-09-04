module Api
    module V1
      class BranchesController < ApplicationController
        before_action :set_branch, only: %i[show update destroy]
  
        def index
          @branches = Branch.all.order(:name)
          render json: @branches
        end
  
        def show
          render json: @branch
        end
  
        def create
          @branch = Branch.new(branch_params)
          if @branch.save
            render json: @branch, status: :created
          else
            render json: @branch.errors, status: :unprocessable_entity
          end
        end
  
        def update
          if @branch.update(branch_params)
            render json: @branch
          else
            render json: @branch.errors, status: :unprocessable_entity
          end
        end
  
        def destroy
          @branch.destroy
          head :no_content
        end
  
        private
  
        def set_branch
          @branch = Branch.find(params[:id])
        end
  
        def branch_params
          params.permit(:name, :address, :city, :state, :zip_code)
        end
      end
    end
  end
  