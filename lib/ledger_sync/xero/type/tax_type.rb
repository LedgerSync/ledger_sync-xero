# frozen_string_literal: true

module LedgerSync
  module Xero
    module Type
      include LedgerSync::Type

      class TaxType < LedgerSync::Type::StringFromSet
        TAX_TYPE = {
          # Australia
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
          'zero_rated' => 'ZERORATED',
          'output_2' => 'OUTPUT2',

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
          'reverse_charges' => 'REVERSECHARGES',
          'rr_input' => 'RRINPUT',
          'rr_output' => 'RROUTPUT',
          'sr_input' => 'SRINPUT',
          'sr_output' => 'SROUTPUT',
          'zero_rated_input' => 'ZERORATEDINPUT',
          'zero_rated_output' => 'ZERORATEDOUTPUT',

          # United States

          # Singapore
          'bl_input' => 'BLINPUT',
          'ds_output' => 'DSOUTPUT',
          'ep_input' => 'EPINPUT',
          'es_33_output' => 'ES33OUTPUT',
          'esn_33_output' => 'ESN33OUTPUT',
          'igds_input_2' => 'IGDSINPUT2',
          'im_input_2' => 'IMINPUT2',
          'me_input' => 'MEINPUT',
          'nr_input' => 'NRINPUT',
          'op_input' => 'OPINPUT',
          'os_output' => 'OSOUTPUT',
          'tx_ess_input' => 'TXESSINPUT',
          'tx_n33_input' => 'TXN33INPUT',
          'tx_pet_input' => 'TXPETINPUT',
          'tx_re_input' => 'TXREINPUT',

          # South Africa
          'acc_28_plus' => 'ACC28PLUS',
          'acc_upto_28' => 'ACCUPTO28',
          'bad_debt' => 'BADDEBT',
          'cap_ex_input' => 'CAPEXINPUT',
          'cap_ex_input_2' => 'CAPEXINPUT2',
          'gst_on_cap_imports' => 'GSTONCAPIMPORTS',
          'im_input' => 'IMINPUT',
          'input_3' => 'INPUT3',
          'input_4' => 'INPUT4',
          'other_input' => 'OTHERINPUT',
          'other_output' => 'OTHEROUTPUT',
          'output_3' => 'OUTPUT3',
          'output_4' => 'OUTPUT4',
          'sh_output' => 'SHOUTPUT',
          'sr_output_2' => 'SROUTPUT2',
          'zr_input' => 'ZRINPUT'
        }.freeze

        def initialize
          super values: TAX_TYPE.keys
        end
      end
    end
  end
end
