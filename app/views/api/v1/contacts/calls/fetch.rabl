object :@call
attributes :id, :step
child(:events, if: lambda { |call| call }) do
  attributes :state, :step, :transition, :start_time, :message
end