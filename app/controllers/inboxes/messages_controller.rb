module Inboxes
  class MessagesController < ApplicationController
    before_action :set_inbox

    def change_status
      @message = @inbox.messages.find(params[:id])
      flash[:notice] = "Status for message #{@message.id}: #{@message.status}"
      @message.update(status: params[:status])

      redirect_to @inbox

    end

    def upvote
      @message = @inbox.messages.find(params[:id])
      flash.now[:notice] = 'voted!'
      @message.upvote! current_user

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            render_turbo_flash,
            turbo_stream.replace(@message, partial: 'inboxes/messages/message', locals: { message: @message })
          ]
        end
      end
    end

    # POST /messages or /messages.json
    def create
      @message = @inbox.messages.new(message_params)

      respond_to do |format|
        if @message.save
          format.turbo_stream do
            flash.now[:notice] = "Message #{@message.id} created!"
            render turbo_stream: [
              render_turbo_flash,
              turbo_stream.update('message-form', partial: 'inboxes/messages/form', locals: { message: Message.new }),
              turbo_stream.update('message-counter', @inbox.messages_count),
              turbo_stream.prepend('message-list', partial: 'inboxes/messages/message', locals: { message: @message })
            ]
          end

          format.html { redirect_to @inbox, notice: 'Message was successfully created.' }
          format.json { render :show, status: :created, location: @message }
        else
          flash.now[:alert] = 'Something went wrong!'

          format.turbo_stream do
            render turbo_stream: [
              render_turbo_flash,
              turbo_stream.update('message-form', partial: 'inboxes/messages/form', locals: { message: @message })
            ]
          end
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
        flash[:notice] = "Message with ID #{@message.id} destroyed!"
        format.turbo_stream
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
