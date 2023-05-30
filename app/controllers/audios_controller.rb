class AudiosController < ApplicationController
  def create
    @user = User.find_by!(id: params[:user_id], token: params[:token])
    @audio = @user.audios.build(uuid: SecureRandom.uuid)
    @audio.audio_data = convert_wav_to_mp3(params[:audio_data])
    if @audio.save
      render json: { url: audio_url(@audio) }, status: :created
    else
      render json: @audio.errors, status: :unprocessable_entity
    end
  end

  def show
    @audio = Audio.find_by!(uuid: params[:id], user_id: params[:user_id])
    send_data @audio.audio_data, type: 'audio/mp3', disposition: 'inline'
  end

  private

  def convert_wav_to_mp3(wav_data)
    # Здесь нужно добавить код для конвертации WAV в MP3
  end
end
