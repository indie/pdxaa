module MeetingsHelper
 def with_params_for(code, value)
  current_params = params["q"].except(code)
  "/meetings?utf8=%E2%9C%93&q[#{code}]=#{value}&commit=Search&" +
    current_params.map { |cp| "q[#{cp}]=#{params['q'][cp]}" }.join("&")
  end

  # render_link renders the current link_val on the param_type key 
  # with any previously-used query
    # param_type string example ~ day_cont
    # link_val string example ~ Monday
    # stored_vals Hash -> string, string (strings as keys and values)

  def render_link(param_type, link_val, stored_vals)
    link = "/meetings?utf8=%E2%9C%93&q[#{param_type}]=#{link_val}"
    if link_val == "W" 
    	link += "&q[codes_not_cont]=Wh"
    end

  # if the key value is stored in the param type, don't redundantly include it
  # in the link 

    stored_vals.each do |key, value|
      if key == param_type
        next
      else
        link += "&q[%s]=%s" % [key, value]
      end
    end
    link += "&commit=Search"
    link
  end

  # active style can be overridden with bootstrap

  def render_css(param_type, link_val, stored_vals)
  	stored_vals.each do |key, value|
  		if stored_vals[param_type]==link_val
  			return "color:blue"
  		end 
	end 
  end
end