class Exception::RecordInvalidError < StandardError
  attr_reader :instance_errors

  def initialize(instance_errors)
    @instance_errors = instance_errors
  end
end
