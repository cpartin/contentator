.form_container
  = link_to image_tag('icons/cancel.png'), content_path(@page.path), :id => 'cancel_button'

  - form_remote_for([:cms, :admin, @<%= file_name %>], :html => {:multipart => true }) do |f|
    = f.hidden_field :page_id, :value => @page.id 

<% for attribute in attributes -%>
    = f.label :<%= attribute.name %>
    = f.text_field :<%= attribute.name %>
    
<% end %>  
    = submit_tag "Submit"