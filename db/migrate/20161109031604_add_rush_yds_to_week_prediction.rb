class AddRushYdsToWeekPrediction < ActiveRecord::Migration[5.0]
  def change
    add_column :week_predictions, :rush_yds, :decimal, default: 0
    add_column :week_predictions, :rush_att, :decimal, default: 0
    add_column :week_predictions, :rush_td, :decimal, default: 0
    add_column :week_predictions, :rec_yds, :decimal, default: 0
    add_column :week_predictions, :rec_made, :decimal, default: 0
    add_column :week_predictions, :rec_td, :decimal, default: 0
    add_column :week_predictions, :pass_att, :decimal, default: 0
    add_column :week_predictions, :pass_comp, :decimal, default: 0
    add_column :week_predictions, :pass_yds, :decimal, default: 0
    add_column :week_predictions, :pass_td, :decimal, default: 0
    add_column :week_predictions, :pass_int, :decimal, default: 0
    add_column :week_predictions, :sacked, :decimal, default: 0
  end
end
