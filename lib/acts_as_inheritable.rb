require 'active_record'
require "acts_as_inheritable/version"

module ActsAsInheritable
  def acts_as_inheritable

    def has_parent?
      parent.present?
    end

    # This is an inheritable recursive method that iterates over all of the
    # relations defined on `INHERITABLE_ASSOCIATIONS`. For each instance on
    # each relation it re-creates it.
    def inherit_relations(parent = parent, current = self)
      if parent && parent.class.const_defined?("INHERITABLE_ASSOCIATIONS")
        parent.class::INHERITABLE_ASSOCIATIONS.each do |relation|
          parent_relation = parent.send(relation)
          relation_instances = parent_relation.respond_to?(:each) ? parent_relation : [parent_relation].compact
          relation_instances.each do |relation_instance|
            inherit_instance(current, parent, relation, relation_instance)
          end
        end
      end
    end

    def inherit_instance(current, parent, relation, relation_instance)
      new_relation = relation_instance.dup
      belongs_to_associations_names = parent.class.reflect_on_all_associations(:belongs_to).collect(&:name)
      saved =
        if belongs_to_associations_names.include?(relation.to_sym)
          # Is a `belongs_to` association
          new_relation = relation_instance.duplicate! if relation_instance.respond_to?(:duplicate!)
          current.send("#{relation}=", new_relation)
          current.save
        else
          # Is a `has_one | has_many` association
          parent_name = verify_parent_name(new_relation, parent)
          new_relation.send("#{parent_name}=", current)
          new_relation.save
        end
      inherit_relations(relation_instance, new_relation) if saved
    end

    def verify_parent_name(new_relation, parent)
      parent_name = parent.class.to_s.downcase
      many_and_one_associations = parent.class.reflect_on_all_associations.select { |a| a.macro != :belongs_to }
      many_and_one_associations.each do |association|
        if association.klass.to_s.downcase == new_relation.class.to_s.downcase && association.options.has_key?(:as)
          as = association.options[:as].to_s
          parent_name = as if new_relation.respond_to?(as) && !new_relation.respond_to?(parent_name)
          break
        end
      end
      parent_name
    end

    def inherit_attributes(force = false, not_force_for=[])
      if parent.present?
        # Attributes
        self.class::INHERITABLE_ATTRIBUTES.each do |attribute|
          current_val = send(attribute)
          if (force && !not_force_for.include?(attribute)) || current_val.blank?
            send("#{attribute}=", parent.send(attribute))
          end
        end
      end
    end
  end
  if defined?(ActiveRecord)
    puts 'neea'
    # Extend ActiveRecord's functionality
    ActiveRecord::Base.send :extend, ActsAsInheritable
  end

end
