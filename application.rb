require 'rubygems'
require 'bundler/setup'
require 'sinatra' unless defined?(Sinatra)

configure do
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
  Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") { |lib| require File.basename(lib, '.*') }

  set :views, "#{File.dirname(__FILE__)}/views"
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

helpers do
  # add your helpers here
end

# root page
get '/' do
  @title = 'Create a WordSearch'
  @words = []
  haml :root
end

post '/' do
  @words  = Word.parse(params.delete('words'))
  @errors = @words.empty? or (not @words.all?(&:valid?))

  if @errors
    haml :root
  else
    @wordsearch = Wordsearch.new(@words, params)
    @wordsearch.build

    @title = @wordsearch.title

    haml :wordsearch
  end

end
