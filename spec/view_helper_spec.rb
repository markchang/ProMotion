describe "view helpers" do

  def equal_rect(rect)
    ->(obj) { CGRectEqualToRect obj, rect }
  end
  
  before do
    @dummy = UIView.alloc.initWithFrame CGRectZero
    @dummy.extend ProMotion::ViewHelper
  end

  it "#frame_from_array should return zero rect for bad input" do
    @dummy.frame_from_array([]).should equal_rect(CGRectZero)
  end

  it "#frame_from_array should return a valid CGRect" do
    @dummy.frame_from_array([0,0,320,480]).should equal_rect(CGRectMake(0,0,320,480)) 
  end

  it "should allow you to set attributes" do
    @dummy.set_attributes @dummy, backgroundColor: UIColor.redColor
    @dummy.backgroundColor.should == UIColor.redColor
  end

  describe "content height" do

    before do
      @child = UIView.alloc.initWithFrame([[20,100],[300,380]])
      @dummy.addSubview @child
    end

    it "should return content height" do
      @dummy.content_height(@dummy).should == 480
    end

    it "should ignore hidden subviews" do
      @child.hidden = true
      @dummy.content_height(@dummy).should == 0
    end

  end

end
