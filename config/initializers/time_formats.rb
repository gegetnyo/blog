# config/initierlizers/time_formats.rb
# 既に定義されているフォーマット
# default => "2014-10-01 09:00:00 +0900"
# long    => "October 01, 2014 09:00"
# short   => "01 Oct 09:00"
# db      => "2014-10-01 00:00:00"

# カスタムフォーマットを定義
Date::DATE_FORMATS[:defaulta]      = "%-m月%-d日"


#https://ruby-rails.hatenadiary.com/entry/20141226/1419600679