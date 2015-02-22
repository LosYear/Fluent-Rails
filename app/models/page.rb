class Page < Node
  NODE_TYPE = "pages#show"

  default_scope {where(:type => NODE_TYPE)}

  def self.inheritance_column
    nil
  end
end
