class RemoveUniquenessFromAuthorizationsOnProviderIndex < ActiveRecord::Migration[6.1]
    def change
      remove_index :authorizations, name: "index_authorizations_on_provider"
      add_index :authorizations, :provider, name: "index_authorizations_on_provider"
    end
end
