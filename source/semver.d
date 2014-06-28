import std.traits, std.regex;

public {
    alias Version = SemVer;
    alias validate = isValidSemver;
    alias VersionPattern = Pattern;
}

template Pattern(StringType) {
   import std.conv;
   auto rx = regex(to!StringType(
                             `(?P<major>0|[1-9][0-9]*?)\.
                              (?P<minor>0|[1-9][0-9]*?)\.
                              (?P<patch>0|[1-9][0-9]*)
                              (?P<prerelease>-[a-zA-Z0-9]+([-.][a-zA-Z0-9]+)*)?
                              (?P<build>\+[a-zA-Z0-9]+([-.][a-zA-Z0-9]+)*)?`
                             ),"x");
   alias Pattern = rx;
}

struct SemVer {
    uint major;
    uint minor;
    uint patch;
    string prerelease;
    string build;
}

// TODO: since 'match' is neither pure nor nothrow, the validation function can't be as well. At the moment it can only be safe
/++
    Testing a given string for compliance with the semantic versioning specification

    Strings that are parsed  can be of any built-in type D supports, meaning char[], wchar[] and 
    dchar[].

    If the string is not starting with version 0.0.0 and matches the VersionPattern completely,
    it is valid (matching somewhere in the string is not). The pattern takes the following things 
    into accout:
        - leading zeroes
        - ordering of prerelease and build information (prerelease first)
        - '+' and '-' directly following each other (not of any sense, 1.0.0+--- would be awkward)
        - ommiting information besides the X.Y.Z

    Params:
        versionString = the version specification that should be validated

    Returns: true if the versionString fully matches the pattern and does not start with '0.0.0'
 +/
bool isValidSemver(Version) (Version versionString) @safe
  if (isSomeString!Version)
{
    import std.algorithm: startsWith;
    return   !versionString.startsWith("0.0.0") 
           && match(versionString, Pattern!Version).captures[0] == versionString;
}

///
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

    assert( isValidSemver("1.0.0-alpha.1-4+sha1.afe12a98b"d));
    assert( isValidSemver("1.0.0-alpha.1-4+sha1.afe12a98b"w));
}

// TODO: compare two versions
// TODO: sort a range of versions
// TODO: build SemVer struct from string
