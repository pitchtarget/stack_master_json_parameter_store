require "stack_master"

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
        partition = partition_value(value)

        resp = client.get_parameters({
          names: [partition[:parampath]],
          with_decryption: false,
        })

        parse_json(JSON.parse(resp.parameters[0].value), partition)
      end

      def parse_json(json, partition)
        JMESPath.search(partition[:jmespath], json)
      end

      def partition_value(value)
        partition = value.partition('#')
        {parampath: partition.first, jmespath: partition.last}
      end
    end
  end
end
