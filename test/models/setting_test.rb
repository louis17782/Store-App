require "test_helper"

class SettingTest < ActiveSupport::TestCase
  test "supports the three banner image attachments" do
    setting = Setting.new

    %i[banner_1 banner_2 banner_3].each do |banner|
      assert_respond_to setting, banner
      assert_respond_to setting.public_send(banner), :attached?
    end
  end
end
