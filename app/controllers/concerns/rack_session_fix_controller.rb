# frozen_string_literal: true

module RackSessionFixController

  #This module is a fix to the "session store error"
  # Devise uses session storage as default, which is incompatible with a rails api only.
  # There is an alternative fix, which is to config for cookies in application.rb.
  # But cookies introduce loopholes in authenticated controllers,
  # allowing users access with just a cookie present.

  extend ActiveSupport::Concern

  class FakeRackSession < Hash
    def enabled?
      false
    end
  end

  included do
    before_action :set_fake_rack_session_for_devise

    private

    def set_fake_rack_session_for_devise
      request.env['rack.session'] ||= FakeRackSession.new
    end
  end
end

