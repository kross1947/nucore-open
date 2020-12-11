class AccountTransactionsController < ApplicationController

  customer_tab  :all
  before_action :authenticate_user!
  before_action :check_acting_as
  before_action :init_account

  helper_method :get_amt, :get_type , :get_status , :get_total_amount, :is_allow_request


  def initialize
    @active_tab = "accounts"
    #i18n_patch = ".account_transactions.index."
    #operation_type = "operation_type."
    #status = "status."
    #@lock_fund_string = I18n.t(i18n_patch+operation_type+"lock_fund")
    #@lock_fund_code = I18n.t(i18n_patch+operation_type+"lock_fund_code")
    #@unlock_fund_string = I18n.t(i18n_patch+operation_type+"unlock_fund")
    #@unlock_fund_code = I18n.t(i18n_patch+operation_type+"unlock_fund_code")

    #@prcoeesing_code = I18n.t(i18n_patch+status+"processing_code")
    #@processing_string = I18n.t(i18n_patch+status+"processing_string")
    #@success_code = I18n.t(i18n_patch+status+"success_code")
    #@success_string = I18n.t(i18n_patch+status+"success_string")
    #@failded_code = I18n.t(i18n_patch+status+"failded_code")
    #@failded_string = I18n.t(i18n_patch+status+"failded_string")
    super
  end

  #/accounts/1/account_transactions
  def index

  end

  def edit
  end

  def show
      action = "show"
      @active_tab = "accounts"
  end

  def ability_resource
    @account
  end

  def init_account
    if params.key? :id
      puts "[id]" + params[:id].to_s
      @account = Account.find params[:id].to_i
    elsif params.key? :account_id
      puts "[account_id]" + params[:account_id].to_s
      @account = Account.find params[:account_id].to_i
    end

  end

  def is_allow_request
    #account_transactions = AccountTransaction.find_by(account_id:@account)

    allow_request = true

    @account.account_transactions.each  do |at|

      if at.status.eql? @prcoeesing_code
        allow_request = false
      end

    end

    return allow_request
  end


  def account_transaction_params
      params.require(:account_transaction).permit(:operation_type, :credit_amt, :debit_amt, :account_id, :operation_amount)
  end

  def create_account_transactions
    puts "[create_account_transactions()][START]"

    #message = "Error : Allocation must be a positive number!"
    account_transaction = params[:account_transaction]
    account_id = account_transaction[:account_id].to_i

    @account = session_user.accounts.find(account_id)

   # puts "[create_account_transactions()][@account.id]" + @account.to_s
   #  operation_type = account_transaction[:operation_type].to_s
   # puts "[create_account_transactions()][operation_type]" + operation_type
   #  amt = account_transaction[:amt].to_f
   # puts "[create_account_transactions()][amt]" + amt.to_s


    if is_allow_request

      puts params[:operation_amt]
      puts "uyyyyy"

      @at = AccountTransaction.new(
              account_transaction_params.merge(
                created_by: session_user.id,
                status: "PROCESSING"
              ),
            )


      if @at.save
        flash[:notice] = "Save success" #text("update.success")
        redirect_to account_account_transactions_path(account_id)
      else
        #@input_amt = amt
        flash[:error]= @at.errors.messages
        render :index
      end

=begin
      insert_account_transactions = AccountTransaction.new;

      insert_account_transactions.account_id = user_id;


      if operation_type.eql? @lock_fund_string
        insert_account_transactions.operation_type = @lock_fund_code
        #insert_account_transactions.debit_amt = 0
        insert_account_transactions.credit_amt = @form_input_amount
      elsif operation_type.eql? @unlock_fund_string
        insert_account_transactions.operation_type = @unlock_fund_code
        #insert_account_transactions.credit_amt = 0
        insert_account_transactions.debit_amt = @form_input_amount
      end

      insert_account_transactions.status = @prcoeesing_code
      insert_account_transactions.created_at = Time.now
      insert_account_transactions.created_by = session_user.id
      if insert_account_transactions.save

        flash[:notice] = "Save success" #text("update.success")
        redirect_to account_account_transactions_path(user_id)
      else
        #@input_amt = amt
        flash[:error]= insert_account_transactions.errors.messages
        render :index
      end
=end
    else
      flash[:error] = I18n.t(".account_transactions.index.message.in_progrcess")
      redirect_to account_account_transactions_path(account_id)
    end

  end

=begin
  def get_amt(account_transaction)
    if account_transaction.operation_type.eql? @lock_fund_code
        return account_transaction.credit_amt

    elsif account_transaction.operation_type.eql? @unlock_fund_code
        return account_transaction.debit_amt
    end
  end

  def get_type(account_transaction)
    if account_transaction.operation_type.eql? @lock_fund_code
      return @lock_fund_string

    elsif account_transaction.operation_type.eql? @unlock_fund_code
      return @unlock_fund_string
    end
  end

  def get_status(account_transaction)
    if account_transaction.status.eql? @prcoeesing_code
      return @processing_string
    elsif account_transaction.status.eql? @success_code
      return @success_string
    elsif account_transaction.status.eql? @failded_code
      return @failded_string
    end

  end
=end
end
