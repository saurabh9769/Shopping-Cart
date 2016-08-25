class HomeController < ApplicationController
  def index

		@banner = Banner.all
		# @category = Category.all
	  @category = Category.where(parent_id: nil)
	  # binding.pry
	  # @categories = @category.subcategories.build
 	end


end


	# <div class="panel-group category-products" id="accordian">
	# 						<div class="panel panel-default">
	# 							<div class="panel-heading">
	# 								<h4 class="panel-title">
	# 									<% @category.each do |i| %>
	# 										<a data-toggle="collapse" data-parent="#accordian" href= "<%= "#{i.name}" %>" >
	# 											<span class="badge pull-right"><i class="fa fa-plus"></i></span>
	# 	      							<%= "#{i.name}" %>
	# 										</a>
	# 										<div id = "<%= "#{i.name}" %>" class="panel-collapse collapse">
	# 											<div class="panel-body">
	# 												<ul>
	# 													<% i.subcategories.each do |j| %>
	# 														<li><%= "#{j.name}"%></li>
	# 													<% end %>
	# 												</ul>
	# 											</div>
	# 										</div>
	# 										<br><br>
	#   								<% end %>
	# 								</h4>
	# 							</div>
	# 						</div>
	# 					</div>

	# <% @category.each do |i| %>
	# 						<div class="panel panel-default">
	# 							<div class="panel-heading">
	# 								<h4 class="panel-title">
	# 									<a data-toggle="collapse" data-parent="#accordian" href="<%= "#{i.name}" %>">
	# 										<span class="badge pull-right"><i class="fa fa-plus"></i></span>
	# 											<%= "#{i.name}" %>
	# 									</a>
	# 								</h4>
	# 							</div>
	# 							<div id="<%= "#{i.name}" %>" class="panel-collapse collapse">
	# 								<div class="panel-body">
	# 									<ul><% i.subcategories.each do |j| %>
	# 										<li><%= "#{j.name}"%></li>
	# 									<% end %></ul>
	# 								</div>
	# 							</div>
	# 						</div>
	# 					<% end %>