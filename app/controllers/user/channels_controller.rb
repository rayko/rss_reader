class User::ChannelsController < ApplicationController

  before_filter :authenticate_user!

  # GET /channels
  # GET /channels.json
  def index
    @channels = current_user.channels

    respond_to do |format|
      format.html
      format.json { render json: @channels }
    end
  end

  def list
    @channels = current_user.channels
    respond_to do |format|
      format.html { render :partial => 'list', :layout => false }
      format.json { render json: @channels }
    end
  end

  # GET /channels/1
  # GET /channels/1.json
  def show
    @channel = Channel.find(params[:id])
    if @channel.user_id == current_user.id
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @channel }
    end
  end

  # GET /channels/new
  # GET /channels/new.json
  def new
    @channel = Channel.new
    @channel_path = user_channels_path
  end

  # GET /channels/1/edit
  def edit
    @channel = Channel.find(params[:id])
    @channel_path = user_channel_path(@channel)
    respond_to do |format|
      if @channel.user_id == current_user.id
        format.html # edit.html.erb
        format.json { render json: @channel }
      else
        format.html { redirect_to user_channels_path, :notice => 'Channel not found.' }
        format.json { render :json => :error }
      end
    end
  end

  # POST /channels
  # POST /channels.json
  def create
    @channel = Channel.new(params[:channel])
    @channel.user_id = current_user.id
    respond_to do |format|
      if @channel.save
        format.html { redirect_to user_channels_path, notice: 'Channel created.' }
        format.json { render json: @channel, status: :created }
      else
        check_if_limit_error
        format.html { render action: "new" }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /channels/1
  # PUT /channels/1.json
  def update
    @channel = Channel.find(params[:id])

    respond_to do |format|
      if @channel.update_attributes(params[:channel])
        format.html { redirect_to user_channels_url, notice: 'Channel was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    @channel = Channel.find(params[:id])
    @channel.destroy

    respond_to do |format|
      format.html { redirect_to user_channels_url }
      format.json { head :no_content }
    end
  end

  private
  def check_if_limit_error
    if @channel.errors.messages[:base]
      flash[:alert] = @channel.errors.messages[:base].first
    end
  end
end
