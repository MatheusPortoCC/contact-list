class ContactsController < ApplicationController
  before_action :set_authorization
  before_action :set_contacts, only: [:index, :show, :update, :destroy]
  before_action :set_contact, only: [:show, :update, :destroy], unless: -> { contact_params[:id].nil? }
  
  def index
    if @contacts
      render json: { contacts: @contacts }, status: :ok
    else
      render json: { message: 'Contacts not found' }, status: :unauthorized
    end
  end
  
  def show
    if @contact
      render json: { contact: @contact }, status: :ok
    else
      render json: { message: 'Contact not found' }, status: :unauthorized
    end
  end

  def create
    contact = Contact.new(contact_params)
    contact.user = @user

    if contact.save
      render json: { contact: contact }, status: :ok
    else
      render json: { error: contact.errors }, status: :ok
    end
  end


  def update
    if @contact.update(contact_params)
      render json: { message: 'Contact successfully updated' }, status: :ok
    else
      render json: { message: 'Contact was not successfully updated' }, status: :ok
    end
  end

  def destroy
    if @contact.destroy
      render json: { message: 'Contact successfully deleted' }, status: :ok
    else
      render json: { message: 'Contact was not successfully deleted' }, status: :ok
    end
  end

  private
    def set_contact
      @contact = @contacts.find(contact_params[:id])
    end

    def set_contacts
      @contacts = @user.contacts
    end

    def contact_params
      params.permit(
        :id,
        :name,
        :email,
        :city,
        :state,
        :country,
        :phone,
        :relationship
      )
    end
end
