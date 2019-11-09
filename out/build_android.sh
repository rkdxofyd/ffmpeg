#!/bin/bash
NDK=/home/trkang/android-ndk-r20
TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64
CC=$TOOLCHAIN/bin/aarch64-linux-android24-clang
CXX=$TOOLCHAIN/bin/aarch64-linux-android24-clang++

function build_one
{
	../configure \
		--prefix=$PREFIX \
		--enable-shared \
		--disable-static \
		--disable-doc \
		--disable-ffmpeg \
		--disable-ffplay \
		--disable-ffprobe \
		--disable-avdevice \
		--disable-symver \
		--cross-prefix=$CROSS_PREFIX \
		--target-os=android \
		--arch=$ARCH \
		--enable-cross-compile \
		--extra-cflags="-Os -fpic $ADDI_CFLAGS" \
		--extra-ldflags="$ADDI_LDFLAGS" \
		$ADDITIONAL_CONFIGURE_FLAG \
		--cc="$CC" \
		--cxx="$CXX"
	make clean
	make
	make install
}

CPU=arm64
ARCH=arm64
CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android-
PREFIX=$(pwd)/android/$CPU
ADDI_CFLAGS="-D__ARM_ARCH_8__"

build_one

CC=$TOOLCHAIN/bin/armv7a-linux-androideabi24-clang
CXX=$TOOLCHAIN/bin/armv7a-linux-androideabi24-clang++
CPU=arm
ARCH=arm
CROSS_PREFIX=$TOOLCHAIN/bin/arm-linux-androideabi-
PREFIX=$(pwd)/android/$CPU
ADDI_CFLAGS="-D__ARM_ARCH_7__"

build_one

CC=$TOOLCHAIN/bin/i686-linux-android24-clang
CXX=$TOOLCHAIN/bin/i686-linux-android24-clang++
CPU=i686
ARCH=i686
CROSS_PREFIX=$TOOLCHAIN/bin/i686-linux-android-
PREFIX=$(pwd)/android/$CPU
ADDI_CFLAGS=""

build_one

CC=$TOOLCHAIN/bin/x86_64-linux-android24-clang
CXX=$TOOLCHAIN/bin/x86_64-linux-android24-clang++
CPU=x86_64
ARCH=x86_64
CROSS_PREFIX=$TOOLCHAIN/bin/x86_64-linux-android-
PREFIX=$(pwd)/android/$CPU
ADDI_CFLAGS=""

build_one

