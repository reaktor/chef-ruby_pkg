# 0.1.1 / _Not released yet_

- Add configuration and instructions for [knife-solo](http://matschaffer.github.io/knife-solo/) ([GH-1])
- Use the freshly built ruby for installing and running fpm ([GH-2])
    - No need to install system Ruby, avoid extra Chef run
    - No need to worry that Ohai's ruby paths are up-to-date
    - We can use the community site version of fpm-tng cookbook
- Remove apt cookbook dependency from the cookbook
    - Add apt recipe to the run_list in Vagrantfile and example.json
- Add Test Kitchen setup ([GH-3])

# 0.1.0 / 2013-05-22

- Initial public release
- Supports so far only Debianoids, tested on Debian 6 & 7 and Ubuntu 12.04


[GH-1]:  https://github.com/reaktor/chef-ruby_pkg/issues/1  "Issue 1"
[GH-2]:  https://github.com/reaktor/chef-ruby_pkg/issues/2  "Issue 2"
[GH-3]:  https://github.com/reaktor/chef-ruby_pkg/issues/3  "Issue 3"
