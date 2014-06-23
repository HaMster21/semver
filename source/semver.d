import std.traits, std.regex;

enum semVerPattern = 
    r"(?P<major>0|[1-9][0-9]*?)\.(?P<minor>0|[1-9][0-9]*?)\.(?P<patch>0|[1-9][0-9]*)(?P<prerelease>-[a-zA-Z0-9]+([-.][a-zA-Z0-9]+)*)?(?P<build>\+[a-zA-Z0-9]+([-.][a-zA-Z0-9]+)*)?"; 

struct SemVer {
    uint major;
    uint minor;
    uint patch;
    string prerelease;
    string build;
}

bool isValidSemver(Version) (Version versionString)
  if (isSomeString!Version)
{
    import std.algorithm: startsWith;
    return   !versionString.startsWith("0.0.0") 
           && match(versionString, semVerPattern).captures[0] == versionString;
}

unittest {
    assert(!isValidSemver("0.0.0-alpha.12-15+build.today-14pm")); 

    assert(!isValidSemver("1"));
    assert(!isValidSemver("1.0"));
    assert(!isValidSemver("9600.16384.130821.1623"));

    assert(!isValidSemver("01.0.0"));
    assert(!isValidSemver("0.09.18"));
    assert(!isValidSemver("14.0.007"));
    
    assert(!isValidSemver("-4.0.12"));
    assert(!isValidSemver("0.-14.3"));
    assert(!isValidSemver("8.42.-17"));

    assert(!isValidSemver("a.b.c"));
    assert(!isValidSemver("a.0.0"));
    assert(!isValidSemver("1.b.0"));
    assert(!isValidSemver("2.1.c"));

    assert(!isValidSemver("0.12.39+-"));
    assert(!isValidSemver("1.0.0-"));
    assert(!isValidSemver("1.0.0+"));
    assert(!isValidSemver("1.1.2-4+"));
    assert(!isValidSemver("4.1.7+14-"));

    assert(!isValidSemver("0.0.1+a+b"));
    
    assert(!isValidSemver("1.0.0+軟件.12-1"));
    assert(!isValidSemver("1.0.0-программное обеспечение"));

    assert( isValidSemver("0.1.0"));
    assert( isValidSemver("1.123.4"));
    assert( isValidSemver("1.2.3-prerelease"));
    assert( isValidSemver("172.13242.987034-beta.eta-kappa-123.41+csum-sha1.73409ABCDEF"));

// TODO: This does not yet compile due to type mismatch in the template instantiantion of match
//    assert( isValidSemver("1.0.0-alpha.1-4+sha1.afe12a98b"d));
//    assert( isValidSemver("1.0.0-alpha.1-4+sha1.afe12a98b"w));

}

// TODO: compare two versions
// TODO: sort a range of versions
// TODO: build SemVer struct from string
