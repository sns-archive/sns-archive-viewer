# frozen_string_literal: true

class HardWorker
  include Sidekiq::Worker

  def perform(name, count)
    puts 'Doing hard work: name=' + name + ', count=' + count.to_s
  end
end
