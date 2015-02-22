class News < Node
  NODE_TYPE = "news#show"

  default_scope {where(:type => NODE_TYPE)}

  def self.inheritance_column
    nil
  end
end
