describe "Include Modules to Native Class" do
  before do
    @resource = NSBundle.mainBundle.resourcePath
    @text = open(@resource + "/sample.json").read
    @data = BubbleWrap::JSON.parse(@text)
  end

  it "should have String.to_color" do
    "#1f73ae".to_color.is_a?(UIDeviceRGBColor).should.be.true
  end

  it "should have String.to_color via string from file" do
    @text.should == %{{ "color": "#1f73ae" }}
    @data["color"].to_color.is_a?(UIDeviceRGBColor).should.be.true
  end
end
