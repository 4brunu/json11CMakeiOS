# json11CMakeiOS

This sample project show a problem when adding [json11](https://github.com/dropbox/json11) as a subdirectory in CMake.

What I'm trying to acomplish here, is create a static library to use in a iOS project.

The error is the following.

```
=== BUILD TARGET json11_test OF PROJECT example_all WITH CONFIGURATION Debug ===

Check dependencies
target specifies product type 'com.apple.product-type.tool', but there's no such product type for the 'iphoneos' platform

** BUILD FAILED **


The following build commands failed:
	Check dependencies
(1 failure)
```

I had made some tests, and modified the [json11 CMakeList.txt](https://github.com/4brunu/json11CMakeiOS/blob/master/deps/json11/CMakeLists_no_tests.txt) to remove the tests, and it work's fine.

Not sure if it's a CMake configuration issue, a [iOS toolchain](https://github.com/4brunu/json11CMakeiOS/blob/master/cmake/Toolchains/iOS.cmake), or any other thing.

