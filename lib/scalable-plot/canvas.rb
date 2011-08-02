require 'rasem'

class Canvas
  def initialize(width, height, args)
    klass = args.delete(:renderer) || Rasem::SVGImage
    
    @renderer = klass.new(width, height)
  end
  
  class << self
    def with(args)
      raise ArgumentError.new("A width argument is required") unless width = args.delete(:width)
      raise ArgumentError.new("A height argument is required") unless height = args.delete(:height)
      
      return Canvas.new(width, height, args)
    end
  end
  
  def save(output)
    output << @renderer.output
  end
  
end