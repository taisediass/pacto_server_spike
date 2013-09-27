require 'pacto'

contract = Pacto.build_from_file('file.json', 'http://www.mydomain.com:9001')
Pacto.configure do |c|
	c.strict_matchers = options[:strict]
	c.register_contract(contract, 'my_tag')
end
Pacto.use('my_tag')