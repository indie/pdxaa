module Api
	module V1
		class MeetingsController < ApplicationController
			class Meeting < ::Meeting
        		# Doesn't take into consideration the create/update actions for changing day
        		def as_json(options = {})
          			super.merge(day: day.to_date)
        		end
      		end

	      respond_to :json

	      def index
	        respond_with Meeting.all
	      end

	      def show
	        respond_with Meeting.find(params[:id])
	      end

	      def create
	        respond_with Meeting.create(params[:meeting])
	      end

	      def update
	        respond_with Meeting.update(params[:id], params[:meeting])
	      end

	      def destroy
	        respond_with Meeting.destroy(params[:id])
	      end
	    end

	end
end
