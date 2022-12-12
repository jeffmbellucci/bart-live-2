module StationsDataHelper
BART_API_KEY = Rails.application.credentials.bart_api_key
  
  def get_station_data(abbr)
    bart_query = Addressable::URI.new(
      scheme: "http",
      host: "api.bart.gov",
      path: "api/etd.aspx",
      query_values: {
        cmd: "etd",
        orig: abbr,
        key: BART_API_KEY
      })

    response = HTTParty.get(bart_query)

    if response['root']['message']
      response['root']['message'] = "No trains at this time." 
      return response
    end

    if response['root']['station']['message']
      if response['root']['station']['message']['error'] == "Updates are temporarily unavailable."
        response['root']['message'] = "Bart is not providing updates at this time." 
        return response
      end
    end

    unless response['root']['station']['etd'].is_a?(Array)
      response['root']['station']['etd'] = [response['root']['station']['etd']]
    end

    lines = response['root']['station']['etd']
    lines.each do |line|
      line['estimate'] = [line['estimate']] unless line['estimate'].is_a?(Array)
    end
    response
  end

  def super_puts(message = 'LOOK HERE!!!', symbol = '#', message_padding = 3)
    message = message.to_s
    if message.length > 200 - 2 * message_padding || message.lines.count > 1 
      puts "\n#{symbol * 200}\n\n"
      pp message.to_s
      puts "\n#{symbol * 200}\n"
    else
      puts <<-MESSAGE
        \n
        #{symbol * (message.length + message_padding * 2 + 4)}\n
        #{symbol * message_padding}  #{message}  #{symbol * message_padding}\n
        #{symbol * (message.length + message_padding * 2 + 4)}\n
        \n
      MESSAGE
    end
  end

  def mock_data
    {"root"=>
      {"uri"=>"http://api.bart.gov/api/etd.aspx?cmd=etd&orig=embr",
      "date"=>"11/02/2022",
      "time"=>"03:45:21 PM PDT",
      "station"=>
        {"name"=>"Embarcadero",
        "abbr"=>"EMBR",
        "etd"=>
          [{"destination"=>"Antioch",
            "abbreviation"=>"ANTC",
            "limited"=>"0",
            "estimate"=>
            [{"minutes"=>"14",
              "platform"=>"2",
              "direction"=>"North",
              "length"=>"10",
              "color"=>"YELLOW",
              "hexcolor"=>"#ffff33",
              "bikeflag"=>"1",
              "delay"=>"0",
              "cancelflag"=>"0",
              "dynamicflag"=>"0"},
              {"minutes"=>"29",
              "platform"=>"2",
              "direction"=>"North",
              "length"=>"10",
              "color"=>"YELLOW",
              "hexcolor"=>"#ffff33",
              "bikeflag"=>"1",
              "delay"=>"0",
              "cancelflag"=>"0",
              "dynamicflag"=>"0"},
              {"minutes"=>"44",
              "platform"=>"2",
              "direction"=>"North",
              "length"=>"10",
              "color"=>"YELLOW",
              "hexcolor"=>"#ffff33",
              "bikeflag"=>"1",
              "delay"=>"0",
              "cancelflag"=>"0",
              "dynamicflag"=>"0"}]},
          {"destination"=>"Berryessa",
            "abbreviation"=>"BERY",
            "limited"=>"0",
            "estimate"=>
            [{"minutes"=>"3",
              "platform"=>"2",
              "direction"=>"North",
              "length"=>"10",
              "color"=>"GREEN",
              "hexcolor"=>"#339933",
              "bikeflag"=>"1",
              "delay"=>"0",
              "cancelflag"=>"1",
              "dynamicflag"=>"0"},
              {"minutes"=>"22",
              "platform"=>"2",
              "direction"=>"North",
              "length"=>"10",
              "color"=>"GREEN",
              "hexcolor"=>"#339933",
              "bikeflag"=>"1",
              "delay"=>"287",
              "cancelflag"=>"0",
              "dynamicflag"=>"0"},
              {"minutes"=>"33",
              "platform"=>"2",
              "direction"=>"North",
              "length"=>"10",
              "color"=>"GREEN",
              "hexcolor"=>"#339933",
              "bikeflag"=>"1",
              "delay"=>"0",
              "cancelflag"=>"0",
              "dynamicflag"=>"0"}]},
          {"destination"=>"Daly City",
            "abbreviation"=>"DALY",
            "limited"=>"0",
            "estimate"=>
            [{"minutes"=>"9",
              "platform"=>"1",
              "direction"=>"South",
              "length"=>"10",
              "color"=>"GREEN",
              "hexcolor"=>"#339933",
              "bikeflag"=>"1",
              "delay"=>"0",
              "cancelflag"=>"0",
              "dynamicflag"=>"0"},
              {"minutes"=>"14",
              "platform"=>"1",
              "direction"=>"South",
              "length"=>"8",
              "color"=>"BLUE",
              "hexcolor"=>"#0099cc",
              "bikeflag"=>"1",
              "delay"=>"0",
              "cancelflag"=>"0",
              "dynamicflag"=>"0"},
              {"minutes"=>"24",
              "platform"=>"1",
              "direction"=>"South",
              "length"=>"10",
              "color"=>"GREEN",
              "hexcolor"=>"#339933",
              "bikeflag"=>"1",
              "delay"=>"0",
              "cancelflag"=>"0",
              "dynamicflag"=>"0"}]},
          {"destination"=>"Dublin/Pleasanton",
            "abbreviation"=>"DUBL",
            "limited"=>"0",
            "estimate"=>
            [{"minutes"=>"9",
              "platform"=>"2",
              "direction"=>"North",
              "length"=>"9",
              "color"=>"BLUE",
              "hexcolor"=>"#0099cc",
              "bikeflag"=>"1",
              "delay"=>"0",
              "cancelflag"=>"0",
              "dynamicflag"=>"0"},
              {"minutes"=>"24",
              "platform"=>"2",
              "direction"=>"North",
              "length"=>"10",
              "color"=>"BLUE",
              "hexcolor"=>"#0099cc",
              "bikeflag"=>"1",
              "delay"=>"0",
              "cancelflag"=>"0",
              "dynamicflag"=>"0"},
              {"minutes"=>"40",
              "platform"=>"2",
              "direction"=>"North",
              "length"=>"10",
              "color"=>"BLUE",
              "hexcolor"=>"#0099cc",
              "bikeflag"=>"1",
              "delay"=>"0",
              "cancelflag"=>"0",
              "dynamicflag"=>"0"}]},
          {"destination"=>"Millbrae/SFO",
            "abbreviation"=>"SFIA",
            "limited"=>"0",
            "estimate"=>
            [{"minutes"=>"5",
              "platform"=>"1",
              "direction"=>"South",
              "length"=>"9",
              "color"=>"RED",
              "hexcolor"=>"#ff0000",
              "bikeflag"=>"1",
              "delay"=>"69",
              "cancelflag"=>"0",
              "dynamicflag"=>"0"},
              {"minutes"=>"19",
              "platform"=>"1",
              "direction"=>"South",
              "length"=>"10",
              "color"=>"RED",
              "hexcolor"=>"#ff0000",
              "bikeflag"=>"1",
              "delay"=>"0",
              "cancelflag"=>"1",
              "dynamicflag"=>"0"},
              {"minutes"=>"34",
              "platform"=>"1",
              "direction"=>"South",
              "length"=>"10",
              "color"=>"RED",
              "hexcolor"=>"#ff0000",
              "bikeflag"=>"1",
              "delay"=>"0",
              "cancelflag"=>"0",
              "dynamicflag"=>"0"}]},
          {"destination"=>"Millbrae",
            "abbreviation"=>"MLBR",
            "limited"=>"0",
            "estimate"=>
            [{"minutes"=>"15",
              "platform"=>"1",
              "direction"=>"South",
              "length"=>"10",
              "color"=>"RED",
              "hexcolor"=>"#ff0000",
              "bikeflag"=>"1",
              "delay"=>"92",
              "cancelflag"=>"0",
              "dynamicflag"=>"1"}]},
          {"destination"=>"Richmond",
            "abbreviation"=>"RICH",
            "limited"=>"0",
            "estimate"=>
            [{"minutes"=>"6",
              "platform"=>"2",
              "direction"=>"North",
              "length"=>"10",
              "color"=>"RED",
              "hexcolor"=>"#ff0000",
              "bikeflag"=>"1",
              "delay"=>"0",
              "cancelflag"=>"0",
              "dynamicflag"=>"0"},
              {"minutes"=>"21",
              "platform"=>"2",
              "direction"=>"North",
              "length"=>"9",
              "color"=>"RED",
              "hexcolor"=>"#ff0000",
              "bikeflag"=>"1",
              "delay"=>"0",
              "cancelflag"=>"0",
              "dynamicflag"=>"0"},
              {"minutes"=>"36",
              "platform"=>"2",
              "direction"=>"North",
              "length"=>"10",
              "color"=>"RED",
              "hexcolor"=>"#ff0000",
              "bikeflag"=>"1",
              "delay"=>"0",
              "cancelflag"=>"0",
              "dynamicflag"=>"0"}]},
          {"destination"=>"SF Airport",
            "abbreviation"=>"SFIA",
            "limited"=>"0",
            "estimate"=>
            [{"minutes"=>"14",
              "platform"=>"1",
              "direction"=>"South",
              "length"=>"10",
              "color"=>"YELLOW",
              "hexcolor"=>"#ffff33",
              "bikeflag"=>"1",
              "delay"=>"263",
              "cancelflag"=>"0",
              "dynamicflag"=>"0"},
              {"minutes"=>"35",
              "platform"=>"1",
              "direction"=>"South",
              "length"=>"10",
              "color"=>"YELLOW",
              "hexcolor"=>"#ffff33",
              "bikeflag"=>"1",
              "delay"=>"610",
              "cancelflag"=>"0",
              "dynamicflag"=>"0"},
              {"minutes"=>"43",
              "platform"=>"1",
              "direction"=>"South",
              "length"=>"10",
              "color"=>"YELLOW",
              "hexcolor"=>"#ffff33",
              "bikeflag"=>"1",
              "delay"=>"178",
              "cancelflag"=>"0",
              "dynamicflag"=>"0"
            }]
          }]
        },
      "message"=>nil}}
  end
end
