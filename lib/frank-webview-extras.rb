require "frank-webview-extras/version"

require 'frank-cucumber/frank_helper'
require "coffee-script"

puts "ªªª Yo — WebView-Extras ººº"

if defined? Frank::Console
	$DEBUG_FRANK_WEBVIEW_EXTRAS = false
end

module WebView
	extend Frank::Cucumber::FrankHelper

	def self.run (query, options={}) # class method
		
		raise TypeError, "Query «#{query.inspect}» is not a String" if not query.is_a? String
		raise TypeError, "Options «#{options.inspect}» is not a Hash" if not options.is_a? Hash

		options = {
			:coffeescript => (true and not options.any? { |key, value|
				key.to_s.downcase.include?("coffee") and value === false
			}), 
			:function_necesarry => true
		}.merge(options)

		if options[:coffeescript]
			script = CoffeeScript.compile(query, :bare => true)
			puts "Compiled coffeescript. length: #{script.length}" if self.DEBUG
		else
			script = query
			puts "Not coffeescript. length: #{script.length}" if self.DEBUG
		end
		
		puts( options.inspect ) if self.DEBUG

		unless script.include? "function"
			puts "No function. length: #{script.length}" if self.DEBUG
			if options[:coffeescript]
				puts "Wrapping CoffeeScript in function"
				script = CoffeeScript.compile(%Q[do -> \\] + "\n\n\n" + query, :bare => true)
			else
				raise "JavaScript not wrapped in a function" if options[:function_necesarry]
			end
		end

		messenger = coffee_file("messenger", { "script" => script })
		puts messenger if self.DEBUG

		map = frankly_map(
			"view:'UIWebView' index:0", 
			"stringByEvaluatingJavaScriptFromString:", 
			messenger
		).first

		unless map == ""
			unless map.nil?
				return JSON.parse map
			else
				raise "No UIWebView found."
			end
		else
			raise "WebView returned nothing. Possibly invalid javascript…"
		end
	end

	def self.run_js (script, options={})
		run script, {:coffeescript => false, :function_necesarry => false}.merge(options)
	end

	def self.coffee (script) # class method
		CoffeeScript.compile script, :bare => true
	end


	def self.coffee_file (name, insertables={})
		file = File.read("#{File.dirname(__FILE__)}/coffee/#{name}.coffee")
		
		file = CoffeeScript.compile file, :bare => true

		# We could do the substitution two ways:
		# 	We could use a hash will all the possible insertable values.
		file = file.gsub( /insertable\#\{(.+)\}/ ) { 
			if insertables.has_key?($1.to_s) then insertables[$1].to_s else raise("key «#{$1}» not in insertables") end 
		}
		
		# Or we could use eval, which some consider unsafe (unclear in these circumstances)
		file = file.gsub( /eval\#\{(.+)\}/) { "#{eval $1}" }

		return file
	end

	def self.run_coffee_file (name, insertables={})
		file = File.read("#{File.dirname(__FILE__)}/coffee/#{name}.coffee")
		
		file = CoffeeScript.compile file, :bare => true

		# We could do the substitution two ways:
		# 	We could use a hash will all the possible insertable values.
		file = file.gsub( /insertable\#\{(.+)\}/ ) { 
			if insertables.has_key?($1.to_s) then insertables[$1].to_s else raise("key «#{$1}» not in insertables") end 
		}
		
		# Or we could use eval, which some consider unsafe (unclear in these circumstances)
		file = file.gsub( /eval\#\{(.+)\}/) { "#{eval $1}" }

		run file, {:coffeescript => false}
	end

	def self.outerHTML (query) # class method
		script = CoffeeScript.compile(query, :bare => true)
		iterate(script, {:property => 'outerHTML'})
	end

	def self.click (query) # class method
		script = CoffeeScript.compile(query, :bare => true)
		iterate(script, {:functions => ['outerHTML.length', 'click']})
	end

	def self.iterate (query, options={:property => 'outerHTML'})
		def self.check (arr)
			arr.delete_if { |el|
				if el.nil?
					true 
				elsif not el.is_a? String
					raise TypeError, "`#{el}` is not a String."
					true
				end
			}
			return arr
		end
		check [ query ]
		props = check [ options[:property], options[:properties] ].flatten
		funcs = check [ options[:function], options[:functions]  ].flatten

		json_options = JSON.generate( {
			'properties' => props,
			'functions' => funcs
			} )

		puts [ query, json_options.inspect ] if self.DEBUG
		
		run_coffee_file "iterate", {'query' => query, 'json_options.inspect' => json_options.inspect }

	end

	def hello # instance method
		puts "Annyong!"
	end

	def self.DEBUG
		false or (Frank::Console if $DEBUG or $DEBUG_FRANK_WEBVIEW_EXTRAS )
	end

end