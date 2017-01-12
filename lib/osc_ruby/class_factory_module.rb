require 'osc_ruby/connect'
require 'osc_ruby/validations_module'
require 'json'

module OSCRuby

	module ClassFactoryModule

		class << self

			def new_from_fetch(attributes,class_name)

		    	ValidationsModule.check_attributes(attributes)

		    	class_name.new(attributes)

			end

			def find(hash,class_name)

		    	ValidationsModule::check_client(hash['client'])

		    	ValidationsModule::check_for_id(hash['id'])

		    	url = "queryResults/?query=select * from #{hash['obj_query']} where id = #{hash['id']}"
		    		
		    	resource = URI.escape(url)

		    	class_json = QueryModule::find(hash['client'],resource)

				if hash['return_json'] == true

					class_json

				else

					class_json_final = JSON.parse(class_json)

					ClassFactoryModule::new_from_fetch(class_json_final[0],class_name)

				end

			end

		end

	end
	
end