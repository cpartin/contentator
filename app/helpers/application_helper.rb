# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def flash_messages
    messages = ''
    %w{ notice success warning error }.each do |type|
      messages += content_tag(:div,
        content_tag(:div, flash[type.to_sym] || flash.now[type.to_sym]),
        :class => type + ' message'
        ) if flash[type.to_sym] || flash.now[type.to_sym]
    end
    messages.blank? ? '' : content_tag(:div, messages, :class => 'flash-messages', :id => 'flash_messages')
  end

  def edit_link(update, url)
    return unless current_user
    link_to_remote(image_tag('icons/edit.png', :class => 'edit_button'), :update => update, :url =>  url, :method => :get)
  end

  def delete_link(update, url)
    return unless current_user
    link_to_remote(image_tag('icons/delete.png', :class => 'delete_button'), :update => update, :url =>  url, :method => :delete, :confirm => t('form_global.delete_warning'))
  end
  
  def sort_field(field_name, pos)
    return unless current_user
    text_field_tag field_name, pos, :class => 'position_text_box'
  end

end
