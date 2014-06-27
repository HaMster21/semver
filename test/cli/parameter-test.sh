#! /usr/bin/env bash

function assert() {
  echo "asserting $1 returns $2"
  ./$1
  if [ $2 -eq $? ] 
    then true;
    else 
      echo "Assertion failed, API changed?";
      exit 1;
  fi
}

assert "semver -v 0.0.0-alpha.12-15+build.today-14pm" 1 

assert "semver -v 1" 1
assert "semver -v 1.0" 1

assert "semver -v 9600.16384.130821.1623" 1
assert "semver -v 01.0.0" 1
assert "semver -v 0.09.18" 1
assert "semver -v 14.0.007" 1
    
assert "semver -v -4.0.12" 1
assert "semver -v 0.-14.3" 1
assert "semver -v 8.42.-17" 1

assert "semver -v a.b.c" 1
assert "semver -v a.0.0" 1
assert "semver -v 1.b.0" 1
assert "semver -v 2.1.c" 1

assert "semver -v 0.12.39+-" 1
assert "semver -v 1.0.0-" 1
assert "semver -v 1.0.0+" 1
assert "semver -v 1.1.2-4+" 1
assert "semver -v 4.1.7+14-" 1

assert "semver -v 0.0.1+a+b" 1
    
assert "semver -v 1.0.0+軟件.12-1" 1
assert "semver -v 1.0.0-программное обеспечение" 1

assert "semver -v 0.1.0" 0
assert "semver -v 1.123.4" 0
assert "semver -v 1.2.3-prerelease" 0
assert "semver -v 172.13242.987034-beta.eta-kappa-123.41+csum-sha1.73409ABCDEF" 0

echo
echo All commandline tests passed
