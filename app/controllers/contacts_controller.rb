class ContactsController < ApplicationController
  before_action :set_user
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = @user.contacts.all
  end  

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    set_contact
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
    4.times { @contact.phones.build }
  end

  # GET /contacts/1/edit
  def edit
    set_contact
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = @user.contacts.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to user_contacts_path(@user, @contact), notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to user_contacts_path(@user, @contact), notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to user_contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end 

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name, phones_attributes: [:number, :_destroy, :id])
    end    
end
