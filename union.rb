module ActiveRecord::UnionScope
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def union_scope(*scopes)
      id_column = "#{table_name}.id"
      sub_query = scopes.map { |s| s.select(id_column).to_sql }.join(" UNION ")
      where "#{id_column} IN (#{sub_query})"
    end
  end
end

# EXAMPLE OF USAGE
class Property < ActiveRecord::Base
  include ActiveRecord::UnionScope

  # some silly, contrived scopes
  scope :active_nearby,     -> { where(active: true).where('distance <= 25') }
  scope :inactive_distant,  -> { where(active: false).where('distance >= 200') }

  # A union of the aforementioned scopes
  scope :active_near_and_inactive_distant, -> { union_scope(active_nearby, inactive_distant) }
end