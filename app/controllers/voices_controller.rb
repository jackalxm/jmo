class VoicesController < ApplicationController
  #before user can do anything to voices, must sign in, except seeing the voices (index page)
  before_filter :authenticate_user!, except: [:index]
  before_action :set_voice, only: [:show, :edit, :update, :destroy]

  # GET /voices
  # GET /voices.json
  def index
    @voices = Voice.order("created_at desc")
  end

  # GET /voices/1
  # GET /voices/1.json
  def show
  end

  # GET /voices/new
  def new
    #associate new voices with users
    @voice = current_user.voices.new
  end

  # GET /voices/1/edit
  def edit
    # makes sure no other user can mess with other uses voices
    @voice = current_user.voices.find(params[:id])
  end

  # POST /voices
  # POST /voices.json
  def create
    @voice = current_user.voices.new(voice_params)

    respond_to do |format|
      if @voice.save
        format.html { redirect_to @voice, notice: 'Voice was successfully created.' }
        format.json { render action: 'show', status: :created, location: @voice }
      else
        format.html { render action: 'new' }
        format.json { render json: @voice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /voices/1
  # PATCH/PUT /voices/1.json
  def update
    #only user with the right ID can update
    @voice = current_user.voices.find(params[:id])

    respond_to do |format|
      if @voice.update(voice_params)
        format.html { redirect_to @voice, notice: 'Voice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @voice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /voices/1
  # DELETE /voices/1.json
  def destroy
    #only users with the right ids can destroy
    @voice = current_user.voices.find(params[:id])
    @voice.destroy
    respond_to do |format|
      format.html { redirect_to voices_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_voice
      @voice = Voice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def voice_params
      params.require(:voice).permit(:opinion)
    end
end
