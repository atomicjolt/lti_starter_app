# run with:
# rails new my_app -m ./lti_starter_app/template.rb
# rails new my_app -m https://raw.githubusercontent.com/atomicjolt/lti_starter_app/master/template.rb

require "fileutils"
require "securerandom"

# repo = "git@github.com:atomicjolt/lti_starter_app.git"
repo = "https://github.com/atomicjolt/lti_starter_app.git"
# repo = "git@bitbucket.com:atomicjolt/lti_starter_app.git"

# keep track if the initial directory
@working_dir = destination_root

###########################################################
#
# Overrides
#
def source_paths
  paths = Array(super) +
    [__dir__]
  paths << @working_dir
  paths
end

###########################################################
#
# Helper methods
#
def git_repo_url
  @git_repo_url ||= ask_with_default("What is the Github or bitbucket remote URL for this project?", :blue, "skip")
end

def git_repo_specified?
  git_repo_url != "skip" && !git_repo_url.strip.empty?
end

def gsub_file(path, regexp, *args, &block)
  content = File.read(path).gsub(regexp, *args, &block)
  File.open(path, "wb") { |file| file.write(content) }
end

def ask_with_default(question, color, default)
  return default unless $stdin.tty?

  question = (question.split("?") << " [#{default}]?").join
  answer = ask(question, color)
  answer.to_s.strip.empty? ? default : answer
end

def app_dir
  @working_dir.split("/").last
end

###########################################################
#
# Gather information
#
app_name = app_dir
url_safe_name = app_name.parameterize.gsub("-", "").gsub("_", "")
git_repo_url
rails_port = ask_with_default("Port for Rails?", :blue, 3000)
assets_port = ask_with_default("Port for assets server?", :blue, 8000)

###########################################################
#
# Clone and add remote
#
FileUtils.rm_rf("#{@working_dir}/.")               # Get rid of the rails generated code.
run "cd .. && git clone #{repo} #{@working_dir}"   # Replace it with our repo.
git remote: "set-url origin #{git_repo_url}" if git_repo_specified?
git remote: "add upstream #{repo}"

###########################################################
#
# Database.yml
#
inside "config" do
  copy_file "database.yml.example", "database.yml"
end

###########################################################
#
# secrets.yml
#
inside "config" do
  copy_file "secrets.yml.example", "secrets.yml"

  gsub_file("secrets.yml", "<Run rake secret to get a value to put here>") do |_match|
    SecureRandom.hex(64)
  end
end

###########################################################
#
# .env
#
create_file ".env" do
  <<~EOF
    APP_SUBDOMAIN=#{url_safe_name}
    APP_ROOT_DOMAIN=atomicjolt.xyz
    APP_PORT=#{rails_port}
    APP_DEFAULT_CANVAS_URL=https://atomicjolt.instructure.com

    # Get developer id and key from canvas
    CANVAS_DEVELOPER_ID=1234
    CANVAS_DEVELOPER_KEY=1234
  EOF
end

###########################################################
#
# Modify application name
#
allowed = [".rb", ".js", ".yml", ".erb", ".json", ".md", ".jsx", ".example"]
modify_files = Dir.glob("#{@working_dir}/**/*").reject { |f| File.directory?(f) || allowed.exclude?(File.extname(f)) }
modify_files << ".env"
modify_files << "Gemfile"
modify_files << ".ruby-gemset"
modify_files << "./bin/bootstrap"

modify_files.each do |f|
  gsub_file(f, "lti_starter_app") do |_match|
    app_name.underscore
  end

  gsub_file(f, "ltistarterapp") do |_match|
    app_name.titleize.gsub(" ", "")
  end

  gsub_file(f, "LtiStarterApp") do |_match|
    app_name.titleize.gsub(" ", "")
  end

  gsub_file(f, "ltistarterapp") do |_match|
    url_safe_name
  end

  gsub_file(f, "LTI Starter App") do |_match|
    app_name.titleize
  end

  gsub_file(f, "HelloWorld") do |_match|
    app_name.titleize.gsub(" ", "")
  end

  gsub_file(f, "Hello World") do |_match|
    app_name.titleize
  end

  gsub_file(f, "HELLOWORLD") do |_match|
    app_name.underscore.upcase
  end

  gsub_file(f, "hello_world") do |_match|
    app_name.underscore
  end

  gsub_file(f, "helloworld") do |_match|
    url_safe_name
  end
end

def rename_file(f)
  if f.include?("hello_world")
    File.rename(f, f.gsub("hello_world", app_name.underscore))
  end
end

# Rename dirs
Dir.glob("#{@working_dir}/**/*").each do |f|
  if File.directory?(f)
    rename_file(f)
  end
end

# Renname File
Dir.glob("#{@working_dir}/**/*").each do |f|
  unless File.directory?(f)
    rename_file(f)
  end
end

###########################################################
#
# Install Gems
#

begin
  require "rvm"

  RVM.gemset_create url_safe_name

  begin
    RVM.gemset_use! url_safe_name

    run "gem install bundler"
    run "bundle install"
  rescue StandardError => e
    puts "Unable to use gemset #{url_safe_name}: #{e}"
  end
rescue LoadError
  puts "RVM gem is currently unavailable."
end

###########################################################
#
# npm install
#
run "yarn"

###########################################################
#
# Initialize the database
#
rake("db:create")
rake("db:setup")
rake("db:seed")

###########################################################
#
# Commit changes to git
#
git add: "."
git commit: "-a -m 'Initial Project Commit'"
git push: "origin master" if git_repo_specified?

###########################################################
#
# Notes
#
puts "***********************************************"
puts "*"
puts "*               Notes                          "
puts "*"

puts "Start application:"
puts "rails server"
puts "yarn hot"

if !git_repo_specified?
  puts "To set your git remote repository run:"
  puts "git remote set-url origin [URL_OF_YOUR_GIT_REPOSITORY]"
end

puts "If you need API access you will need to get a Canvas ID and Secret from your Canvs instance."
puts "Get keys from here: https://atomicjolt.instructure.com/accounts/1/developer_keys"
puts "** Replace atomicjolt with your Canvas subdomain"

puts "*                                             *"
puts "***********************************************"
