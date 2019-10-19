require 'json'

class Jscallback
  def initialize context
    @context = context
  end

  def onReceiveValue json
    Java::android.util.Log.i "Prototip", "Jscallback#onReceiveValue: #{json}"
    value = JSON.load( json, nil, symbolize_names: true )

    @context.toast "Received value: #{value.inspect}"
  end
end
