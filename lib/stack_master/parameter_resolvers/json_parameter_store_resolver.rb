module StackMaster
  module ParameterResolvers
    class JsonParameterStoreResolver < Resolver
      array_resolver # Also create a EcsResolvers resolver to handle arrays

      def initialize(config, stack_definition)
        @config = config
        @stack_definition = stack_definition
      end

      def resolve(value)
        client = Aws::SSM::Client.new(
          region: @stack_definition.region
        )

        parampath = value.partition('#').first
        jmespath = value.partition('#').last

        resp = client.get_parameters({
          names: [parampath],
          with_decryption: false,
        })

        json = JSON.parse(resp.parameters[0].value)
        result = JMESPath.search(jmespath, json)
        puts "result = #{result}"
        puts "json = #{json}"
        result
      end
    end
  end
end
