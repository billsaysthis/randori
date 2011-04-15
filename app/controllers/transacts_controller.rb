class TransactsController < ApplicationController
  # GET /transacts
  # GET /transacts.xml
  def index
    redirect_to :action => :new
  end

  # GET /transacts/1
  # GET /transacts/1.xml
  def show
    @transact = Transact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @transact }
    end
  end

  # GET /transacts/new
  # GET /transacts/new.xml
  def new
    @transact = Transact.new
    @transact.user = User.new
    @transact.atm = Atm.find Atm.default_machine

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transact }
    end
  end

  # POST /transacts
  # POST /transacts.xml
  def create
    p_trx = params[:transact]
    user = User.find_by_name(p_trx[:user][:name])
    good_user = (user.present? and user.valid_password? p_trx[:user][:password])
    if good_user
      atm = Atm.find p_trx[:atm]
      withdrawal = Transact.withdraw user, atm, p_trx[:amount]
      if good_transact = (withdrawal == "GOOD")
        @transact = user.transacts.where(:amount => p_trx[:amount]).last
      end
    end
    unless (good_user and good_transact)
      @transact = Transact.new
      @transact.errors.add(:base, User.check_bad_auth(p_trx[:user][:name], p_trx[:user][:password])) unless good_user
      @transact.errors.add(:base, withdrawal) unless good_transact
      @transact.user = User.new
      @transact.atm = Atm.find Atm.default_machine
    end

    respond_to do |format|
      if good_user and good_transact
        format.html { redirect_to @transact, :notice => 'Transaction was successfully updated.' }
        format.xml  { head :ok }
      else
        flash.alert = @transact.errors.full_messages
        format.html { redirect_to root_path }
        format.xml  { render :xml => @transact.errors, :status => :unprocessable_entity }
      end
    end
  end
end
