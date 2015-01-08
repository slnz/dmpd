object :@call
attributes :id, :step
child(:events, if: lambda { |call| call }) do
  attributes :state_title, :step_title, :transition_title, :start_time,
    :message, :state, :step, :transition
end