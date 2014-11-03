#!/usr/bin/env puma

environment = 'production'
rails_env = 'production'
ENV['RAILS_ENV'] ||= 'production'

threads 4,8

bind  "unix:///home/rails/apps/exterminatus/shared/tmp/puma/exterminatus.sock"
pidfile "/home/rails/apps/exterminatus/shared/tmp/puma/pid"
state_path "/home/rails/apps/exterminatus/shared/tmp/puma/state"

activate_control_app
