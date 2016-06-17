#! /usr/bin/env bash

# IOS.cmake
# Architectures: i386 armv7 armv7s x86_64 arm64

# declare -a ABIs=("SIMULATOR" "OS" "SIMULATOR64")
declare -a ABIs=("OS")
# declare -a ABIs=("SIMULATOR")

# declare -a BUILD_TYPES=("Debug" "Release")
declare -a BUILD_TYPES=("Debug")
# declare -a BUILD_TYPES=("Release")

PROJECT_NAME=example


rm -rf "build/ios"
rm -rf "bin/ios"

for ABI in "${ABIs[@]}"
do
	echo "$ABI"

	mkdir -p "build/ios/$ABI"

	cmake -G"Xcode" \
	 -DCMAKE_TOOLCHAIN_FILE="cmake/Toolchains/iOS.cmake" \
	 -DIOS_PLATFORM=$ABI \
	 -B"build/ios/$ABI" -H.


	for BUILD_TYPE in "${BUILD_TYPES[@]}"
	do
	echo "$BUILD_TYPE"

		cmake --build "build/ios/$ABI" \
		 --target ALL_BUILD --config $BUILD_TYPE

		echo "-----"
	done

	echo "----------"
done


# # Put all librarues in the fat file.
# echo "Create FAT library!"
#
# for BUILD_TYPE in "${BUILD_TYPES[@]}"
# do
# echo "$BUILD_TYPE"
#
# 	mkdir -p "bin/ios/$BUILD_TYPE/UNIVERSAL"
#
# 	LIPO_LIBRARIES=$(
# 		for ABI in "${ABIs[@]}"
# 		do
# 			echo "bin/ios/$BUILD_TYPE/$ABI/lib${PROJECT_NAME}.a"
# 		done
# 	)
#
# 	echo $LIPO_LIBRARIES
#
# 	lipo -create -output "bin/ios/$BUILD_TYPE/UNIVERSAL/lib${PROJECT_NAME}-$BUILD_TYPE.a" \
# 		$LIPO_LIBRARIES
#
# 	lipo -info bin/ios/$BUILD_TYPE/UNIVERSAL/lib${PROJECT_NAME}-$BUILD_TYPE.a
#
# 	echo "-----"
# done

echo "done"
