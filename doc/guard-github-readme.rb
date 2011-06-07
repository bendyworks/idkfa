require 'fileutils'
require 'RedCloth'

module ::Guard
  class GithubReadme < ::Guard::Guard

    def this_dir
      File.expand_path('..', __FILE__)
    end

    def start
      FileUtils.cp "#{this_dir}/bundle_github.css", '/tmp/bundle_github.css'
      true
    end

    def run_all
      true
    end

    def run_on_change(paths)
      paths.each do |path|
        html = RedCloth.new(File.read(path)).to_html
        github = File.read("#{this_dir}/github.html")
        File.open('/tmp/textile-preview.html', 'w') do |f|
          f.puts github.sub(/INSERT_BODY/, html)
        end
      end
      puts 'compiled textile'
      true
    end
  end
end
