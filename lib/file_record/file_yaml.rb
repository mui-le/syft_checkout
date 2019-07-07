# frozen_string_literal: true
#
# This class handles the file load to records, this will be used as a super
# class so other classes can use the same resources.
#
# This absctract the methods:
# - all: returns all records from a given subclass
# - find(id): return the record given the id `id`
# - find_by(attr, val): return the record given the attr equals `val`
#
# On the initialization process the method initialize_from_config will read the
# file from configuration, the configuration path is read from the method
# config_path that must be implemented on the subclass.
#
# @records must be initialized on the subclass
#


require 'yaml'

module FileRecord
  class FileYaml
    class << self
      def initialize_from_config(config_path=self.config_path)
        loaded_config = YAML.load_file(config_path)

        loaded_config.each do |config|
          define_record(config.with_indiferent_access)
        end
      end

      def define_record(params)
        record = self.new(params)
        @records[record.id] = record
      end

      def all
        @records.values
      end

      def find(id)
        @records[id]
      end

      def find_by(attr, val)
        all.select{|record| record.send(attr) == val}.first
      end

      def config_path
        raise "Must be implemented on subclass"
      end
    end
  end
end
