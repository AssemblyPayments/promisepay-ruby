# Management methods for environment variables used in {Default}
module EnvironmentVariables
  def self.clean_up
    Promisepay::Configurable.keys.each do |key|
      instance_variable_set(:"@cached_#{key}", ENV.delete("PROMISEPAY_#{key.upcase}"))
    end
  end

  def self.restore
    Promisepay::Configurable.keys.each do |key|
      ENV["PROMISEPAY_#{key.upcase}"] = instance_variable_get(:"@cached_#{key}")
    end
  end
end
