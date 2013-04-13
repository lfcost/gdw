class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  

 #region start Index 
  def index
    if params[:ratings]
      @ratings = params[:ratings]
    end
    if params[:orderby]
        @orderby=params[:orderby]        
        columns = {'title'=>'title', 'release_date'=>'release_date'}
          if columns.has_key?(@orderby) then            
            query = Movie.order([@orderby])
            if @orderby =='title'
              @klassT='hilite'
            end
            if @orderby=='release_date'
              @klassR='hilite'
            end
          else
            query= Movie
            @orderby = nil            
            @klassT=''
            klassR=''
          end
      else
         query  = Movie
      end
      @movies = @ratings.nil? ? query.all : query.find_all_by_rating(@ratings.map { |r| r[0] })
      @all_ratings = Movie.ratings  
  end
#region end Index
  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end