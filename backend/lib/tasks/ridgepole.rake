# frozen_string_literal: true

# NOTE: 以下のようなコマンドを毎回実行するのは面倒なので、rakeタスクにする
# [bundle exec ridgepole -c config/database.yml -E development -f db/Schemafile --apply]
namespace :ridgepole do
  desc 'ridgepole --apply'
  task apply: :environment do
    ridgepole!('--apply')
    Rake::Task['db:schema:dump'].invoke
  end

  private

  def schemafile
    Rails.root.join('db/Schemafile')
  end

  def configfile
    Rails.root.join('config/database.yml')
  end

  def ridgepole!(*args)
    options.each do |option|
      system "bundle exec ridgepole #{[option + args].join(' ')}"
    end
  end

  def options
    common_options = [
      ["-E #{Rails.env}", "-c #{configfile}", "-f #{schemafile}"]
    ]
    return common_options unless Rails.env.development?

    common_options.push ['-E test', "-c #{configfile}", "-f #{schemafile}"]
  end
end
