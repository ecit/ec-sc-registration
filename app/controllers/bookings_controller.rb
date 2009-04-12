class BookingsController < ApplicationController
  def index
    redirect_to :action => "new"
  end
  
  def new
    @booking = Booking.new
    @booking.people << Adult.new
    @booking.date_ranges.build
  end
  
  def create
    @booking = Booking.new params[:booking]

    #@booking.date_ranges[1..params[:booking][:new_date_range_attributes].length].each {|date_range| @booking.date_ranges.delete(date_range) if (@booking.date_ranges - date_range).include?(date_range)}
    @booking.people[1..params[:booking][:new_person_attributes].length].each {|person|
        @booking.people.delete(person) if (person.first_name.empty? and person.last_name.empty?)
    }
    
    if @booking.save
      flash[:notice] = 'Booking was successfully created.'
      redirect_to @booking
    else
      @errors = true
      render :action => "new"
    end
  end

  def show
    @booking = Booking.find params[:id]
  end
  
  def edit
    if params[:code]
      @booking = Booking.find_by_code params[:code]
    else
      @booking = Booking.find params[:id]
    end
    render :action => "new"
  end
  
  def update 
    params[:project][:existing_task_attributes] ||= {} 
    @project = Project.find(params[:id]) 
    if @project.update_attributes(params[:project]) 
      flash[:notice] = "Successfully updated project and tasks." 
      redirect_to project_path(@project) 
    else 
      render :action => 'edit' 
    end 
  end 

  
  def add_date_range
    @additional_date_range = true
    
    render :update do |page|
      page.insert_html :bottom, :date_ranges, :partial => 'date_range', :object => DateRange.new
      page.visual_effect :highlight, :date_ranges
    end
  end

  def add_person
    @group = true
    @person = params[:kind] == 'child' ? Child.new : Adult.new
    
    render :update do |page|
      page.insert_html :bottom, :people, :partial => 'person', :object => @person
      page.visual_effect :highlight, :people
    end
  end
end