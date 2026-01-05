# Pebble

**Pebble** is a small, simple 2D game engine written in **C** on top of **SDL2**.  

It focuses on:

- Clarity over abstraction  
- Game logic living in `main.c`  
- Minimal helpers instead of large systems  

---

## Philosophy

Pebble is built around a few core ideas:

- **Small on purpose** – The engine only provides what is reused across games.  
- **Game logic stays in `main.c`** – Pebble helps, it does not decide.  
- **No ECS** – Entities are simple structs. Animations are arrays. Logic is explicit.  
- **Readable C** – If you can read C, you can understand the engine.  
- **SDL2-first** – Pebble wraps SDL just enough to be pleasant.  

---

## Features

- **Window & renderer wrapper**  
- **Texture handling** – Loading, scaling, drawing  
- **Input helpers** – Pressed / held detection  
- **Delta-time helper**  
- **Vec2 math utilities**  
- **Simple physics helpers**  
  - Rectangle overlap detection  
  - Clamping  
- **Camera** – Follow + clamp  
- **Entities**  
  - Position  
  - Sprite  
  - Basic animations (frame cycling)  
- **Tile / platform draw helpers**  

---

## Dependencies

### Windows
Building the engine only has commands for linux builds at time of writing.
You can easily port the commands over to windows using MinGW-W64 on windows.

I highly recommend using the latest gcc posix-seh with UCRT64 compiler from ```https://winlibs.com/#download-release```

Here is an example of a windows build command:
```
gcc -std=c17 -g -O0 -DDEBUG -Wall -I include -I include/engine -I deps/SDL2/include/SDL2 -I deps/SDL2_image/include/SDL2 -c src/*.c src/engine/*.c
mkdir bin\debug\obj
move *.o bin\debug\obj
gcc bin\debug\obj\*.o -o bin\debug\main.exe -L deps/SDL2/lib -L deps/SDL2_image/lib -lmingw32 -lSDL2main -lSDL2 -lSDL2_image
xcopy /E /I res bin\debug\res
xcopy /E /I bin\dll bin\debug
bin\debug\main.exe
```

Also make sure to add ```C:\mingw64\bin``` to your env path variable in windows otherwise your compiler wont be recognized.

### Linux

In order to run the engine on linux you must install sdl2 and a compiler via your package manager.

**Arch**
```sudo pacman -S sdl2 sdl2_image gcc```

**Ubuntu/Debian Based**
```sudo apt install libsdl2-dev libsdl2-image-dev```

If you would like to compile for windows on linux using the .sh or sublime build command you must install mingw on your distro.

**Arch**
```sudo pacman -S mingw-w64-gcc```

**Ubuntu/Debian Based**
```sudo apt install ```

## Building

You can build Pebble using **Sublime Text** or via the **command line**.

### Using Sublime Text

1. Open the project in Sublime Text.  
2. Select the build system for your platform and configuration:  
   - `Linux Debug` / `Linux Release`  
   - `Windows Debug` / `Windows Release` (cross-compiles on Linux using `x86_64-w64-mingw32-gcc`)  
3. Press **F7** to build.  
4. The compiled executable and `res` folder will be placed in:  
   - `bin/debug` for debug builds  
   - `bin/release` for release builds  

> Debug builds automatically run the executable after compilation.

---

### Using the Command Line

A `compile.sh` script is included for terminal builds.

```bash
# Make the script executable
chmod +x scripts/compile.sh

# Build Linux debug (also runs)
./scripts/compile.sh --build linux-debug

# Build Linux release
./scripts/compile.sh --build linux-release

# Build Windows debug (cross-compile)
./scripts/compile.sh --build win-debug

# Build Windows release (cross-compile)
./scripts/compile.sh --build win-release

# Optional: force run a release build
./scripts/compile.sh --build linux-release --run
```

### Notes

- Object files are separated into bin/debug/obj and bin/release/obj.

- The res folder is automatically copied to the build directory.

- Windows builds require DLLs in bin/dll (copied automatically to the build folder).
