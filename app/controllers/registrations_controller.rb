class RegistrationsController < Devise::RegistrationsController
  protected

  def after_inactive_sign_up_path_for(resource)
    '/users/sign_in' # Or :prefix_to_your_route
  end
end
