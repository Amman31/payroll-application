class CreatePayslips < ActiveRecord::Migration[8.0]
  def change
    create_table :payslips do |t|
      t.string :name
      t.string :emp_id
      t.string :company
      t.string :pay_date
      t.string :filename

      t.timestamps
    end
  end
end
