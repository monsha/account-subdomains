class Admin::UsersController < ApplicationController
  def index
    @users = current_account.users
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user].merge(:password => '12345678'))
    @user.account = current_account
    respond_to do |format|
      if @user.save
        User.invite!(:email => @user.email)
        format.html  { redirect_to([:admin,@user],
          :notice => 'User was successfully created.') }
        format.json  { render :json => @user,
          :status => :created, :location => @user }                        
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @user.errors,
            :status => :unprocessable_entity }          
      end
    end    
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html  { redirect_to([:admin,@user],
          :notice => 'User was successfully updated.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @user.errors,
          :status => :unprocessable_entity }        
      end
    end
  end  

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end  
end
