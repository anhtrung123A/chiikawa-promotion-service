# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
set :output, {
  error: "log/cron_error.log",
  standard: "log/cron.log"
}
# Learn more: http://github.com/javan/whenever
every '0 0 1 * *' do
  runner "Promotion.distribute_promotions_to_users_who_have_birthday_in_this_month", environment: 'development'
end
every '0 0 1 1 *' do
  runner "User.reset_has_received_promotion_this_year", environment: 'development'
end

