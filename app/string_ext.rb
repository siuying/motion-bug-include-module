module BubbleWrap
  module String
    
    # Convert 'snake_case' into 'CamelCase'
    def camelize(uppercase_first_letter = true)
      string = self.dup
      string.gsub!(/(?:_|(\/))([a-z\d]*)/i) do
        new_word = $2.downcase
        new_word[0] = new_word[0].upcase
        new_word = "/#{new_word}" if $1 == '/'
        new_word
      end
      if uppercase_first_letter && uppercase_first_letter != :lower
        string[0] = string[0].upcase
      else
        string[0] = string[0].downcase
      end
      string.gsub!('/', '::')
      string
    end


    def to_color
      # First check if it is a color keyword
      keyword_selector = "#{self.camelize(:lower)}Color"
      return UIColor.send(keyword_selector) if UIColor.respond_to? keyword_selector

      # Next attempt to convert from hex
      hex_color = self.gsub("#", "")
      case hex_color.size
        when 3
          colors = hex_color.scan(%r{[0-9A-Fa-f]}).map{ |el| (el * 2).to_i(16) }
        when 6
          colors = hex_color.scan(%r<[0-9A-Fa-f]{2}>).map{ |el| el.to_i(16) }
        else
          raise ArgumentError
      end
      if colors.size == 3
        UIColor.colorWithRed((colors[0]/255.0), green:(colors[1]/255.0), blue:(colors[2]/255.0), alpha:1)
      else
        raise ArgumentError
      end
    end 
  end
end
String.send(:include, BubbleWrap::String)