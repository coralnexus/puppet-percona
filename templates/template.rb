
class PerconaTemplate
  
  #-----------------------------------------------------------------------------
  # Properties
  
  @@blocks = {}
  
  #-----------------------------------------------------------------------------
  # Constructor / Destructor
  
  def initialize(configurations)
    @@blocks = {}
    configurations.each do |name, data|
      @@blocks[name] = PerconaTemplate.block(name, data)
    end
  end
  
  #-----------------------------------------------------------------------------
  # Renderers  
  
  def self.render(name = '', render_type = true, remove = true)
    output = ''
    if ! name.empty?
      unless CORL::Util::Data.empty?(@@blocks[name])    
        if @@blocks[name].is_a?(String)
          if render_type
            output << "[#{name}]\n"
          end
          output << @@blocks[name]  
        end
        if remove
          @@blocks.delete(name)
        end
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
        if CORL::Util::Data.empty?(data)
          output << "#{keyword}\n"
        else
          if data.is_a?(Array)
            output << "#{keyword} = " << data.join(',') << "\n"              
          else
            output << "#{keyword} = #{data.to_s}\n"
          end
        end
      end        
      output << "\n"
    end  
    return output  
  end
end
