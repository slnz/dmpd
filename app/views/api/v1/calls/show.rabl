object :@call
attributes :id, :contact_name, :created_at, :reason_title
child(:events, if: lambda { |call| call }) do
  attributes :state, :step, :transition, :start_time, :message
end