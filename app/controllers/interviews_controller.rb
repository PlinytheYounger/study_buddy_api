class InterviewsController < ApplicationController
  before_action :set_interview, only: [:show, :update, :destroy]

  # GET /interviews
  def index
    @interviews = Interview.all

    render json: @interviews
  end

  # POST /interviews
  def create
    @interview = Interview.new(interview_params)

    if @interview.save
      render json: @interview, status: :created
    else
      render json: @interview.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /interviews/1
  def update
    if @interview.update(interview_params)
      render json: @interview
    else
      render json: @interview.errors, status: :unprocessable_entity
    end
  end

  # DELETE /interviews/1
  def destroy
    @interview.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interview
      @interview = Interview.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def interview_params
      params.require(:interview).permit(:interview_type, :company_name, :interview_date, :user_id)
    end

end
