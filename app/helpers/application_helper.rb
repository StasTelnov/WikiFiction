module ApplicationHelper

  def save_button(f, name = 'Save', options = {})
    default_options = { :id => 'not-saved-form', :class => 'btn btn-primary', :data => { 'loading-text' => 'Saving' }, :type => :submit }
    f.button :submit, name, default_options.merge(options)
  end

  def saved_button(name = 'Saved', options = {})
    default_options = { :id => 'saved-form', :class => 'btn btn-success' }
    content_tag(:span, name, default_options.merge(options))
  end

end
