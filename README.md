# Pebble

**Pebble** is a small, simple 2D game engine written in **C** on top of **SDL2**.

It focuses on:
- clarity over abstraction
- game logic living in `main.c`
- minimal helpers instead of large systems
- no ECS, no scripting, no magic

Pebble is meant to feel like *writing a game*, not wiring an engine.

---

## Philosophy

Pebble is built around a few core ideas:

- **Small on purpose**  
  The engine only provides what is reused across games.

- **Game logic stays in `main.c`**  
  The engine helps — it does not decide.

- **No ECS**  
  Entities are structs. Animations are arrays. Logic is explicit.

- **Readable C**  
  If you can read C, you can understand the engine.

- **SDL2-first**  
  Pebble wraps SDL just enough to be pleasant.

---

## Features

- Window + renderer wrapper
- Texture loading, scaling, and drawing
- Input helpers (pressed / held)
- Delta-time helper
- `Vec2` math
- Simple physics helpers
  - rect overlap
  - clamping
- Simple camera (follow + clamp)
- Entities
  - position
  - sprite
  - basic animations (frame cycling)
- Tile / platform draw helpers

## What Pebble Is Not

Pebble is not:

- a full-featured engine
- a replacement for Unity / Godot
- an ECS framework
- a tool with editors or GUIs
