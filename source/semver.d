module semver;

struct SemVer {
    int major;
    int minor;
    int patch;
    string versionInformation;
    string buildMetaData;
}

bool isValidSemver(string versionString) {
    //read string to the first dot and go on only if it's a positive natural number, clear out leading zeros
    //read to the next dot and do the same
    //read to the end or the next dash or plus and go on only if it's a positive natural number, clear out leading zeroes

    //read to the end or the next plus if there has not been any yet and check if it contains only alphanumeric ASCII letters or dashes
    //read to the end and check if it contains only alphanumeric ASCII letters or dashes
}

// TODO: compare two versions
// TODO: sort a range of versions
// TODO: build SemVer struct from string
