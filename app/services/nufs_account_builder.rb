# Contains overrides for building a `NufsAccount` from params.
# Dynamically called via the `AccountBuilder.for()` factory.
class NufsAccountBuilder < AccountBuilder

  protected

  # Override strong_params for `build` account.
  def account_params_for_build
    [
      { account_number_parts: NufsAccount.account_number_field_names },
      :account_number,
      :description,
    ]
  end

  # Hooks into superclass's `build` method.
  def after_build
    begin
      # This will populate virtual fields like fund, dept
      account.load_components
    rescue AccountNumberFormatError
      # do nothing
    rescue ValidatorError => e
      account.errors.add(:base, e.message)
    end

    account.set_expires_at
    # This is kind of a weird message to be adding here (the message is about)
    # not finding the fund, dept, activity, etc, but leaving here to preserve
    # existing behavior
    account.errors.add(:base, :missing_expires_at) unless account.expires_at
  end

end
