# frozen_string_literal: true

require_relative '../type/tax_type'

module LedgerSync
  module Xero
    class Account < Xero::Resource
      ACCOUNT_TYPES = {
        'bank' => 'BANK',
        'current' => 'CURRENT',
        'current_liability' => 'CURRLIAB',
        'depreciation' => 'DEPRECIATN',
        'direct_costs' => 'DIRECTCOSTS',
        'equity' => 'EQUITY',
        'expense' => 'EXPENSE',
        'fixed' => 'FIXED',
        'inventory' => 'INVENTORY',
        'liability' => 'LIABILITY',
        'non_current' => 'NONCURRENT',
        'other_income' => 'OTHERINCOME',
        'overheads' => 'OVERHEADS',
        'pre_payment' => 'PREPAYMENT',
        'revenue' => 'REVENUE',
        'sales' => 'SALES',

        # Non-current Liability account	: `non_current_liability` ?
        'termliab' => 'TERMLIAB',
        'payg_liability' => 'PAYGLIABILITY',
        'superannuation_expense' => 'SUPERANNUATIONEXPENSE',
        'superannuation_liability' => 'SUPERANNUATIONLIABILITY',
        'wages_expense' => 'WAGESEXPENSE'
      }.freeze

      CLASS_TYPES = {
        'asset' => 'ASSET',
        'equity' => 'EQUITY',
        'expense' => 'EXPENSE',
        'liability' => 'LIABILITY',
        'revenue' => 'REVENUE'
      }.freeze

      STATUS_CODES = {
        'active' => 'ACTIVE',
        'archived' => 'ARCHIVED',
        # Needed when new account is created.
        'ok' => 'OK'
      }.freeze

      BANK_ACCOUNT_TYPES = {
        'bank' => 'BANK',
        'credit_card' => 'CREDITCARD',
        'paypal' => 'PAYPAL',
        # TODO: Non-Banking type:
        '' => ''
      }.freeze

      attribute :Code, type: Type::String
      attribute :Name, type: Type::String
      attribute :Type, type: Type::StringFromSet.new(values: ACCOUNT_TYPES.keys)
      attribute :BankAccountNumber, type: Type::String
      attribute :Status, type: Type::StringFromSet.new(values: STATUS_CODES.keys)
      attribute :Description, type: Type::String
      attribute :BankAccountType, type: Type::StringFromSet.new(values: BANK_ACCOUNT_TYPES.keys)
      attribute :CurrencyCode, type: Type::String
      attribute :TaxType, type: Type::TaxType.new
      attribute :Class, type: Type::StringFromSet.new(values: CLASS_TYPES.keys)
    end
  end
end
