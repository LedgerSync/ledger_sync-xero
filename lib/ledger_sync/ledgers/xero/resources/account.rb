
# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Xero
      class Account < Xero::Resource

        TYPES = {
          'bank' => 'BANK',
          'current' => 'CURRENT',
          'current_liability' => 'CURRLIAB',
          'depreciation' => 'DEPRECIATN',
          'direct_costs' => 'DIRECTCOSTS',
          'equity' => 'EQUITY',
          'expense' => 'EXPENSE',
          'fixed_asset' => 'FIXED',
          'inventory' => 'INVENTORY',
          'liability'=> 'LIABILITY',
          'non_current' => 'NONCURRENT',
          'other_income' => 'OTHERINCOME',
          'overheads' => 'OVERHEADS',
          'pre_payment' => 'PREPAYMENT',
          'revenue' => 'REVENUE',
          'sales' => 'SALES',
          'long_term_liability' => 'TERMLIAB',
          'pay_as_you_go_liability' => 'PAYGLIABILITY',
          'pay_as_you_go' => 'PAYG',
          'superannuation_expense' => 'SUPERANNUATIONEXPENSE',
          'superannuation_liability' => 'SUPERANNUATIONLIABILITY',
          'wages_expense' => 'WAGESEXPENSE',
        }.freeze

        attribute :code, type: LedgerSync::Type::String
        attribute :name, type: LedgerSync::Type::String
        attribute :account_id, type: LedgerSync::Type::String
        attribute :type, type: Type::StringFromSet.new(values: TYPES.keys)

        def name
          self.Name
        end
      end
    end
  end
end
