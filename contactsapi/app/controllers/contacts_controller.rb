class ContactsController < ApplicationController
  def index
    full_contact = Contact.joins(:contact_shares)
                   .where("contact_shares.user_id = ? OR contacts.user_id = ?", params[:user_id], params[:user_id])
    render json: full_contact
  end

  def show
    @contact = Contact.where(id: params[:id])
    render json: @contact
  end

  def create
    print params
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact
    else
      render(
      json: @contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def update
    @contact = Contact.update(params[:id], contact_params)
    render json: @contact
  end

  def destroy
    @contact = Contact.where(id: params[:id])
    @contact.destroy
    render json: @contact
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end
end
