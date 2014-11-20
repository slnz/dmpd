object :@call
attributes :id, :step
node(:possible_states, if: lambda { |call| @possible_states }) do |call|
  @possible_states
end