class NewsletterController < ApplicationController
    def new
    end

    def create
        email = params[:newsletter][:email_address]
        list_id = Rails.application.credentials[:mailchimp_list_id]
        gibbon = Gibbon::Request.new
        member_info = gibbon.lists(list_id).members(email).retrieve.body[:status]

        if member_info = "subscribed"
            flash.now[:notice] = "You are already subscribed to the newsletter"
            render 'new'
        else 
            begin
                result = gibbon.lists(list_id).members.create(body: {email_address: email, status: "subscribed"})
                respond_to do |format|
                    format.js
                    flash.now[:notice] = "Your have been successfully subscribed to the newsletter"
                end
            rescue Gibbon::MailChimpError => e
                flash.now[:alert] = "Something went wrong"
                render 'new'
            end
        end
    end

    def user_add_subscribtion
        if current_user
            email = current_user.email
        else
            email = params[:newsletter][:email_address]
        end

        list_id = Rails.application.credentials[:mailchimp_list_id]
        gibbon = Gibbon::Request.new

        begin
            gibbon.lists(list_id).members.create(body: {email_address: email, status: "subscribed"})
            flash[:notice] = "Your have been successfully subscribed to the newsletter"
            current_user.update_columns(newsletter: true)
            redirect_to root_path
        rescue Gibbon::MailChimpError => e
            flash[:alert] = "Something went wrong, or you are already subscribed."
            redirect_to root_path
        end  
    end

    def user_delete_subscribtion
        email = Digest::MD5.hexdigest(current_user.email)
        list_id = Rails.application.credentials[:mailchimp_list_id]
        gibbon = Gibbon::Request.new

        begin
            gibbon.lists(list_id).members(email).delete
            flash[:notice] = "Your have been successfully unsubscribed from the newsletter"
            current_user.update_columns(newsletter: false)
            redirect_to root_path
        rescue Gibbon::MailChimpError => e
            flash[:alert] = "Something went wrong"
            redirect_to root_path
        end  
    end
end
