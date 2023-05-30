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
    Tempfile.open(['', '.wav']) do |wav_file|
      wav_file.binmode
      wav_file.write(wav_data)
      wav_file.rewind
      mp3_file_path = convert_wav_to_mp3(wav_file.path)
      File.read(mp3_file_path)
    end
  end
end
