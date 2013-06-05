module ApplicationHelper
  def with_params_for(code, value)
   current_params = params["q"].except(code)
   "/meetings?utf8=%E2%9C%93&q[#{code}]=#{value}&commit=Search" +
     current_params.map { |cp| "q[#{cp}]=#{params['q'][cp]}" }
 end
end
