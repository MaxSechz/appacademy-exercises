class ContactsController < ApplicationController
  def index
    render json: Contact.where(user_id: params[:user_id])
  end

  def show
    @contact = Contact.where(user_id: params[:user_id], id: params[:id])
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
    @contact = Contact.where(user_id: params[:user_id], id: params[:id])
    @contact.update(contact_params)

    render json: @contact
  end

  def destroy
    @contact = Contact.where(user_id: params[:user_id], id: params[:id])
    @contact.destroy
    render json: @contact
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end
end
