module RPH
  # This plugin allows you to alleviate checking the #params
  # hash directly, and provides a much cleaner alternative.
  #
  # Old way(s):
  #   Project.new(params[:project]) unless params[:project].blank?
  #   Project.new(params[:project]) if params[:project]
  #
  # New way(s):
  #   Project.new(params[:project]) unless blank_project_params?
  #   Project.new(params[:project]) if has_project_params?
  #   Project.new(params[:project]) if project_params?
  #
  module HasParams
    def self.included(base)
      base.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      # supported methods:
      # - <tt>blank_<name>_params?</tt>
      #    returns true if the params in question are blank,
      #    otherwise returns false
      #
      # - <tt>has_<name>_params?</tt>
      #    returns true if the params in question are present,
      #    otherwise returns false
      #
      # - <tt><name>_params?</tt>
      #    behaves exactly like <tt>has_<name>_params?</tt>,
      #    it's just a shorter version
      #
      # Note: <name> is where you place whatever params key you'd
      #       normally use. For example, params[:user] would be:
      #         - blank_user_params?
      #         - has_user_params?
      #         - user_params?
      def method_missing(method, *args)
        result = false
        
        if method.to_s.match(/^blank_(\w+)_params\?$/)
          result = blank_target_params?($1)
        elsif method.to_s.match(/^has_(\w+)_params\?$/)
          result = has_target_params?($1)
        elsif method.to_s.match(/^(\w+)_params\?$/)
          result = has_target_params?($1)
        else
          super(method, *args) and return
        end

        !!result
      end
      
      private
        # convenience method to check if the targeted
        # params are blank
        def blank_target_params?(key)
          params && params[key.to_sym].blank?
        end
        
        # convenience method to check if the targeted
        # params are not blank
        def has_target_params?(key)
          params && !params[key.to_sym].blank?
        end
    end
  end
end