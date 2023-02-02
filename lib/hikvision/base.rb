module Hikvision
  class Base
    class << self
      private

      def add_xml(method, url_path, xml_path)
        iv = :"@#{method}_xml"
        method = :"load_#{method}"
        define_method method do |options = {}|
          return instance_variable_get(iv) if options.fetch(:cache, true) && instance_variable_defined?(iv)

          url = url_path.respond_to?(:call) ? instance_exec(&url_path) : url_path
          instance_variable_set(iv, @isapi.get_xml(url, options).at_xpath(xml_path))
        end
      end

      def add_getter(method, xml_method, path, opts = { cache: true }, &block)
        define_method method do
          v = send(:"load_#{xml_method}", opts).at_xpath(path).inner_html
          v = block.call(v) if block
          v
        end
      end

      def add_list_getter(method, xml_method, path, transform)
        define_method method do
          send(:"load_#{xml_method}", cache: true).xpath(path).map { |v| v.inner_html.send(transform) }
        end
      end

      def add_opt_getter(method, xml_method, path, transform)
        define_method method do
          send(:"load_#{xml_method}", cache: true).at_xpath(path)[:opt].split(',').map { |v| v.send(transform) }
        end
      end

      def add_opt_range_getter(method, xml_method, path)
        define_method method do
          data = send(:"load_#{xml_method}", cache: true).at_xpath(path)
          data[:min].to_i..data[:max].to_i
        end
      end

      def add_bool_getter(method, xml_method, path)
        define_method method do
          send(:"load_#{xml_method}", cache: true).at_xpath(path).inner_html == 'true'
        end
      end

      def add_setter(method, xml_method, path, *types, &block)
        define_method method do |value|
          raise TypeError, "#{method}#{value} (#{value.class}) must be of type #{types}" unless types.include?(value.class)

          value = block.call(value) if block
          send(:"load_#{xml_method}", cache: true).at_xpath(path).inner_html = value.to_s
        end
      end
    end
  end
end
