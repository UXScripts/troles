# @author Kristian Mandrup
#
# Many role storage for storing (embedding) multiple Role instances in a list on the role subject
#
# @note all methods potentially operate directly on values in the data store
#
module Troles::Storage
  class EmbedMany < BaseMany

    # constructor
    # @param [Object] the role subject
    def initialize role_subject
      super
    end

    def roles_to_embed *roles
      roles.flatten.inject([]) do |res, role| 
        res << create_role(role)
        res
      end
    end           

    # display the roles as a list of symbols
    # @return [Array<Symbol>] roles list
    def display_roles
      return [] if !ds_field_value?
      ds_field_value.map{|role| role.name.to_sym }
    end

    # is it set?
    def ds_field_value?
      ds_field_value && !ds_field_value.empty?
    end    
  
    # saves the roles for the role subject in the data store
    # @param [Array<Symbol>] roles list    
    def set_roles *roles
      # creates and embeds new Role instances from symbols
      set_ds_field roles_to_embed(*roles)
    end  

    # clears the role of the user in the data store
    def clear!
      set_ds_field []
    end  
  
    # sets the role to its default state
    def set_default_role!
      clear!
    end
    
    protected
    
    def create_role name
      role_model.create name
    end
  end
end