class <%= plural_name %>Controller < ApplicationController
<% actions.each do |action| -%>
  def <%= action %>
  end
<% end -%>
end
