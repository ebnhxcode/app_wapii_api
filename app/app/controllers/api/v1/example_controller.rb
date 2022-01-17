module Api
  module V1

    class ExampleController < ApplicationController
      before_action :authorize_access_request!

      before_action :set_example, only: [:show, :update, :destroy]

      # GET /examples
      def index
        @examples = current_user.examples.all

        render json: @examples
      end

      # GET /examples/1
      def show
        render json: @example
      end

      # POST /examples
      def create
        @example = current_user.examples.build(example_params)

        if @example.save
          render json: @example, status: :created, location: @example
        else
          render json: @example.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /examples/1
      def update
        if @example.update(example_params)
          render json: @example
        else
          render json: @example.errors, status: :unprocessable_entity
        end
      end

      # DELETE /examples/1
      def destroy
        @example.destroy
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_example
        @example = current_user.examples.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def example_params
        params.require(:example).permit(:title, :year, :artist_id)
      end

    end

  end
end
