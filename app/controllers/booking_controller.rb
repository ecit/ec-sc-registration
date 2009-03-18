class BookingController < ApplicationController
  def index
    render :new
  end
  
  def new
    @booking = Booking.new
  end
  
  def create
    debugger
  end
  
  def add_date_range
    @additional_date_range = true
    
    render :update do |page|
      page.insert_html :bottom, :date_ranges, :partial => 'date_range'
      page.visual_effect :highlight, :date_ranges
    end
  end

  def add_person
    @group = true
    @kind = params[:kind]
    
    render :update do |page|
      page.insert_html :bottom, :people, :partial => 'person'
      page.visual_effect :highlight, :people
    end
  end
end