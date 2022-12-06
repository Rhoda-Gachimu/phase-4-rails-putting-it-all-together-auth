class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def create 
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def show 
        user = User.find_by(id: session[:user_id])

        if user 
            render json: user, status: 201
        else 
            render json: {errors: "Not authorized"}, status: 401
        end

    end

    private

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end
end