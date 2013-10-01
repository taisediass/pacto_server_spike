require 'pacto'


# This should be added to Pacto
module ::Pacto
  class << self
    def load_all(contracts_directory, host, *tags)
      contracts = Dir["#{contracts_directory}/**.json"]
      contracts.each do |contract_file| 
        contract = ::Pacto.build_from_file(contract_file, host)
        ::Pacto.register_contract(contract, *tags)
      end
    end
  end
end

::Pacto.configure do |c|
  c.strict_matchers = options[:strict]
  c.register_callback do |contracts, req, resp|
    contracts.each do |contract|
      violations = contract.validate(resp)
      raise violations.join("\n") unless violations.empty?
    end
  end
end


config[:live] = options[:backend_host].nil?
config[:backend] = options[:backend_host] ||= 'http://example.com'
::Pacto.load_all(options[:directory], config[:backend])
if config[:live]
  ::Pacto.use(:default)
else
  WebMock.allow_net_connect!
end
