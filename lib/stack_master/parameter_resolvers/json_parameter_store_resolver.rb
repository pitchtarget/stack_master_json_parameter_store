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
        partition = partition_value(value)
        begin
          resp = ssm.get_parameter({
            name: partition[:parampath],
            with_decryption: false
          })
        rescue Aws::SSM::Errors::ParameterNotFound
          raise StackMaster::ParameterResolvers::ParameterStore::ParameterNotFound, "Unable to find #{partition[:parampath]} in Parameter Store"
        end
        parse_json(JSON.parse(resp.parameter.value), partition)
      end

      def parse_json(json, partition)
        JMESPath.search(partition[:jmespath], json)
      end

      def partition_value(value)
        partition = value.partition('#')
        {parampath: partition.first, jmespath: partition.last}
      end

      private

      def ssm
        @ssm ||= Aws::SSM::Client.new(region: @stack_definition.region)
      end
    end
  end
end
