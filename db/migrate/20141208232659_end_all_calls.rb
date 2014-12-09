class EndAllCalls < ActiveRecord::Migration
  def change
    Contact::Call.where(end_time: nil).each do |call|
      call.end_time = Time.now
      call.save
    end
  end
end
