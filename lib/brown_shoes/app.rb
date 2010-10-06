module Shoes
class App
    
    attr_accessor :elements,:frame
    
    def initialize(opts={}, &blk)
    @elements = {}
    @frame = javax.swing.JFrame.new()
    
    @global_panel = javax.swing.JPanel.new()
    @current_panel = @global_panel
    flow(opts, &blk)
    
     
    @frame.add(@global_panel)
    @frame.setDefaultCloseOperation(javax.swing.JFrame::EXIT_ON_CLOSE)
    @frame.pack()
    if(opts[:width] && opts[:height])
      @frame.setSize(opts[:width], opts[:height])
    end
    @frame.set_visible(true)
  end
  
  def button(opts={}, &blk)
    button = Button.new(@current_panel,opts, &blk)
    @elements[button.identifier] = button.to_java
    button
  end
  
  def edit_line(opts={})
    eline = Edit_line.new(@current_panel, opts)
    @elements[eline.identifier] = eline.to_java
    eline
  end
  
  def text_box(opts={})
    tbox = Text_box.new(@current_panel, opts)
    @elements[tbox.identifier] = tbox.to_java
    tbox
  end
  def stack(opts={}, &blk)
    tstack = Stack.new(opts)
    layout(tstack, &blk)
  end
  
  def flow(opts={}, &blk)
    tflow = Flow.new(opts)
    layout(tflow, &blk)
  end
  
  def layout(layer, &blk)
    parent = @current_panel
    @current_panel = layer.panel
    instance_eval &blk
    parent.add(@current_panel)
    @current_panel = parent
  end
end
end