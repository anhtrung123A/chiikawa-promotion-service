class Api::V1::PromotionsController < ApplicationController
  def apply_promotion
    promotion_code = params[:promotion_code]
    if !promotion_code
      render json: { error: "promotion code not provided" }, status: :bad_request
      return
    end
    promotion = Promotion.includes(:user).find_by(code: promotion_code)
    if promotion == nil
      render json: { error: "promotion not found" }, status: :not_found
      return
    end
    if promotion.user.id != current_user.id
      render json: { error: "you are not allowed to use this code" }, status: :unauthorized
      nil
    else
      if promotion_code == promotion.code
        if promotion.is_expired
          render json: { error: "promotion has expired" }, status: :bad_request
          return
        elsif promotion.is_used
          render json: { error: "promotion has been used" }, status: :bad_request
          return
        end
        render json: { message: "success" }, status: :ok
        promotion.update(is_used: true)
        nil
      else
        render json: { error: "code is invalid" }, status: :bad_request
        nil
      end
    end
  end
end
