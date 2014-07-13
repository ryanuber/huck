module Cloudalogue

  # App is the main class which controls the running program.
  class App

    def self.run kwargs = {}
      gen_name = Cloudalogue::getarg kwargs, :generator, nil
      g = Generator::factory gen_name
      g.dump
    end

  end
end
