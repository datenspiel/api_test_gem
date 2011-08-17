def api_test(*args)
  #unless (ARGV[0]!=nil && ARGV[1]!=nil)
  unless (args[0]!=nil && args[1]!=nil)
    puts "richtiger Aufruf via: 'api_test [controller] [action]'"
  else
    #route_yml=File.expand_path((File.dirname(__FILE__)).chomp('.')+ 'apitest_config.yml')
    #route_yml=File.expand_path("../projects/ave/tavex2/rails/api_test_config.yml")
    #for usage
    route_yml=File.expand_path("#{Dir.pwd}/api_test_config.yml")
    puts route_yml
    #arg_con=ARGV[0].split('/')
    arg_con=args[0].split('/')
    if File.exist?(route_yml)
      parsed = begin
        config=YAML.load(File.open("#{route_yml}"))
      rescue ArgumentError => e
        puts "Could not parse YAML: #{e.message}"
      end
      #config=YAML.load(File.open("#{route_yml}"))
    else
      puts "please create 'api_test_config.yml'"
      exit
    end
  
    #[arg_con[0], arg_con[1], ARGV[1]].each do |arg|
    [arg_con[0], arg_con[1], args[1]].each do |arg|
      if arg!=nil
        config=config[arg]
      end
      if config==nil
        puts "argument '#{arg}' doesn't exist"
        exit
      end
    end

    route_sh=File.expand_path(File.join(File.dirname(__FILE__), '/api_test.sh'))
    for_exec = "sh #{route_sh} #{config['method']} #{config['url']}"
    
    #params in json
    params=config['param']
    params_json=''
    unless params==nil
      params_json= JSON.generate(params) 
    end
    for_exec<< " '#{params_json}'"
    
    @result={:result=>`#{for_exec}`, :curl=>"#{for_exec}"}
    result=@result[:result]
    puts result
    if result.include?("No route matches")
      #puts "#{ARGV[0]} #{ARGV[1]} no route for given parameter"
      puts "#{args[0]} #{args[1]} no route for given parameter"
    elsif result.include?("HTTP STATUS: 500") || result.include?("HTTP STATUS: 200")
      #puts "#{ARGV[0]} #{ARGV[1]} : ok"
      puts "#{args[0]} #{args[1]} : ok"
    else 
      puts "#{for_exec}: something is unclear, please check"
    end
  end
end