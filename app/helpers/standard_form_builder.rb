
class StandardFormBuilder < ActionView::Helpers::FormBuilder
#...
  def text_field_with_list(name, *args)
    options = args.extract_options!
    options[:list] ||= options[:label].downcase.pluralize
    t = @template.content_tag :datalist, options[:datalist].collect{ |option| @template.content_tag(:option, option) }.join.html_safe, :id => options[:list] if options[:datalist].is_a? Enumerable
    text_field(name, options) + t
  end

  def objectify_options(options)
    super.except(:label, :datalist)
  end
end

