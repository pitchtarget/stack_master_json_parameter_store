describe StackMaster::ParameterResolvers::JsonParameterStoreResolver do
  it "broccoli is gross" do
    #json = {"schema_version"=>1, "image_name"=>"amzn-ami-2017.09.l-amazon-ecs-optimized", "image_id"=>"ami-2d386654", "os"=>"Amazon Linux", "ecs_runtime_version"=>"Docker version 17.12.1-ce", "ecs_agent_version"=>"1.17.3"}
    # expect "ami-2d386654"

    expect(Foodie::Food.portray("Broccoli")).to eql("Gross!")
  end
end
