require 'pacto'

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
end

::Pacto.load_all(options[:directory], 'http://www.mydomain.com:9001')

::Pacto.use(:default)
