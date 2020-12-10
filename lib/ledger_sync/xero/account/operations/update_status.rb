# frozen_string_literal: true

module LedgerSync
	module Xero
		class Account
			module Operations
				class UpdateStatus < Xero::Operation::UpdatePost
					class Contract < LedgerSync::Ledgers::Contract
						params do
							# TODO: Create new serializer. status_serializer, serializer_for_status
							required(:ledger_id).filled(:string)
							required(:external_id).filled(:string)
							required(:Status).filled(:string)
						end
					end
				end
			end
		end
	end
end
