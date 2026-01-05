#!/bin/bash
# compile.sh - Compile the project for Linux or Windows

set -e  # Exit on error

# Default values
BUILD_TYPE=""
RUN_EXEC=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --build)
            BUILD_TYPE="$2"
            shift 2
            ;;
        --run)
            RUN_EXEC=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 --build [linux-debug|linux-release|win-debug|win-release] [--run]"
            exit 1
            ;;
    esac
done

if [[ -z "$BUILD_TYPE" ]]; then
    echo "Error: --build option is required."
    exit 1
fi

# Directories
OBJ_DIR=""
BIN_DIR=""
CC=""
CFLAGS="-std=c17 -Wall -Wextra -Wpedantic"
LDFLAGS=""
EXE_NAME=""
RUN_CMD=""

case $BUILD_TYPE in
    linux-debug)
        OBJ_DIR="bin/debug/obj"
        BIN_DIR="bin/debug"
        CC="gcc"
        CFLAGS="$CFLAGS -g -O0 -DDEBUG -I include -I include/engine $(sdl2-config --cflags)"
        LDFLAGS="$(sdl2-config --libs) -lSDL2_image"
        EXE_NAME="main"
        RUN_CMD="./$BIN_DIR/$EXE_NAME"
        ;;
    linux-release)
        OBJ_DIR="bin/release/obj"
        BIN_DIR="bin/release"
        CC="gcc"
        CFLAGS="$CFLAGS -O2 -DNDEBUG -I include -I include/engine $(sdl2-config --cflags)"
        LDFLAGS="$(sdl2-config --libs) -lSDL2_image"
        EXE_NAME="main"
        RUN_CMD="./$BIN_DIR/$EXE_NAME"
        ;;
    win-debug)
        OBJ_DIR="bin/debug/obj"
        BIN_DIR="bin/debug"
        CC="x86_64-w64-mingw32-gcc"
        CFLAGS="$CFLAGS -g -O0 -DDEBUG -m64 -I include -I include/engine -I deps/SDL2/include/SDL2 -I deps/SDL2_image/include/SDL2"
        LDFLAGS="-L deps/SDL2/lib -L deps/SDL2_image/lib -lmingw32 -lSDL2main -lSDL2 -lSDL2_image"
        EXE_NAME="main.exe"
        RUN_CMD="$BIN_DIR/$EXE_NAME"
        ;;
    win-release)
        OBJ_DIR="bin/release/obj"
        BIN_DIR="bin/release"
        CC="x86_64-w64-mingw32-gcc"
        CFLAGS="$CFLAGS -O2 -DNDEBUG -m64 -I include -I include/engine -I deps/SDL2/include/SDL2 -I deps/SDL2_image/include/SDL2"
        LDFLAGS="-L deps/SDL2/lib -L deps/SDL2_image/lib -lmingw32 -lSDL2main -lSDL2 -lSDL2_image"
        EXE_NAME="main.exe"
        RUN_CMD="$BIN_DIR/$EXE_NAME"
        ;;
    *)
        echo "Unknown build type: $BUILD_TYPE"
        exit 1
        ;;
esac

# Prepare folders
mkdir -p "$OBJ_DIR" "$BIN_DIR"

# Clean old objects
rm -f "$OBJ_DIR"/*.o

# Compile sources
$CC $CFLAGS -c src/*.c src/engine/*.c
mv *.o "$OBJ_DIR"

# Link
$CC "$OBJ_DIR"/*.o -o "$BIN_DIR/$EXE_NAME" $LDFLAGS

# Copy resources
cp -r res "$BIN_DIR/"

# Copy Windows DLLs if needed
if [[ "$BUILD_TYPE" == win-* ]]; then
    mkdir -p "$BIN_DIR"
    cp -f bin/dll/*.dll "$BIN_DIR/" 2>/dev/null || true
fi

# Run executable for debug builds by default or if --run is passed
if [[ "$RUN_EXEC" = true || "$BUILD_TYPE" == linux-debug || "$BUILD_TYPE" == win-debug ]]; then
    echo "Running $BIN_DIR/$EXE_NAME..."
    $RUN_CMD
fi

echo "Build '$BUILD_TYPE' completed successfully!"
