module Inboxes
  class MessagesController < ApplicationController
    before_action :set_inbox

    def upvote
      @message = @inbox.messages.find(params[:id])
      flash[:notice] = 'voted!'
      if current_user.voted_up_on? @message
        @message.downvote_from current_user
      elsif current_user.voted_down_on? @message
        @message.liked_by current_user
      else
        @message.liked_by current_user
      end
      redirect_to @inbox
    end

    # GET /messages/new
    def new
      @message = @inbox.messages.new
    end

    # POST /messages or /messages.json
    def create
      @message = @inbox.messages.new(message_params)

      respond_to do |format|
        if @message.save
          format.html { redirect_to @inbox, notice: 'Message was successfully created.' }
          format.json { render :show, status: :created, location: @message }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @message.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /messages/1 or /messages/1.json
    def update
      respond_to do |format|
        if @message.update(message_params)
          format.html { redirect_to message_url(@message), notice: 'Message was successfully updated.' }
          format.json { render :show, status: :ok, location: @message }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @message.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /messages/1 or /messages/1.json
    def destroy
      @message = @inbox.messages.find(params[:id])

      @message.destroy

      respond_to do |format|
        format.html { redirect_to @inbox, notice: 'Message was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:body).merge(user: current_user)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_inbox
      @inbox = Inbox.find(params[:inbox_id])
    end
  end
end
