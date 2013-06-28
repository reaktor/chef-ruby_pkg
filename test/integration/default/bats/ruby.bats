#!/usr/bin/env bats

@test "compiles ruby binary" {
    run /usr/local/ruby/1.9.3/bin/ruby --version
    [ "$status" -eq 0 ]
    [[ "${lines[0]}" == "ruby 1.9.3"* ]]
}

@test "creates an installable package" {
    # remove the build tree to verify that the package installs correctly
    rm -rf /usr/local/ruby/1.9.3*

    # install the package
    if [ -f /tmp/*_ruby-1.9.3-*.deb ]; then
        dpkg -i /tmp/*_ruby-1.9.3-*.deb
    elif [ -f /tmp/*_ruby-1.9.3_*.rpm ]; then
        rpm -i /tmp/*_ruby-1.9.3_*.rpm
    else
        false
    fi

    # test the installed ruby
    run /usr/local/ruby/1.9.3/bin/ruby --version
    [ "$status" -eq 0 ]
    [[ "${lines[0]}" == "ruby 1.9.3"* ]]
}
