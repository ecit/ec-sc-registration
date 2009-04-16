// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
replace_ids = function(s){
  var new_id = new Date().getTime();
  return s.replace(/NEW_RECORD/g, new_id);
}

var myrules = {
  '.remove': function(e){
    el = Event.findElement(e);
    target = el.href.replace(/.*#/, '.')
    el.up(target).hide();
    if(hidden_input = el.previous("input[type=hidden]")) hidden_input.value = '1'
  },
  '.add_nested_item': function(e){
    el = Event.findElement(e);
    template = eval(el.href.replace(/.*#/, ''))
    $(el.rel).insert({     
      bottom: replace_ids(template)
    });
  },
  '.add_nested_item_lvl2': function(e){
    el = Event.findElement(e);
    elements = el.rel.match(/(\w+)/g)
    parent = '.'+elements[0]
    child = '.'+elements[1]
    
    child_container = el.up(parent).down(child)    
    parent_object_id = el.up(parent).down('input').name.match(/.*\[(\d+)\]/)[1]
    
    template = eval(el.href.replace(/.*#/, ''))

    template = template.replace(/(attributes[_\]\[]+)\d+/g, "$1"+parent_object_id)
    
   // console.log(template)
    child_container.insert({     
      bottom: replace_ids(template)
     });
  }
};

Event.observe(window, 'load', function(){
  $('container').delegate('click', myrules);
});



jq(function(){
/*
* code to append form fields
*/
  var nested_attributes =
    <%= @company.nested_attributes.to_json %>;
 
// finds the 'value-y' nested attributes
//
  var find_nested_attribute_elements =
    function(a){
      var nested_attribute = a.attr("data-nested_attribute");
      var id_pattern = sprintf("_%s_attributes_", nested_attribute);
      var selector = sprintf("[id*='%s'][id$='_value']", id_pattern);
      var elements = jq(selector);
      return(elements);
    };
 
// add one
//
  var add_nested_attribute =
    function(a){
      var elements = find_nested_attribute_elements(a);
      var last = jq(elements.get(elements.size() - 1));
      var clone = last.clone();
      var attrs = ['id', 'name'];
      jq.each(attrs, function(idx){
        var attr = attrs[idx];
        var succ = last.attr(attr).replace(/(\d+)/g, function(n){ return(Number(n) + 1) });
        clone.attr(attr, succ);
      });
      clone.css({'display':'block', 'margin-top':'0.5em'});
      clone.val('');
      last.after(clone)
      clone.focus();
      return(clone);
    };
 
// nuke one
//
  var delete_nested_attribute =
    function(a){
      var elements = find_nested_attribute_elements(a);
      var size = elements.size();
      var last = jq(elements.get(size - 1));
      var next_to_last = jq(elements.get(size - 2));
 
    // build up the form element to affect a delete
    //
      var clone = last.clone();
      var name = last.attr('name');
      var key = '_delete';
      name = name.replace(/\[value\]$/, sprintf('[%s]', key));
      var id = last.attr('id');
      id = id.replace(/value$/, key);
      clone.attr('name', name);
      clone.attr('id', id);
      clone.val('true');
      clone.css('style', 'display:none');
      clone.hide();
      last.after(clone);
      
      if(size > 1 ){
        last.remove();
      } else {
        last.val('');
      };
      try{ next_to_last.focus() }catch(e){};
    };
 
// give the + and - buttons add/delete behaviour
//
  jq('.add_nested_attribute').each(function(){
    var a = jq(this);
    a.click(function(){ add_nested_attribute(a) });
  });
 
  jq('.delete_nested_attribute').each(function(){
    var a = jq(this);
    a.click(function(){ delete_nested_attribute(a) });
  });
 
/*
* code to enable/disable the form
*/
  var form = jq('form');
  var submit = form.find('input[type=submit]');
  var edit = form.find('input[name=edit][type=checkbox]');
  var element_selectors = ['input[type=text]', 'input[type=submit]', 'textarea', 'select'];
  var icons = []
  var icon_selectors = ['.add_nested_attribute', '.delete_nested_attribute'];
 
// mark elements that should be permenantly disabled
//
  jq.each(element_selectors, function(index){
    jq.each(element_selectors, function(index){
      var selector = element_selectors[index];
      form.find(selector).each(function(){
        var element = jq(this);
        var disabled = Boolean(element.attr('disabled'));
        element.data('disabled', disabled);
      });
    });
  });
 
// scrape the form for it's elements, adding some behaviour
//
  var elements = function(){
    var list = [];
    jq.each(element_selectors, function(index){
      var selector = element_selectors[index];
      form.find(selector).each(function(){
        var element = jq(this);
        var disabled = element.data('disabled');
        if(disabled){
          element.disable = function(){};
          element.enable = function(){};
        } else {
          element.disable = function(){ element.attr('disabled', true) };
          element.enable = function(){ element.removeAttr('disabled') };
        };
        list.push(element);
      });
    });
    list.disable = function(){ jq.each(list, function(i){ list[i].disable() }) };
    list.enable = function(){ jq.each(list, function(i){ list[i].enable() }) };
    return list;
  }
 
// scrape the form for it's icons, adding some behaviour
//
  jq.each(icon_selectors, function(index){
    var selector = icon_selectors[index];
    form.find(selector).each(function(){
      var icon = jq(this);
      icon.disable = function(){ icon.hide() };
      icon.enable = function(){ icon.show() };
      icons.push(icon);
    });
    icons.disable = function(){ jq.each(icons, function(i){ icons[i].disable() }) };
    icons.enable = function(){ jq.each(icons, function(i){ icons[i].enable() }) };
  });
 
// give the form the ability to apply focus
//
  form.focus = function(){
    var list = elements();
    jq.each(list, function(index){
      if(list[index].attr('disabled')) return true;
      list[index].focus();
      return false;
    });
  };
 
// give the form the ability to be disabled
//
  form.disable = function(){
    elements().disable();
    icons.disable();
  };
 
// give the form the ability to be enabled
//
  form.enable = function(){
    elements().enable();
    icons.enable();
    form.focus();
  };
 
// give checkbox ability to toggle form state editable|non-editable
//
  edit.change(
    function(){
      var checked = edit.attr('checked');
      checked ? form.enable() : form.disable();
      return true;
    }
  );
 
// setup initial form state
//
  var disabled = <%= (!!@disabled).to_json %>;
 
  if(disabled){
    form.disable();
  } else {
    form.enable();
    edit.attr('checked', true);
  };
});