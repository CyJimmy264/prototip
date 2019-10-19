require 'json'

class Jsi
  attr_accessor :context

  def table_json_filename
    "#{context.files_dir.path}/table.json"
  end

  def json_arg(j)
    obj = JSON.load(j)

    File.open(table_json_filename, 'w+') do |f|
      f.write(obj.to_json)
    end

    obj.to_json
  end

  def json_read
    json = nil

    if File.exist?(table_json_filename)
      File.open(table_json_filename, 'r') do |f|
        json = JSON.load(f)
      end
    end

    json
  end

  def json_arg_return
    json = json_read

    json.nil? ? nil : json.to_json
  end

  def calculate
    indicators = json_read.map {|k, v| [k, v.to_i] }.reduce({}) { |r, s| r.merge! ({s[0] => s[1]}) }

    total_sum = indicators.values.reduce(:+)

    left_sum = indicators.values_at(*(indicators.keys.grep /left/)).reduce(:+)
    right_sum = indicators.values_at(*(indicators.keys.grep /right/)).reduce(:+)

    hands_sum = indicators.values_at(*(indicators.keys.grep /^h/)).reduce(:+)
    foots_sum = indicators.values_at(*(indicators.keys.grep /^f/)).reduce(:+)

    yin_sum = indicators.values_at(*(indicators.keys.grep /[1-3]/)).reduce(:+)
    yang_sum = indicators.values_at(*(indicators.keys.grep /[4-6]/)).reduce(:+)

    total_mean = total_sum.to_f / 24
    k_lr = left_sum.to_f / right_sum.to_f
    k_hf = hands_sum.to_f / foots_sum.to_f
    k_yy = yin_sum.to_f / yang_sum.to_f

    calculations = {
      'total_sum'  => total_sum.to_s,
      'total_mean' => "%.4f" % total_mean,
      'left_sum'   => left_sum.to_s,
      'right_sum'  => right_sum.to_s,
      'k_lr'       => "%.4f" % k_lr,
      'hands_sum'  => hands_sum.to_s,
      'foots_sum'  => foots_sum.to_s,
      'k_hf'       => "%.4f" % k_hf,
      'yin_sum'    => yin_sum.to_s,
      'yang_sum'   => yang_sum.to_s,
      'k_yy'       => "%.4f" % k_yy,
    }

    context.toast JSON.generate(calculations)
    JSON.generate(calculations)
  end
end
