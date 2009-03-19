class BookingController < ApplicationController
  def index
    render :new
  end
  
  def new
    @booking = Booking.new
    @booking.people << Adult.new
    @booking.date_ranges.build
  end
  
  def create
    @booking = Booking.new params[:booking]
    if @booking.save
      flash[:notice] = 'Booking was successfully created.'
      redirect_to @booking
    else
      render :action => "new"
    end
  end

  def show
    @booking = Booking.find params[:id]
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