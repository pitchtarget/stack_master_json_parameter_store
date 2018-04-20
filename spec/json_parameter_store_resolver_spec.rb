RSpec.describe StackMaster::ParameterResolvers::JsonParameterStoreResolver do
  describe '#resolve' do
    subject(:resolver) { described_class.new(nil, double(region: 'eu-west-1')) }

    skip 'should return the environment variable value' do
      #expect(resolver.resolve(environment_variable_name)).to eq 'ami-2d386654'
    end
  end

  describe '#partition_value' do
    subject(:resolver) { described_class.new(nil, double(region: 'eu-west-1')) }

    it 'should return the parameter path and jmespath' do
      parameter = "/aws/service/ecs/optimized-ami/amazon-linux/recommended#image_id"
      expect(resolver.partition_value(parameter)[:parampath]).to eq '/aws/service/ecs/optimized-ami/amazon-linux/recommended'
      expect(resolver.partition_value(parameter)[:jmespath]).to eq 'image_id'
    end
  end

  describe '#parse_json' do
    subject(:resolver) { described_class.new(nil, double(region: 'eu-west-1')) }

    it 'should return the value for the jmespath' do
      json = {"schema_version"=>1, "image_name"=>"amzn-ami-2017.09.l-amazon-ecs-optimized", "image_id"=>"ami-2d386654", "os"=>"Amazon Linux", "ecs_runtime_version"=>"Docker version 17.12.1-ce", "ecs_agent_version"=>"1.17.3"}
      parameter = "/aws/service/ecs/optimized-ami/amazon-linux/recommended#image_id"
      expect(resolver.parse_json(json, resolver.partition_value(parameter))).to eq 'ami-2d386654'
    end
  end
end
