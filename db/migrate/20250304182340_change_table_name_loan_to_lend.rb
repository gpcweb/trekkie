class ChangeTableNameLoanToLend < ActiveRecord::Migration[8.0]
  def change
    rename_table('loans', 'lends')
  end
end
