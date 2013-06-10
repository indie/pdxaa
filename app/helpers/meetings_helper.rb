module MeetingsHelper
 def with_params_for(code, value)
  current_params = params["q"].except(code)
  "/meetings?utf8=%E2%9C%93&q[#{code}]=#{value}&commit=Search&" +
    current_params.map { |cp| "q[#{cp}]=#{params['q'][cp]}" }.join("&")
  end

  # param_type :day_cont link_val mon stored_vals in session
  def render_link(param_type, link_val, stored_vals)
    link = "/meetings?utf8=%E2%9C%93&q[#{param_type}]=#{link_val}"
    if link_val == "W" 
    	link += "&q[codes_not_cont]=Wh"
    end
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
end