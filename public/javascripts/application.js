// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function remove_element(source, css_class)
{
	$(source).up(css_class).remove();
}