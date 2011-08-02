require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Canvas" do
  
  before(:each) do
    @attributes = {:width => "10cm", 
                    :height => "20cm"}
  end
  
  it "should require a height argument for initialization" do
    lambda {
      Canvas.with @attributes.merge(:width => nil)
    }.should raise_error(ArgumentError, "A width argument is required")
  end

  it "should require a width argument for initialization" do
    lambda {
      Canvas.with @attributes.merge(:height => nil)
    }.should raise_error(ArgumentError, "A height argument is required")
    
  end
  
  it "should be possible to create a canvas object given width and height" do
    canvas = Canvas.with @attributes
    
    canvas.should_not be_nil
  end
  
  it "should set the right width and height to the canvas" do
    renderer = mock("renderer")
    renderer.should_receive(:new).with @attributes[:width], @attributes[:height]
    canvas = Canvas.with @attributes.merge(:renderer => renderer)
  end
  
  it "should write the plot" do
    require 'stringio'

    rendererInstance = mock("rendererInstance")
    rendererInstance.should_receive(:output).and_return("return_value")
    
    rendererKlass = mock("rendererKlass")
    rendererKlass.stub(:new).with(@attributes[:width], @attributes[:height]).and_return(rendererInstance)
    
    canvas = Canvas.with @attributes.merge(:renderer => rendererKlass)
    output_file = StringIO.new()
    canvas.save(output_file)
    output_file.string.should == "return_value"
  end
end