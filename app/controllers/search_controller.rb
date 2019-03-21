class SearchController < ApplicationController
  PAGE_COUNT = 20
  PAGINATION = 3

  def movie
    @page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @no = (@page - 1) * PAGE_COUNT
    sort = params[:sort] || 'title'
    order = params[:order] == 'desc' ? :desc : :asc

    @movies = Movie
      .where(
        "title like :query or original_title like :query",
        { :query => "%#{params[:query]}%" }
      )
      .left_outer_joins(movie_cast: :person)
      .group(:id)
      .order({ sort => order })
      .limit(PAGE_COUNT).offset((@page - 1) * PAGE_COUNT)

    count = Movie.where(
      "title like :query or original_title like :query",
      { :query => "%#{params[:query]}%" }
    )
    .left_outer_joins(movie_cast: :person)
    .group(:id).length
      
    @last = [1, (count.to_f / PAGE_COUNT).ceil].max

    @start = [1, @page - PAGINATION].max
    @end = [@last, @page + PAGINATION].min
  end
  
  def tv
  end

  def people
  end
end
