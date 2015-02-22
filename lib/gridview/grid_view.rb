module GridView
  class GridView
    delegate :params, :h, :link_to, :actions_grid_column, to: :@view

    # @view View Context
    # @columns [array] Array of columns with their definitions
    # @data_provider [ActiveRecord] Usually a model with data which will be shown
    def initialize(view, columns, data_provider)
      @view = view
      @columns = columns
      @data_provider = data_provider
    end

    def as_json(options = {})
      {
          sEcho: params[:sEcho].to_i,
          iTotalRecords: @data_provider.count,
          iTotalDisplayRecords: records.total_entries,
          aaData: data
      }
    end

    private

    # Generates data for request
    def data
      columns = @columns
      records.map do |record|
        tmp = Array.new
        columns.each do |column|
          name = column[:name]
          if column.has_key? :value
            tmp << column[:value].call(record)
          else
            tmp << if name == 'actions_grid_column'
                     actions_grid_column(column[:edit].call(record), column[:remove].call(record))
                   elsif record.send(name).is_a? Time
                     I18n.localize(record.send(name), :format => :long)
                   else
                     text = record.send(name)

                     # If there is something about text formatting
                     if column.has_key? :format
                       text = column[:format].call(record.send(name))
                     end

                     if column.has_key? :escape_html and column[:escape_html]
                       text = ERB::Util.h text
                     end

                     if column.has_key? :link
                       link_to text, column[:link].call(record), :data => {:push => true}
                     else
                       text
                     end
                   end
          end
        end
        tmp
      end
    end

    def records
      @records ||= fetch_records
    end

    # Creates search string depending on columns' params
    def format_search_string
      columns = @columns
      query = ""

      columns.each do |column|
        if column.has_key? :searchable
          query << column[:name] + " like :search or " if column[:searchable]
        end
      end

      query[0...-4]
    end

    def fetch_records
      records = @data_provider.order("#{sort_column} #{sort_direction}")
      records = records.page(page).per_page(per_page)
      if params[:sSearch].present?
        records = records.where(format_search_string, search: "%#{params[:sSearch]}%")
      end
      records
    end

    def page
      params[:iDisplayStart].to_i/per_page + 1
    end

    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = Array.new

      @columns.each do |column|
        columns << column[:name]
      end

      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end

  end
end