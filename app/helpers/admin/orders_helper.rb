module Admin::OrdersHelper
  
  def sort_ordero(column, title)
    css_class = column == sort_columno ? "current #{sort_directiono}" : nil
    direction = column == sort_columno && sort_directiono == 'desc' ? 'asc' : 'desc'
    link_to title, {sort: column, direction: direction}.merge(), class: "sort_header #{css_class}"
  end  
  def sort_directiono
    %w[desc asc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def sort_columno
    Order.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end
end
