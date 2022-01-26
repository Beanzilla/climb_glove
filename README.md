# climb_glove
Adds magic gloves which allow you to climb up on things

## What's in the box

- 2 pairs of gloves (one requires you to be pointing at nodes or entities, the other doesn't require anything)
- Supports Minetest Game and Mineclone (2, 5 & Mineclonia)
- Allow choosing if crafting is allowed (defaults to not allowed, this way you could use this mod at a server shop)

## How to climb

With a basic glove just look at say some nodes (like a tree), then just rapidly click the punch key (left mouse button by default).

> The only difference between the basic glove and advanced glove is that the advanced doesn't need you looking at anything.

## Settings

All you need to do to allow crafting is:

1. Add `climb_craft_basic = true` to your `minetest.conf` file (and if you want the advanced one too, `climb_craft_advanced = true`)
2. (Restart if running, else enjoy)

## Credits

- I thank the author of [climbing_pick](https://github.com/AndrejIT/climbing_pick) for the idea, and some ideas from their code.
- I thank the author of [tardis_new](https://github.com/PiDemon/Taridis_New) for the concept of the glove textures, which I modified.
