class Admin::ParticipantsController < Admin::ApplicationController
  load_resource :camp
  load_and_authorize_resource through: :camp
  decorate_current_camp

  def index
    @participants = @participants.where(delegation_id: params[:delegation_id]) if params[:delegation_id]
  end

  def edit
  end

  def show
  end

  def update
    if @participant.update(update_params)
      redirect_to({action: :show}, notice: 'The participant is updated')
    else
      render :new
    end
  end

  def destroy
    @participant.destroy
    redirect_to({action: :index}, notice: 'The participant is removed')
  end

  private

    def create_params
      params.require(:participant).permit(:arrival, :departure, :preferences)
    end

    def update_params
      params.require(:participant).permit(:arrival, :departure, :delegation_id, :passport_scan, :tshirt, personal: PersonalData.attributes)
    end
end
