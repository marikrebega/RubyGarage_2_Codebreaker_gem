# frozen_string_literal: true

module Codebreaker
  module Entities
    class DataStorage
      FILE_DIRECTORY = 'database'
      FILE_NAME = 'data.yml'

      def create
        ensuring_directory_availability
        File.new(File.join(FILE_DIRECTORY, FILE_NAME), 'w')
        File.write(File.join(FILE_DIRECTORY, FILE_NAME), [].to_yaml)
      end

      def load
        YAML.safe_load(File.open(File.join(FILE_DIRECTORY, FILE_NAME)), [Symbol, Time]) if storage_exist?
      end

      def save(object)
        File.open(File.join(FILE_DIRECTORY, FILE_NAME), 'w') { |file| file.write(YAML.dump(object)) }
      end

      def storage_exist?
        File.exist?(File.join(FILE_DIRECTORY, FILE_NAME))
      end

      def save_game_result(object)
        create unless storage_exist?
        save(load.push(object))
      end

      private

      def ensuring_directory_availability
        Dir.mkdir(FILE_DIRECTORY) unless Dir.exist?(FILE_DIRECTORY)
      end
    end
  end
end
