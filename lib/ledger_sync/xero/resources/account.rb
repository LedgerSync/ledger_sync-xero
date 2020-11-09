# frozen_string_literal: true

module LedgerSync
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
        'wages_expense' => 'WAGESEXPENSE',
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
        'archived' => 'ARCHIVED'
      }.freeze

      BANK_ACCOUNT_TYPES = {
        'bank' => 'BANK',
        'credit_card' => 'CREDITCARD',
        'paypal' => 'PAYPAL'
      }.freeze

      TAX_TYPE = {
        # Australia
        # 'output' => 'OUTPUT',
        # 'input' => 'INPUT',
        'exempt_expenses' => 'EXEMPTEXPENSES',
        'exempt_output' => 'EXEMPTOUTPUT',
        'bas_excluded' => 'BASEXCLUDED',
        'gst_onimports' => 'GSTONIMPORTS',

        # Global
        'input' => 'INPUT',
        'none' => 'NONE',
        'output' => 'OUTPUT',
        'gst_on_imports' => 'GSTONIMPORTS',

        # TODO: Move to common : input_2, output_2

        # New Zeland
        'input_2' => 'INPUT2',
        # 'none' => 'NONE',
        'zero_rated' => 'ZERORATED',
        'output_2' => 'OUTPUT2',
        # 'gst_on_imports' => 'GSTONIMPORTS',

        # United Kingdom
        'capex_input' => 'CAPEXINPUT',
        'capex_input_2' => 'CAPEXINPUT2',
        'capex_output' => 'CAPEXOUTPUT',
        'capex_output_2' => 'CAPEXOUTPUT2',
        'capex_sr_input' => 'CAPEXSRINPUT',
        'capex_sr_output' => 'CAPEXSROUTPUT',
        'ec_acquisitions' => 'ECACQUISITIONS',
        'ec_zero_input' => 'ECZRINPUT',
        'ec_zero_output' => 'ECZROUTPUT',
        'ec_zero_output_services' => 'ECZROUTPUTSERVICES',
        'exempt_input' => 'EXEMPTINPUT',
        # 'exempt_output' => 'EXEMPTOUTPUT',
        # 'gst_on_imports' => 'GSTONIMPORTS',
        # 'input_2' => 'INPUT2',
        # 'none' => 'NONE',
        # 'output_2' => 'OUTPUT2',
        'reverse_charges' => 'REVERSECHARGES',
        'rr_input' => 'RRINPUT',
        'rr_output' => 'RROUTPUT',
        'sr_input' => 'SRINPUT',
        'sr_output' => 'SROUTPUT',
        'zero_rated_input' => 'ZERORATEDINPUT',
        'zero_rated_output' => 'ZERORATEDOUTPUT',

        # United States
        # 'input' => 'INPUT',
        # 'none' => 'NONE',
        # 'output' => 'OUTPUT',
        # 'gst_on_imports' => 'GSTONIMPORTS',

        # Singapore
        'bl_input' => 'BLINPUT',
        'ds_output' => 'DSOUTPUT',
        'ep_input' => 'EPINPUT',
        'es_33_output' => 'ES33OUTPUT',
        'esn_33_output' => 'ESN33OUTPUT',
        'igds_input_2' => 'IGDSINPUT2',
        'im_input_2' => 'IMINPUT2',
        # 'input' => 'INPUT',
        'me_input' => 'MEINPUT',
        # 'none' => 'NONE',
        'nr_input' => 'NRINPUT',
        'op_input' => 'OPINPUT',
        'os_output' => 'OSOUTPUT',
        # 'output' => 'OUTPUT',
        'tx_ess_input' => 'TXESSINPUT',
        'tx_n33_input' => 'TXN33INPUT',
        'tx_pet_input' => 'TXPETINPUT',
        'tx_re_input' => 'TXREINPUT',
        # 'zero_rated_input' => 'ZERORATEDINPUT',
        # 'zero_rated_output' => 'ZERORATEDOUTPUT',

        # South Africa
        'acc_28_plus' => 'ACC28PLUS',
        'acc_upto_28' => 'ACCUPTO28',
        'bad_debt' => 'BADDEBT',
        'cap_ex_input' => 'CAPEXINPUT',
        'cap_ex_input_2' => 'CAPEXINPUT2',
        # 'exempt_input' => 'EXEMPTINPUT',
        # 'exempt_output' => 'EXEMPTOUTPUT',
        'gst_on_cap_imports' => 'GSTONCAPIMPORTS',
        'im_input' => 'IMINPUT',
        # 'input' => 'INPUT',
        # 'input_2' => 'INPUT2',
        'input_3' => 'INPUT3',
        'input_4' => 'INPUT4',
        # 'none' => 'NONE',
        # 'output' => 'OUTPUT',
        'other_input' => 'OTHERINPUT',
        'other_output' => 'OTHEROUTPUT',
        # 'output' => 'OUTPUT',
        # 'output_2' => 'OUTPUT2',
        'output_3' => 'OUTPUT3',
        'output_4' => 'OUTPUT4',
        'sh_output' => 'SHOUTPUT',
        # 'sr_output' => 'SROUTPUT',
        'sr_output_2' => 'SROUTPUT2',
        # 'zero_rated' => 'ZERORATED',
        # 'zero_rated_output' => 'ZERORATEDOUTPUT',
        'zr_input' => 'ZRINPUT',


      }.freeze

      attribute :Code, type: Type::String
      attribute :Name, type: Type::String
      attribute :Type, type: Type::StringFromSet.new(values: TYPES.keys)
      attribute :BankAccountNumber, type: Type::String
      attribute :Status, type: Type::StringFromSet.new(values: STATUS_CODES.keys)
      attribute :Description, type: Type::String
      attribute :BankAccountTypes, type: Type::StringFromSet.new(values: BANK_ACCOUNT_TYPES.keys)
      attribute :CurrencyCode, type: Type::String
      attribute :TaxType, type: Type::String
      attribute :Class, type: Type::StringFromSet.new(values: CLASS_TYPES.keys)

      # TODO: Optional ?
      # attribute :EnablePaymentsToAccount, type: Type::Boolean
      # attribute :ShowInExpenseClaims, type: Type::Boolean
      # attribute :SystemAccount, type: Type::
      # attribute :ReportingCode, type: Type::
      # attribute :ReportingCodeName, type: Type::
      # attribute :HasAttachments, type: Type::Boolean
      # attribute :UpdatedDateUTC, type: Type::Date
      # attribute :AddToWatchlist, type: Type::Boolean
    end
  end
end
