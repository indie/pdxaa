class MeetingsController < ApplicationController
  # GET /meetings
  # GET /meetings.json
  def index
  #   @meetings = Meeting.all
    @search = Meeting.search(params[:q]) 
    @meetings = @search.result 
    # @meetings = Meeting.order(:name)
    respond_to do |format|
      format.html # index.html.erb
      format.txt  { render csv: @meetings.to_csv }   # make data render txt in browser -- might work, might not   
      format.csv { send_data @meetings.to_csv } # make csv data exportable
      format.xls  # { send_data @meetings.to_csv(col_sep: "\t") }
      format.json { render json: @meetings }
    end
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

  # kinda AJAX search
  def add_ajax
    Meeting.create ( { :name => params[:meeting][:name],
      :day => params[:meeting][:day],
      :city => params[:meeting][:city],
      :codes => params[:meeting][:codes],
      :address => params[:meeting][:address] } )
  end

  def search_ajax
    @meetings = Meeting.find( :all,
      :conditions => [ "name LIKE ?",
         "%#{params[:meeting][:name]}%" ] )
    render :layout=>false 
  end
  # # # # # # # # # # # # # # # # # # 



end