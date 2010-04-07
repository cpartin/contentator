module Cms::Admin::PagesHelper
 
  def sortable_tree(collection, model)
    make_tree_recursive(collection) do |item|
      controls = %{
        #{link_to('', send("edit_cms_admin_#{model}_path", item), {:class => 'edit'} )} 
        #{link_to('', send("cms_admin_#{model}_path", item), {:method => :delete, :confirm => t('form_global.delete_warning'), :class => 'delete'})}
      }
      toggle = item.children.empty? ? '<span class="spacer">&nbsp;</span>': link_to_function(image_tag('icons/folder.png'), "$(this).next('ul').toggle()")

      buffer = <<-"end;"
        #{toggle}
        <span class="tree-controls">#{controls}<a class="move">t('form_global.delete_warning')</a></span>
        <span>#{item.title} (/#{item.path})</span>
      end;
 
    end
  end
 
  def make_tree_recursive(tree, parent_id=nil, nested=false)
    ret = "<ul id=\"tree_#{parent_id || 'root'}\" class=\"#{parent_id ? '' : 'tree'}\">"
    tree.each do |node|
      if node.parent_id == parent_id
        ret += "<li id=\"nav_#{node.id}\">"
        ret += yield node
        ret += node.children.empty? ? '' : make_tree_recursive(tree, node.id, true) {|n| yield n}
        ret += '</li>'
      end
    end
    ret += '</ul>'
    ret
  end
 
end