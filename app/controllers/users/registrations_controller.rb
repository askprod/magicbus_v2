# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  clear_respond_to
  respond_to :js

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      response_to_sign_up_failure resource
    end
  end

  # GET /resource/edit
  def edit
    respond_to do |format|
      format.js
    end
  end

  # PUT /resource
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      set_flash_message_for_update(resource, prev_unconfirmed_email)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      response_to_edit_failure resource
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  protected

  def update_resource(resource, params)
    if params[:current_password].blank?
     resource.update_without_password(params.except(:current_password))
    else
      resource.update_with_password(params)
    end
  end

  def response_to_sign_up_failure(resource)
    if resource.email == "" && resource.password == nil
      set_flash_message :alert, :not_empty
    elsif User.pluck(:email).include? resource.email
      set_flash_message :alert, :email_already_used
    else 
      flash[:alert] = resource.errors.full_messages.first
    end
    render 'new'
  end

  def response_to_edit_failure(resource)
    flash[:alert] = resource.errors.full_messages.first
    redirect_to edit_user_registration_path, turbolinks: false
  end

  # If you have extra params to permit, append them to the sanitizer.

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
