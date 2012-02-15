module Sequel
  module Timestamps

    def before_create
      t = Time.now
      self.created_at = t
      self.updated_at = t if respond_to?(:updated_at=)
      super
    end

    def before_update
      t = Time.now
      self.updated_at = t if respond_to?(:updated_at=)
      super
    end
  end
end
