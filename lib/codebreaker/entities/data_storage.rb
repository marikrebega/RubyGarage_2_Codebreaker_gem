# frozen_string_literal: true

module Codebreaker
  module Entities
    class DataStorage
      FILE_NAME = 'database/data.yml'

      def create
        File.new(FILE_NAME, 'w')
        File.write(FILE_NAME, [].to_yaml)
      end

      def load
        File.file?(FILE_NAME) ? YAML.load_file(File.open(FILE_NAME, 'r')) : File.open(FILE_NAME, 'w') {}
      end

      def read_library(path = LIBRARY_NAME)
        File.file?(path) ? YAML.load_file(File.open(path, 'r')) : File.open(path, 'w') {}
      end

      def save(object)
        File.open(FILE_NAME, 'w') { |file| file.write(YAML.dump(object)) }
      end

      def storage_exist?
        File.exist?(FILE_NAME)
      end

      def save_game_result(object)
        create unless storage_exist?
        save(load.push(object))
      end
    end
  end
end
