class WordsController < ApplicationController
  before_action :require_sign_in
  before_action :get_user
  before_action :get_categories
  before_action :set_word, only: [:edit, :update, :destroy]

  def new
    @word = @user.words.new
  end

  def edit
  end

  def create
    @word = @user.words.new(word_params)

    respond_to do |format|
      if @word.save
        format.html { redirect_to words_url, notice: 'Word was successfully created.' }
        format.json { render :show, status: :created, location: @word }
      else
        format.html { render :new }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to words_url, notice: 'Word was successfully updated.' }
        format.json { render :show, status: :ok, location: @word }
      else
        format.html { render :edit }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @word.destroy
    respond_to do |format|
      format.html { redirect_to words_url, notice: 'Word was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_word
      get_words
      @word = @words.find(params[:id])
    end

    def word_params
      params.require(:word).permit(:user_id, :category_id, :word, :mean, :remember_count)
    end
end
