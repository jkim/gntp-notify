# Author: Justin Anderson
# Homepage:
# Version: 1.0

require 'rubygems'
require 'ruby_gntp'

def weechat_init
  Weechat.register("gntp_notify",
                   "Justin Anderson",
                   "1.0",
                   "GPL3",
                   "GNTP Notify: Growl notifications using ruby-gntp.",
                   "",
                   "")

  Weechat.hook_signal("weechat_pv", "show_private", "")
  Weechat.hook_signal("weechat_highlight", "show_highlight", "")

  @growl = GNTP.new("Weechat")
  @growl.register({
    :notifications => [{:name    => "Private",
                        :enabled => true},
                       {:name    => "Highlight",
                        :enabled => true}]
  })

  return Weechat::WEECHAT_RC_OK
end

def show_private(data, signal, message)
  show_notification("Private", "Weechat Private Message",  message)
  return Weechat::WEECHAT_RC_OK
end

def show_highlight(data, signal, message)
  show_notification("Highlight", "Weechat",  message)
  return Weechat::WEECHAT_RC_OK
end

def show_notification(name, title, message)
  @growl.notify({
    :name   => name,
    :title  => title,
    :text   => message,
    :sticky => true
  })
end
