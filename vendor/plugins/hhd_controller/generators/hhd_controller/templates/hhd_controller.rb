class Admin::<%= class_name %>Controller < AdminController

  <%- if has_text_editors -%>
  uses_tiny_mce
  <%- end -%>

  active_scaffold :<%= file_name.singularize %> do |config|
    config.list.label = "<%= class_name.titleize %>"
    config.create.link.label = "Create <%= class_name.singularize.titleize %>"

    config.columns = [<%= columns.map{|c| ":#{c.name}" }.join(", ") %>]
    config.list.columns = [<%= list_columns.map{|c| ":#{c.name}" }.join(", ") %>]

    <%- for association in associations.find_all{|c| c.macro == :belongs_to} -%>
    config.columns[:<%= association.name %>].form_ui = :select
    <%- end -%>

    <%- for column in columns.find_all{|c| c.type == :text } -%>
    config.columns[:<%= column.name %>].form_ui = :text_editor
    <%- end -%>

    <%- for column in columns.find_all{|c| c.type == :boolean } -%>
    config.columns[:<%= column.name %>].form_ui = :checkbox

    <%- end -%>
    <%- for column in columns.find_all{|c| c.type == :datetime } -%>
    config.columns[:<%= column.name %>].options = {:format => "%d/%m/%Y %I:%M%p"}
    <%- end -%>
  end 

end
