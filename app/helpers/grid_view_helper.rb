module GridViewHelper
  def gridview_helper columns, options
    # Defining control class
    gridview_class = "rails-gridview"

    # Rendering base table
    table_class = options[:class] + " " + gridview_class
    result = "".html_safe
    result << content_tag(:table, {:class => table_class}, false) do
      content = "".html_safe

      content << content_tag(:thead) do
        thead_content = "".html_safe
        thead_content << content_tag(:tr) do
          row = "".html_safe
          columns.each do |column|
            row << content_tag(:td, column[:title],)
          end

          row
        end

        thead_content
      end

      content << content_tag(:tbody) do
        content_tag(:tr) do
          content_tag(:td, :colspan => columns.count) do
            image_tag "gridview/ajax-loader.gif"
          end
        end
      end

      content
    end

    # Defining JavaScript
    result << javascript_tag(language: "javascript") do
      # Defining JSON passed to init function
      datatable_options = {
          #:sPaginationType => options[:sPaginationType] || 'bootstrap',
          :sPaginationType => options[:sPaginationType] || 'full_numbers',
          :bProcessing => true,
          :bServerSide => true,
          :sAjaxSource => options[:source]
      }.to_json.html_safe
      datatable_options = datatable_options[0...datatable_options.length-1].html_safe

      if options.has_key? :fnDrawCallback
        datatable_options << ",".html_safe
        datatable_options << " fnDrawCallback:".html_safe
        datatable_options << options[:fnDrawCallback].html_safe
      end

      column_defs = Array.new
      columns.each do |column|
        sortable = if column.has_key? :sortable
                     column[:sortable]
                   else
                     true
                   end

        column_def = {
            :bSortable => sortable
        }

        column_defs << column_def
      end

      datatable_options << ", aoColumns: ".html_safe
      datatable_options << column_defs.to_json.html_safe

      # Defining translation
      translation = {
          :oAria => {
              :sSortAscending => t('data_table.oAria.sSortAscending'),
              :sSortDescending => t('data_table.oAria.sSortDescending'),
          },

          :oPaginate => {
              :sFirst => t('data_table.oPaginate.sFirst'),
              :sLast => t('data_table.oPaginate.sLast'),
              :sNext => t('data_table.oPaginate.sNext'),
              :sPrevious => t('data_table.oPaginate.sPrevious')
          },

          :sEmptyTable => t('data_table.sEmptyTable'),
          :sInfo => t('data_table.sInfo'),
          :sInfoEmpty => t('data_table.sInfoEmpty'),
          :sInfoFiltered => t('data_table.sInfoFiltered'),
          :sInfoPostFix => t('data_table.sInfoPostFix'),
          :sInfoThousands => t('data_table.sInfoThousands'),
          :sLengthMenu => t('data_table.sLengthMenu'),
          :sLoadingRecords => t('data_table.sLoadingRecords'),
          :sProcessing => t('data_table.sProcessing'),
          :sSearch => t('data_table.sSearch'),
          :sZeroRecords => t('data_table.sZeroRecords'),

      }
      datatable_options << ", oLanguage: #{translation.to_json.html_safe}".html_safe

      datatable_options << "}".html_safe

      # Defining function string
      javascript_function = "$('.#{gridview_class}').dataTable(#{datatable_options.html_safe});".html_safe
      javascript_function = "var init_gridview = function(){#{javascript_function.html_safe}};".html_safe

      # Defining init of gridview
      script = javascript_function.html_safe
      script << "$(document).ready(init_gridview);".html_safe
      if Gem::Specification::find_all_by_name('turbolinks').any?
       # script << "$(document).on('page:load', init_gridview);".html_safe
      end

      script.html_safe
    end
  end
end