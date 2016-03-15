require 'mail'

if Gem::Version.new(Mail::VERSION.version) < Gem::Version.new('2.6')
  Mail::Field.class_exec do
    original_method = instance_method(:create_field)
    define_method(:create_field) do |name, value, charset|
      value = value.gsub(/[\r\n \t]+/m, ' ') if value.is_a?(String)
      original_method.bind(self).call(name, value, charset)
    end
  end
end
