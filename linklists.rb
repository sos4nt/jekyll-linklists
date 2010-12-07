module Jekyll
  class Linklists < Generator
    attr_accessor :linklists

    def initialize(config)
      @linklists = []
      
      Dir[File.join(Dir.pwd, '_linklists', '*.yml')].each do |linklist_file|
        begin
          data = YAML.load_file(linklist_file)
          raise "Invalid linklist - #{linklist_file}" if !data.is_a?(Array)
          
          linklist = Linklist.new(File.basename(linklist_file, ".yml"))
          linklist.links = data.map{ |link_data| Link.new(link_data) }
          self.linklists << linklist
        rescue => err
          $stderr.puts "WARNING: Could not read linklist."
          $stderr.puts "\t" + err.to_s
        end
      end
      
      config['linklists'] = self.linklists.inject({}) { |hash,linklist| hash[linklist.name] = linklist ; hash }
    end
    
    # doesn't actually generate anything
    def generate(site)
    end
  end
  
  class Linklist
    attr_accessor :name, :links
    
    def initialize(name)
      @name = name
      @links = []
    end
    
    def to_liquid
      { "links" => self.links }
    end
    
    def inspect
      "#<Jekyll:Linklist @name=#{self.name.inspect}>"
    end
  end
  
  class Link
    attr_accessor :options
    
    def initialize(options = {})
      @options = options
    end
    
    def to_liquid
      self.options
    end

    def inspect
      "#<Jekyll:Link @options=#{self.options.inspect}>"
    end
  end
end
