module BootstrapFlashHelper

  ALERT_TYPES = %w(success error alert notice)

  def bootstrap_class_for(flash_type)
    case flash_type
      when 'success'
        'alert-success'   # Green
      when 'error'
        'alert-danger'    # Red
      when 'alert'
        'alert-warning'   # Yellow
      when 'notice'
        'alert-info'      # Blue
      else
        flash_type.to_s
    end
  end

  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?
      next unless ALERT_TYPES.include?(type)

      type = bootstrap_class_for(type)

      Array(message).each do |msg|
        text = content_tag(:div,
               content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") +
               msg.html_safe, :class => "alert fade in #{type}")

        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end

end