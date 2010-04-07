#new_<%= file_name %>_container

- <%= class_name %>.all.each do |<%= file_name %>|
  = render :partial => 'cms/content/<%= file_name %>', :locals => {:<%= file_name %> => <%= file_name %>}
  
- if current_user
  :javascript
    Sortable.create('<%= table_name %>_container', {tag: 'div', handle: 'sort-handle',
      only: 'box',
      onUpdate: function() {
        new Ajax.Request('#{sort_cms_admin_<%= table_name %>_path}?page_id=#{@page.id}', {
          method: 'get',
          parameters: Sortable.serialize('<%= table_name %>_container', {tag: 'div', name: '<%= file_name %>'})
        });
      }
    });  