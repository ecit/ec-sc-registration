class BookingController < ApplicationController
  def index
    render :new
  end
  
  def new
    @booking = Booking.new
    @booking.people.build
    @booking.date_ranges.build
  end
  
  def create
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
    @kind = params[:kind]
    
    render :update do |page|
      page.insert_html :bottom, :people, :partial => 'person', :object => Person.new
      page.visual_effect :highlight, :people
    end
  end
end