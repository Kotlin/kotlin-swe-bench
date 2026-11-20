# Implement the issue(s) in dzikoysk/reposilite:

## Issue: SHA(X) Hashes Generated for Uploaded JAR Files Incorrect

### What happened?

When uploading jar files through the web interface, the hashes generated for SHA1, SHA256, and SHA512 are incorrect. They appear to always use the empty-string hash, and not the hash of the file. MD5 appears to correct.

This happens with both the JAR file hashes, as well as the hashes for the generated `maven-metadata.xml` file.

### Reposilite version

3.x

### Relevant log output

```shell
[reposilite@server test]$ ls -lR
.:
total 20
drwxr-xr-x 2 reposilite reposilite 161 May  1 11:13 1.0.0
-rw-r--r-- 1 reposilite reposilite 351 May  1 11:13 maven-metadata.xml
-rw-r--r-- 1 reposilite reposilite  32 May  1 11:13 maven-metadata.xml.md5
-rw-r--r-- 1 reposilite reposilite  40 May  1 11:13 maven-metadata.xml.sha1
-rw-r--r-- 1 reposilite reposilite  64 May  1 11:13 maven-metadata.xml.sha256
-rw-r--r-- 1 reposilite reposilite 128 May  1 11:13 maven-metadata.xml.sha512

./1.0.0:
total 3996
-rw-r--r-- 1 reposilite reposilite 4067969 May  1 11:13 test-1.0.0.jar
-rw-r--r-- 1 reposilite reposilite      32 May  1 11:13 test-1.0.0.jar.md5
-rw-r--r-- 1 reposilite reposilite      40 May  1 11:13 test-1.0.0.jar.sha1
-rw-r--r-- 1 reposilite reposilite      64 May  1 11:13 test-1.0.0.jar.sha256
-rw-r--r-- 1 reposilite reposilite     128 May  1 11:13 test-1.0.0.jar.sha512
-rw-r--r-- 1 reposilite reposilite     452 May  1 11:13 test-1.0.0.pom

[reposilite@server test]$ for method in md5 sha1 sha256 sha512; do cmd="${method}sum"; actual=$(eval "${cmd} 1.0.0/test-1.0.0.jar" | awk {'print $1'}); content=$(cat 1.0.0/test-1.0.0.jar.${method}); echo "${method}: ACTUAL: ${actual} - FILE: ${content}"; done
md5: ACTUAL: d76d70b64243d764288a8dd5e00f4a5a - FILE: d76d70b64243d764288a8dd5e00f4a5a
sha1: ACTUAL: 9f28e857f10ad5cb993e2707f01ec0a6436fe162 - FILE: da39a3ee5e6b4b0d3255bfef95601890afd80709
sha256: ACTUAL: aa47d610dd7507241727296b9330eeec6988d361279a9f9b5c580439ec5e212e - FILE: e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
sha512: ACTUAL: 0596fece237e4478810c834baffc7b2ae108c196b90cd28070a6fecf97bf6240dc87809ef44e674eec0643aef954b63a4b96a2ac9748d17a253afd8fc08ecd8f - FILE: cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e

[reposilite@server test]$ for method in md5 sha1 sha256 sha512; do cmd="${method}sum"; actual=$(eval "${cmd} maven-metadata.xml" | awk {'print $1'}); content=$(cat maven-metadata.xml.${method}); echo "${method}: ACTUAL: ${actual} - FILE: ${content}"; done
md5: ACTUAL: 460ba9fac19195438158c663af89ecd0 - FILE: 460ba9fac19195438158c663af89ecd0
sha1: ACTUAL: b67b07034bd3861034715e71a21f1c2e52701783 - FILE: da39a3ee5e6b4b0d3255bfef95601890afd80709
sha256: ACTUAL: 71262a4bde9120a1f817204037ab8fb7a19ae198fd3b236f25edd0e0125f365d - FILE: e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
sha512: ACTUAL: bbf9310992819454b41e5b9d7a4f6d77aa9baba499af34fd872477603ec4d2ecca82bc58602c28008062af73c41252611654dfdd36aec7a44e2e41d3790e42cd - FILE: cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e
```

## Interface

The tests use these declarations:

- `enum class com.reposilite.maven.api.Checksum` with `val extension: String` and `val generate: (InputStream) -> String`
