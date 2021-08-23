# frozen_string_literal: true

require 'spec_helper'

module LedgerSync
  module Xero
    module Type
      RSpec.describe TaxType, unit: true do
        # let(:custom_resource_class) do
        #   class ClassWithTaxType < Xero::Resource do
        #     attribute :TaxType, type: TaxType.new
        #   end
        # end

        class ClassWithTaxType < Xero::Resource
          attribute :TaxType, type: TaxType.new
        end

        let(:resource) { ClassWithTaxType.new }

        it 'should not allow values not included in TAX_TYPE' do
          expect do
            resource.TaxType = 'random'
          end.to raise_error
        end

        it 'should allow values included in TAX_TYPE' do
          resource.TaxType = 'exempt_expenses'
        end
      end
    end
  end
end
