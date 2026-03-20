
###### Foundations
1 - combat/player stats
2 - map and nodes
3 - dialog encounters
4 - game infrastructure
5 - UI / Hud/ Ux

###### Unmaped needed stuff
- advanced combat interactions
    - Status effects, imunities, buffs, etc... 
- pixel art and content
    - Content should always have
    - associated art and description
- Sound/music
    - No idea how to pull this one off
- Organizing and mapping required content
    - Planing questlines, rare items, 
    - Figure what content mus be made

###### Unmaped wanted features
   Starting classes
   Multiple characters per world
   Rest sites, cooking
   Homebase
   Allies and sumons
   Curses, ghosts, deaths
   Npcs and quests
   Crafting/Enchanting/Alchemy
   Merchants and trainers
   Progression/level up
   Skill trees
   Environment combat effects/modifiers

---

# TODO:

#### 4.0 Make configuration interface
Just code with some constants
For now, this will only be used aa a proxy to the actual game configurations, add configs as needed while developing the next tasks

#### 5.0 Make generic UI class that does nothing 
For now this is just a proxy for godot UI, so that changes in the HUD can inherit from a base behavioir/configuration

---

#### 1.1 basic combat screen
Combat screen that recieves mock encounter data

Encounter data (enemy list) 
Enemy data with mock attributes

Mocked player (combatent) data

Basic combat logic and turn order

#### 1.2 player stats
Player skills, player weapon, player inventory, player powers and passives. All configured via code, no screen

#### 1. 3 player management screens
Change player weapon, skills etc... Should be based on a pool of resources (no aquiring, buying etc...)
For now should only exist, not be pretty or usable

#### 1.4 Combat ended screen
Give loot, exp and other stuff. Should be dynamic

---

#### 2.1 basic map layout and game loop. 
Combat screen, choose a available node, enter combat, return to map.
Player management available on map screen

Keep track of discovered nodes
Keep track of player position
Keep statistics about encountera

Should be expansible (with events) for future functionality.

Node should be a mocked abstraction (now it only redirects to a encounter) 

#### 2.2 Node configuration
Make the encounters on each node configurable. Could be random, could be obrigatory, could be calculated, etc... 

Make node depth? 
Make option to have multiple encounters per node

#### 2.3 improving the map. 
Make subtrees scene possible
Make undiscovered nodes not apear
Make undiscovered connections not appear

#### 4.1 mock start screen
Just a screen with start button.
Add a button in the map to return to start screen

#### 2.4 allow nodes and parts of the tree to be randomly generated from a seed given some constraints

---
#  3.1 make basic choice event type
Just some text and some options, depending on the chosen action, character flags, world flags, items, skills, xp, etc... Could be gained by the player

#### 3.2 improving nested dialog options
Some options should lead to further dialog and  return to previous states. 
Adapt the encounter logic to allow dialog encounters
Make so that the outcome of a dialog can be another encounter (combat) 
---

4.2 improve title screen
Include configuration editor
Should have diferent inputs for diferent types

4.3 structure menu
Define a structured way to handle the game menus on all screens (title, map, encounter). 
Menus should be able to have sections, inputs, action buttons, validations, etc... 

4.4 basic saving sistem. 
Make a dynamic saving system. New "recorded entities" should be able to be registered in a scope. The scopes are: 
- game (example: config file) 
- world (example: discovered nodes, player position) (should be deleted when the "save" is deleted) 
- player (example: chosen equipment, encounter statistics).
- state (example: enemy hp, current turn) (should be discarted once the encounter ir resolved. 

Save and load buttons should be added to the title and map screens

---

#### 5.1 structured ui
Given the needs of the current UI. Structure a reusable solution to deal with it. 

It should be customizable. Make it kinda pretty so that we figure what customizations are needed. 

It should read from a translation table

#### 5.2 text tooltips
Make a system that dynamicaly replaces text with something resemblimg slay the spire

Make a resource that represents the tooltip text and recieves a number as argument

#### 5.3 UX considerations. 
Build some ease of use into the menus, make them less intrusive and more intuitive (obviously nothis is definitive, this is just a starting point) 

---

#### 6.0 define requirenmentes for advanced combat
Figure data structure, events, class modeling etc... 

#### 6.1 refactor character stats 
include mana
Make dynamic?

#### 6.2 add enemy types and AI
Enemies should have a defined ai
Ai can be overriden in encounter so that we can configure pack tatics

#### 6.3 base implementations for skills/powers/status effects
They will need to reference code snipets via enum? Build those reusable code snippets

#### 6.4 refactor targeting sistem?? 

#### 6.5 environmental effects
Some effects should be added by the terrain or climate (encounter, node or subtree). 

---
#  7.1 menu sounds
Add a basic sound and figure out how importing/using/configuring sounds in godot works

#### 5.4 smooth transitions and effects
Text fading in, wable, screen shake, diferent fonts? etc... 

---

#### 7.2 dynamic skill sound
Define generic sounds for damage type, block, dying etc... 
Mix this sounds contextualy
I think this is the easiest way to make decent sounds with the lowest effort, but we will see
This would also work for for speach, make a sound for each letter