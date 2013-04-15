class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
  before_filter :current_account

  def after_sign_in_path_for(resource)
    account_subdomain = current_user.account.subdomain
    admin_users_url(:subdomain => account_subdomain)
  end

  def is_root_domain?
    # return true if there is no subdomain
    result = (request.subdomains.first.present? && request.subdomains.first != "www") ? false : true
  end

  def current_account
    # If subdomain is present, returns the account, else nil
    if !is_root_domain?
      @current_account ||= Account.find_by_subdomain(request.subdomains.first)
      if @current_account.nil?
        redirect_to root_url(:account => false, :alert => "Unknown Account/subdomain")
      end
    else 
      @current_account = nil
    end
    @current_account
  end  
end
