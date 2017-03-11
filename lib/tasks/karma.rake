namespace :karma  do
  task :start => :environment do
    with_tmp_config :start
  end

  task :run => :environment do
    exit with_tmp_config :start, "--single-run"
  end

  private

  def with_tmp_config(command, args = nil)
    # Change to [.., '.coffee'] for any CS config files
    Tempfile.open(['karma_unit', '.js'], Rails.root.join('tmp')) do |f|
      f.write unit_js
      f.flush

      exec("./node_modules/karma/bin/karma #{command} spec/karma/config.js #{args}")
    end
  end

  def unit_js
    unit_js = File.open('spec/karma/config.js', 'r').read
  end
end
