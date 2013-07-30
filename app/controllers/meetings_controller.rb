class MeetingsController < ApplicationController
  before_filter :authorize, only: [:edit, :update, :new, :destroy]
  # GET /meetings
  # GET /meetings.json
  
  def index 
    if not session[:meeting_params] 
      session[:meeting_params] = {}
    end
    @meeting_params = session[:meeting_params]
    if params[:q]
      @first = true 
      (params[:q]).each do |key, value|
        if @first == true and session[:meeting_params][key] == value
          session[:meeting_params].delete(key) 
          params[:q].delete(key)
        else  
          session[:meeting_params][key]=value
        end
        @first = false 
        end
        if params[:q].include? :name_or_day_or_address_or_city_or_notes_or_codes_cont
          # session.delete(:meeting_params)
          (session[:meeting_params]).each do | key, value | 
            session[:meeting_params].delete key
          end
        end  

    end

    @extra_q = session[:meeting_params]

    @param_data = {
      "day_cont" => {
        "Monday" => "Monday",
        "Tuesday" => "Tuesday",
        "Wednesday" => "Wednesday",
        "Thursday" => "Thursday",
        "Friday" => "Friday",
        "Saturday" => "Saturday",
        "Sunday" => "Sunday"}, 

# Obviously any custom CMS would need to manually change this library

      "city_cont" => {
        "Campbell" => "Campbell", 
        "Cupertino" => "Cupertino", 
        "Gilroy" => "Gilroy",
        "Los Altos" => "Los Altos", 
        "Los Gatos" => "Los Gatos", 
        "Milpitas" => "Milpitas", 
        "Morgan Hill" => "Morgan Hill", 
        "Mountain View" => "Mountain View", 
        "Palo Alto" => "Palo Alto",
        "SJ, South" => "San Jose, South",
        "SJ, North" => "San Jose, North", 
        "SJ, Downtown" => "San Jose, Downtown", 
        "SJ, Willow Glen" => "San Jose, Willow Glen", 
        "SJ, East" => "San Jose, East", 
        "San Martin" => "San Martin", 
        "Santa Clara" => "Santa Clara", 
        "Saratoga" => "Saratoga", 
        "Sunnyvale" => "Sunnyvale"}, 

      "codes_cont" => {
        "Open" => "O",
        "Closed" => "C",
        "Men" => "M",
        "Women" => "W",
        "Gay" => "G",
        "Lesbian" => "L",
        "Spanish" => "S",
        "Wheelchair Access" => "Wh",
        "Young People" => "Y"}
      }

    @q = Meeting.search(params[:q])

    @search = Meeting.search(params[:q]) 
    @meetings = @search.result(:distinct => true).order('day asc')

    respond_to do |format|
      format.html # index.html.erb
      format.txt { render txt: @meetings.to_csv } # make data render txt in browser -- might work, might not
      format.csv { send_data @meetings.to_csv } # make csv data exportable
      format.xls # { send_data @meetings.to_csv(col_sep: "\t") }
      format.json { render json: @meetings }
    end
  end

  def clear_options
      # session.delete(:meeting_params)
      (session[:meeting_params]).each do | key, value | 
        session[:meeting_params].delete key
      end
      redirect_to meetings_path
  end
  
  def import 
    Meeting.import(params[:file])
    redirect_to meetings_path, notice: "Meetings imported successfully"
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    @meeting = Meeting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meeting }
    end
  end

  # GET /meetings/new
  # GET /meetings/new.json
  def new
    @meeting = Meeting.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meeting }
    end
  end

  # GET /meetings/1/edit
  def edit
    @meeting = Meeting.find(params[:id])
    @title = "Edit" 
   end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(params[:meeting])

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
        format.json { render json: @meeting, status: :created, location: @meeting }
      else
        format.html { render action: "new" }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meetings/1
  # PUT /meetings/1.json
  def update
    @meeting = Meeting.find(params[:id])

    respond_to do |format|
      if @meeting.update_attributes(params[:meeting])
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json

  def destroy
    @meeting = Meeting.find(params[:id])
    @meeting.destroy

    respond_to do |format|
      format.html { redirect_to meetings_url }
      format.json { head :no_content }
    end
  end

end