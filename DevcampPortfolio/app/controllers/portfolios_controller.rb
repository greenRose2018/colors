class PortfoliosController < ApplicationController
  before_action :set_portfolio_item, only: [:edit, :update, :show, :destroy]
  layout 'portfolio'
  access all: [:show, :index, :angular], user: {except: [:destroy, :new, :create, :update, :edit, :sort]}, site_admin: :all

  
  def index
    @portfolio_item = Portfolio.by_position
  end
  
    def sort
    params[:order].each do |key, value|
      Portfolio.find(value[:id]).update(position: value[:position])
    end

    render nothing: true
  end
  
  def angular
    @angular_portfolio_item = Portfolio.angular
  end
  
  def rails
    @rails_portfolio_item = Portfolio.rails
  end
  
  def new
    @portfolio_item = Portfolio.new
    3.times { @portfolio_item.technologies.build }
  end
  
  def create
    @portfolio_item = Portfolio.new(portfolio_params)

    respond_to do |format|
      if @portfolio_item.save
        format.html { redirect_to portfolios_path, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @portfolio_item }
      else
        format.html { render :new }
        format.json { render json: @portfolio_item.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    


  end
  
  def update
    
    respond_to do |format|
      if @portfolio_item.update(portfolio_params)
        format.html { redirect_to portfolios_path, notice: 'The record successfully updated.' }
        format.json { render :show, status: :ok, location: portfolios_path }
      else
        format.html { render :edit }
        format.json { render json: portfolios_path.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
  end
  
  def destroy
    #Perform the lookup
    
    
    #Destroy/delete the record
    @portfolio_item.destroy
    
    #Redirect
    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: 'Record was removed.' }
      format.json { head :no_content }
    end
  end
  
  private
  
  def portfolio_params
    params.require(:portfolio).permit(:title,
                                      :subtitle,
                                      :body,
                                      technologies_attributes: [:name]
                                      )
  end
  def set_portfolio_item
    @portfolio_item = Portfolio.find(params[:id])
  end
end
