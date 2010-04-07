Factory.define :<%= singular_name %> do |f|
<% for attribute in attributes -%>
  f.<%= attribute.name %> <%= attribute.default.is_a?(String) ? "'#{attribute.default}'" : attribute.default %>
<% end -%>
  f.updated_at '2009-04-01 12:00:00'
end