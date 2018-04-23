RSpec.describe StackMaster::ParameterResolvers::JsonParameterStoreResolver do

  describe '#resolve' do

    let(:config) { double(base_dir: '/base') }
    let(:stack_definition) { double(stack_name: 'mystack', region: 'eu-east-1') }
    subject(:resolver) { described_class.new(config, stack_definition) }
    let(:parameter_name) { '/aws/service/ecs/optimized-ami/amazon-linux/recommended#image_id' }
    let(:parameter_value) { "ami-2d386654" }
    let(:client_response) {"{\"schema_version\":1,\"image_name\":\"amzn-ami-2017.09.l-amazon-ecs-optimized\",\"image_id\":\"ami-2d386654\",\"os\":\"Amazon Linux\",\"ecs_runtime_version\":\"Docker version 17.12.1-ce\",\"ecs_agent_version\":\"1.17.3\"}"}
    let(:unknown_parameter_name) { 'NOTEST' }
    let(:unencryptable_parameter_name) { 'SECRETTEST' }


    context 'the parameter is defined' do
      before do
        Aws.config[:ssm] = {
          stub_responses: {
            get_parameter: {
              parameter: {
                name: parameter_name,
                value: client_response,
                type: "SecureString",
                version: 1
              }
            }
          }
        }
      end

      it 'should return the parameter value' do
        expect(resolver.resolve(parameter_name)).to eq parameter_value
      end
    end

    context 'the parameter is undefined' do
      before do
        Aws.config[:ssm] = {
          stub_responses: {
            get_parameter:
              Aws::SSM::Errors::ParameterNotFound.new(unknown_parameter_name, "Parameter #{unknown_parameter_name} not found")
          }
        }
      end
      it 'should raise and error' do
        expect { resolver.resolve(unknown_parameter_name) }
            .to raise_error(StackMaster::ParameterResolvers::ParameterStore::ParameterNotFound, "Unable to find #{unknown_parameter_name} in Parameter Store")
      end
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
