import std.traits, std.regex, std.string;

enum semVerPattern = r"(?P<major>[0]|[1-9][0-9]*?)\.(?P<minor>[0]|[1-9][0-9]*?)\.(?P<patch>[0]|[1-9][0-9]*)(?P<prerelease>-[a-zA-Z0-9-.]+)?(?P<build>\+[a-zA-Z0-9-.]+)?"; 

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
    return match(versionString, semVerPattern).captures[0] == versionString;
}

unittest {
    assert(!isValidSemver("1"));
    assert(!isValidSemver("1.0"));
    assert(!isValidSemver("9600.16384.130821.1623"));
    assert(!isValidSemver("a.b.c"));

    assert( isValidSemver("0.1.0"));
    assert( isValidSemver("1.123.4"));

    assert(!isValidSemver("-4.0.12"));
    assert(!isValidSemver("0.-14.3"));
    assert(!isValidSemver("8.42.-17"));

    assert( isValidSemver("172.13242.987034-beta.eta-kappa-123.41+csum-sha1.73409ABCDEF"));

    assert(!isValidSemver("01239+-"));
    assert( isValidSemver("1.2.3-prerelease"));

}

// TODO: compare two versions
// TODO: sort a range of versions
// TODO: build SemVer struct from string
