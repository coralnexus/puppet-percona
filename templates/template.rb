
class PerconaTemplate
  
  #-----------------------------------------------------------------------------
  # Properties
  
  @@blocks = {}
  
  #-----------------------------------------------------------------------------
  # Constructor / Destructor
  
  def initialize
    @@blocks = {}
    configurations.each do |name, data|
      @@blocks[name] = PerconaTemplate.block(name, data)
    end  
  end
  
  #-----------------------------------------------------------------------------
  # Renderers  
  
  def self.render(name = '', render_type = true, remove = true)
    if name && ! name.empty?
      output = ''
      if @@blocks[name].is_a?(String)
        if render_type
          output << "[#{type}]\n"
        end
        output << @@blocks[name]  
      end
      if remove
        @@blocks.delete(name)
      end
    else
      @@blocks.each do |name, block|
        output << PerconaTemplate.render(name, render_type, remove)
      end  
    end
    return output
  end

  #---
     
  def self.block(type, input)
    output = ''        
    if input.is_a?(Hash)
      input.each do |keyword, data|
        if ! data || data.is_empty?
          output << "#{keyword}\n"
        else
          if data.is_a?(Array)
            output << "#{keyword} = " << data.join(',') << "\n"              
          elsif data.is_a?(String)
            output << "#{keyword} = #{data}\n"
          end
        end
      end        
      output << "\n"
    end  
    return output  
  end
end
