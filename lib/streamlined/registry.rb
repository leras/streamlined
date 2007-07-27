class Streamlined::Registry
  @ui_by_name = {}
  class <<self
    attr_accessor :ui_by_name
    # Returns the UI class for a given model class or name
    def ui_for(model)
      name = model.to_s
      @ui_by_name[name] ||= Streamlined::UI.new(model)
    end
    def reset
      @ui_by_name = {}
    end
  end
end

