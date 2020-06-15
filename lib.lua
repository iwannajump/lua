local https    = require "dependencies/https"
local ltn12    = require "dependencies/ltn12"
local dkjson   = require "dependencies/dkjson"

local function to_vkvalues( table1 )
   local result = {}
   for key, value in pairs(table1) do
      if type(value) == "table" then
         value = table.concat(value, ",")
      end
      result[key] = value
   end
   return result
end

local function make_query_string( params )
   local params_pairs = {}
   for key, value in pairs(params) do
      table.insert(params_pairs, key .. "=" .. value)
   end
   return table.concat(params_pairs, "&")
end

function request( url, params )
   local vkvalues_params = to_vkvalues(params)
   local query_string = make_query_string(vkvalues_params)
   local response = {}

   https.request
   {
      url = url,
      method = "POST",
      headers =
      {
            ["Content-Type"] = "application/x-www-form-urlencoded",
            ["Content-Length"] = #query_string
      },
      source = ltn12.source.string(query_string),
      sink = ltn12.sink.table(response)
   }

   local response_text = table.concat( response )

   return dkjson.decode( response_text, 1, true )
end

local function merge_tables( table1, table2 )
   local result = {}

   for key, value in pairs(table1) do
      result[key] = value
   end

   for key, value in pairs(table2) do
      result[key] = value
   end

   return result
end

function call( account, method_name, params )
   local required_params = { access_token = account.access_token, v = account.api_version, peer_id = account.peer }
   local all_params = merge_tables(required_params, params)
   return request("https://api.vk.com/method/" .. method_name, all_params)
end

function answer_not_empty( answer )
   if    answer and
         answer["updates"] and
         answer["updates"][1] and
         answer["updates"][1]["object"]["message"] then
      return true
   end   
end

function get_lp_server()
   return call(account, "groups.getLongPollServer", { group_id = "192764727" })
end

function send_message( account, text )
   call(account, "messages.send", { message = text })
end

function send_media( m_type, account, pic_owner_id, pic_id )
   call(account, "messages.send", { attachment = m_type .. pic_owner_id .. "_" .. pic_id })
end

function translate ( params )
   local required_params = { key = account.yandex_key }
   local all_params = merge_tables(required_params, params)
   return request("https://translate.yandex.net/api/v1.5/tr.json/translate?", all_params)
end

function weather ( params )
   local required_params = { key = account.weather_key, format = "json" }
   local all_params = merge_tables(required_params, params)
   return request("http://api.worldweatheronline.com/premium/v1/weather.ashx?", all_params)
end
