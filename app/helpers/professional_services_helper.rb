module ProfessionalServicesHelper

public
  def count_service_per_category(category_id)
    Service.where(category_id: category_id).size
  end

  def display_categories_left_side(category)
  	  render :inline => "            <li>
                                        <% if !@district_id.nil? %>
                                            <%= link_to professional_services_path(:category_id => category.id, :district_id => @district_id), :post => true do %>                                            
                                                <span class= \"title\" >
                                                    <%= category.name %>
                                                </span>
                                                <span class=\"count\">
                                                    &nbsp;<%= count_service_per_category(category.id) %>
                                                </span>                                            
                                        <% end %>                                        
                                        <% else %>
                                            <%= link_to professional_services_path(:category_id => category.id ), :post => true do %>
                                                <span class=\"title\">
                                                    <%= category.name %>
                                                </span>
                                                <span class=\"count\">
                                                    &nbsp;<%= count_service_per_category(category.id) %>
                                                </span>
                                            <% end %>
                                        <% end %>                                        
                                    </li>", :locals => { :category => category}
  	
  end

  def display_locations_left_side(district)
      render :inline => "            <li>
                                        <% if !@category_id.nil? %>
                                            <%= link_to professional_services_path(:district_id => district.id,
                                              :category_id => @category_id), :post => true do %>
                                                <% if district.id.to_s == @district_id %>
                                                    <strong><%= district.name %></strong>
                                                <% else %>
                                                    <%= district.name %>
                                                <% end %>
                                            <% end %>                                       
                                        <% else %>
                                            <%= link_to professional_services_path(:district_id => district.id), :post => true do %>
                                                <% if district.id.to_s == @district_id %>
                                                    <strong><%= district.name %></strong>
                                                <% else %>
                                                    <%= district.name %>
                                                <% end %>
                                            <% end %>                                       
                                    </li>", :locals => { :district => district}
    
  end

end
