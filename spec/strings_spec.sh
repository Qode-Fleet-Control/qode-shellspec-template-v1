# shellcheck shell=sh
# Specs for lib/strings.sh. Run: shellspec   (or `docker compose run --rm app`)

Describe 'lib/strings.sh'
  Include lib/strings.sh

  Describe 'to_upper()'
    It 'uppercases its argument'
      When call to_upper "hello, world"
      The output should eq "HELLO, WORLD"
    End
  End

  Describe 'str_repeat()'
    Parameters
      "ab"  3  "ababab"
      "x"   1  "x"
      "x"   0  ""
    End

    It "repeats '$1' $2 times"
      When call str_repeat "$1" "$2"
      The output should eq "$3"
    End
  End

  Describe 'is_semver()'
    It 'accepts MAJOR.MINOR.PATCH'
      When call is_semver "10.0.3"
      The status should be success
    End

    It 'rejects anything else'
      When call is_semver "1.2"
      The status should be failure
    End
  End

  Describe 'semver_bump()'
    Parameters
      major 1.2.3 2.0.0
      minor 1.2.3 1.3.0
      patch 1.2.3 1.2.4
    End

    It "bumps the $1 part of $2"
      When call semver_bump "$1" "$2"
      The output should eq "$3"
    End

    It 'fails on a non-version, saying why'
      When call semver_bump minor "v1"
      The status should be failure
      The output should be blank
      The error should include "not a version"
    End

    It 'fails on an unknown part'
      When call semver_bump build 1.2.3
      The status should be failure
      The error should eq "semver_bump: unknown part: build"
    End
  End
End
