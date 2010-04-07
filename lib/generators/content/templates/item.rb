- id = <%= file_name %>.id
%a{:name => id}
%div{:class => '<%= file_name %>', :id => "<%= file_name %>_#{id}"}
  = delete_link("<%= file_name %>_#{id}", cms_admin_<%= file_name %>_path(id))
  = edit_link("<%= file_name %>#{id}", edit_cms_admin_<%= file_name %>_path(id))
  = sort_field(id,<%= file_name %>.position)

  .clear
<% for attribute in attributes -%>
  .<%= attribute.name %>= <%= file_name %>.<%= attribute.name %> unless <%= file_name %>.<%= attribute.name %>.blank? 
<% end -%>