module Hikvision
  class Base
    def self.add_getter(method, xml, path, transform)
      define_method method do
        begin
          instance_variable_get(xml).at_xpath(path).inner_html.send(transform)
        rescue
          nil
        end
      end
    end

    def self.add_list_getter(method, xml, path, transform)
      define_method method do
        begin
          instance_variable_get(xml).xpath(path).map { |v| v.inner_html.send(transform) }
        rescue
          nil
        end
      end
    end

    def self.add_opt_getter(method, xml, path, transform)
      define_method method do
        begin
          instance_variable_get(xml).at_xpath(path)[:opt].split(',').map { |v| v.send(transform) }
        rescue
          nil
        end
      end
    end

    def self.add_opt_range_getter(method, xml, path)
      define_method method do
        begin
          instance_variable_get(xml).at_xpath(path)[:min].to_i..@cxml.at_xpath(path)[:max].to_i
        rescue
          nil
        end
      end
    end

    def self.add_bool_getter(method, xml, path)
      define_method method do
        begin
          instance_variable_get(xml).at_xpath(path).inner_html == 'true'
        rescue
          nil
        end
      end
    end

    def self.add_setter(method, xml, path, types)
      define_method method do |value|
        raise TypeError, "#{method}#{value} (#{value.class}) must be of type #{types}" unless types.include?(value.class)

        instance_variable_get(xml).at_xpath(path).inner_html = value.to_s
      end
    end
  end
end
