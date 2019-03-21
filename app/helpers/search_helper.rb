module SearchHelper
  def page_params
    request.params.slice("query", "sort", "page")
  end

  def toggleOrder
    params[:order] == 'desc' ? 'asc' : 'desc'
  end

  def displayOrderMovieAngle(name)
    displayOrderAngle(name, 'title')
  end

  def displayOrderTvAngle(name)
    displayOrderAngle(name, 'name')
  end

  def displayOrderPeopleAngle(name)
    displayOrderAngle(name, 'name')
  end

  def displayOrderAngle(name, default)
    sort = params[:sort] || default
    if sort == name
      if params[:order] == 'desc'
        return '<i class="disabled angle up icon"></i>'.html_safe
      else 
        return '<i class="disabled angle down icon"></i>'.html_safe
      end
    end
  end
end
