module Arguments
  class << self
    def validate!(argument_names)
      return unless ARGV.length != argument_names.length
      argument_parameters = argument_names.map { "<#{ _1 }>" }.join(" ")
      puts "\e[31mUsage: ruby #{ $PROGRAM_NAME } #{ argument_parameters }\e[0m"
      exit 1
    end
  end
end
