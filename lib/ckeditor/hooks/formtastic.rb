require "formtastic"
require "formtastic-bootstrap"

class CkeditorInput
  include ::Formtastic::Inputs::Base
  include ::FormtasticBootstrap::Inputs::Base

  def to_html
    bootstrap_wrapping do

          builder.cktext_area(method, input_html_options)
    end
  end
end