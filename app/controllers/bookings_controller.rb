class BookingsController < ApplicationController
  before_filter :set_first, :only => [:new, :edit]
  
  def index
    redirect_to :action => 'new'
  end

  def show
    @booking = Booking.find_by_code params[:id]
    @days = 0
    @booking.date_ranges.each {|date_range| @days += date_range.nr_of_days}
  end
  
  def new
    @booking = Booking.new
    @booking.adults << Adult.new
    @booking.date_ranges.build
  end
  
  def create
    @booking = Booking.new params[:booking]
    if @booking.save
      redirect_to @booking
    else
      set_first
      render :new
    end
  end
  
  def edit
    @booking = Booking.find_by_code params[:id]
  end
  
  def update
    @booking = Booking.find_by_code params[:id]
    @booking.attributes = params[:booking]
    if @booking.save
      redirect_to @booking
    else
      set_first
      render :edit
    end
  end
  
  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_url
  end
  
  private
  
  def set_first
    @first_person = true
    @first_date_range = true
  end
end