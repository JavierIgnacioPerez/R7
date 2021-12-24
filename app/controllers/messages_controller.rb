class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]
  before_action :set_user

  # GET /messages or /messages.json
  def index
    @messages = Message.all.where(room_id: params['room_id']).order(created_at: :asc)    
    @system_message = SystemMessage.create( message: 'new connection', connections: ActionCable.server.connections.length ) if SystemMessage.first.blank?
    if SystemMessage.first.present?
      SystemMessage.first.update( connections: ActionCable.server.connections.length )
      @system_message = SystemMessage.first
    end
    @message = Message.new
  end

  # GET /messages/1 or /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
    puts '/////////////////////////'
    puts message_params.inspect
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.turbo_stream
        format.html { redirect_to message_url(@message), notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
      else
        format.turbo_stream
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.turbo_stream
        format.html { redirect_to message_url(@message), notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.turbo_stream
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      puts '///////////////////////////////'
      puts params.inspect
      params.require(:message).permit!
    end

    def set_user
      @user_email = cookies[:user_email] if cookies[:user_email].present?
      @user_name = cookies[:user_name] if cookies[:user_name].present?
    end
end
