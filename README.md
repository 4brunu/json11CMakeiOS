# json11CMakeiOS

### This is a sample project to the following SO question http://stackoverflow.com/questions/37880180/error-creating-ios-static-library-using-cmake

I'm trying to create a static library of the project [json11](https://github.com/dropbox/json11) with CMake, to use in a iOS project.

When building the json11 target it work's fine, but the json11_test target return's the following error:

```
=== BUILD TARGET json11_test OF PROJECT example_all WITH CONFIGURATION Debug ===

Check dependencies
target specifies product type 'com.apple.product-type.tool', but there's no such product type for the 'iphoneos' platform

** BUILD FAILED **


The following build commands failed:
    Check dependencies
(1 failure)
```

The original json11 [CMakeLists.txt](https://github.com/4brunu/json11CMakeiOS/blob/master/deps/json11/CMakeLists.txt) is this:

```
cmake_minimum_required(VERSION 3.2)
project(json11 VERSION 1.0.0 LANGUAGES CXX)

enable_testing()

add_library(json11 json11.cpp)
target_include_directories(json11 PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_compile_options(json11
  PUBLIC -std=c++11
  PRIVATE -fno-rtti -fno-exceptions -Wall -Wextra -Werror)
configure_file("json11.pc.in" "json11.pc" @ONLY)

add_executable(json11_test test.cpp)
target_link_libraries(json11_test json11)

install(TARGETS json11 DESTINATION lib)
install(FILES "${CMAKE_CURRENT_SOURCE_DIR}/json11.hpp" DESTINATION include)
install(FILES "${CMAKE_BINARY_DIR}/json11.pc" DESTINATION lib/pkgconfig)
```

After some test's, I had modified the [CMakeLists.txt](https://github.com/4brunu/json11CMakeiOS/blob/master/deps/json11/CMakeLists_no_tests.txt) and it works, but I'm trying to figure out what's wrong.

````
    cmake_minimum_required(VERSION 3.2)
    project(json11 VERSION 1.0.0 LANGUAGES CXX)
    
    enable_testing()
    
    add_library(json11 json11.cpp)
    target_include_directories(json11 PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
    target_compile_options(json11
      PUBLIC -std=c++11
      PRIVATE -fno-rtti -fno-exceptions -Wall -Wextra -Werror)
    configure_file("json11.pc.in" "json11.pc" @ONLY)
    
    # Commented this two lines
    # add_executable(json11_test test.cpp)
    # target_link_libraries(json11_test json11)
    
    install(TARGETS json11 DESTINATION lib)
    install(FILES "${CMAKE_CURRENT_SOURCE_DIR}/json11.hpp" DESTINATION include)
    install(FILES "${CMAKE_BINARY_DIR}/json11.pc" DESTINATION lib/pkgconfig)
```

Not sure if the issue is in the CMake configuration [1](https://github.com/4brunu/json11CMakeiOS/blob/master/run_cmake_ios.sh) [2](https://github.com/4brunu/json11CMakeiOS/blob/master/CMakeLists.txt),  the [iOS toolchain](https://github.com/4brunu/json11CMakeiOS/blob/master/cmake/Toolchains/iOS.cmake), [json11 CMake](https://github.com/4brunu/json11CMakeiOS/blob/master/deps/json11/CMakeLists.txt), or any other thing.

Thanks for the help.
