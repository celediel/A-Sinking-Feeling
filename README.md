# A Sinking Feeling #

## About ##

>He vaulted over the gunwale, landing on the deck below with his golden cloak billowing behind him. The white roses drew back, as men
>always did at the sight of Victarion Greyjoy armed and armored, his face hidden behind his kraken helm. They were clutching swords and
>spears and axes, but nine of every ten wore no armor, and the tenth had only a shirt of sewn scales. _These are no ironmen_, Victarion
>thought. _They still fear drowning._
>- _George R.R. Martin - A Feast for Crows_

No longer can you swim in heavy plate; now your armour, equipment, or carried items drag you down while swimming. Options exist for formulas
based on equipped armour weight class, total equipment weight, or encumbrance percentage.

[Video of the mod in action](https://gfycat.com/needysevereisabellineshrike).

## Formulas ##

**Equipped armour** (*Default option*): the armour class of each equipped item (+1 so Light armour is affected as well,
so Light = 1, Medium = 2, Heavy = 3) is added up for a value of 0 - 27 then multiplied by a tenth of the down-pull multiplier (See MCM).

**Total Equipment Weight**: the weight of each equipped item is added up, the total doubled, then multiplied by a hundredth of the down-pull multiplier.

**Total Equipment Weight (Necro Edit)**: the weight of each equipped item is added up, the total doubled, then multiplied by a hundredth of the down-pull multiplier.
Weight over 135 is only counted for 10% to lessen the gap between the heaviest and lightest heavy armours.

**Encumbrance Percentage**: the actor's encumbrance percentage (carrying 120 of 300 = 40% or 0.4) is multiplied by triple the down-pull multiplier.

**Worst Case Scenario**: calculates results from all formulas, and uses the highest value.

The default down-pull multiplier value of 100 acts somewhat the same across all formulas. Encumbrance is a bit different, as while it's possible,
and quite easy, to have values of 0 for equipped armour and total equipment weight, the same cannot be said of encumbrance. It also can
vary greatly from character to character, while armour class and weight are static across the board. On the other hand, encumbrance can be
modified with feather spells/enchantments, whereas armour weight and weight class can not be modified. For a happy medium between the frustration
of realism and frustration-free video game-ness, I recommend the default values, and not wearing heavy armour whilst swimming, but the options
are there for those who desire them.

Enable debug logging, and check MWSE.log for the exact values being used.

## Requirements ##
MGE XE with MWSE @ [Nexus Mods](https://www.nexusmods.com/morrowind/mods/41102) \(Make sure you run MWSE-Update.exe\)

## Recommended Mods ##
* [Hold Your Breath](https://www.nexusmods.com/morrowind/mods/48872) by Stripes - Endurance determines how long you can hold your breath under water.
* Any mod that enables constant waterbreathing for Argonian races.
	* The no frills [Constant Argonian Water Breathing](https://www.nexusmods.com/morrowind/mods/15193) by Sir Pyrantus
	* [Balanced Passive Races and Birthsigns](https://www.nexusmods.com/morrowind/mods/47782) by BTB + Necrolesian, or the [edit by RandomPal](https://www.nexusmods.com/morrowind/mods/48683)
* [Water Life](https://www.nexusmods.com/morrowind/mods/42417) by abot - see pretty fishes while you drown

## Incompatibilites ##

* The swimming controls part of OperatorJack's [Better Buoyancy](https://www.nexusmods.com/morrowind/mods/48929) is partially incompatible.
If the actor is unarmoured, or unencumbered with that option enabled, Better Buoyancy will work as expected. Otherwise, if this mod is affecting
the actor's velocity, Better Buoyancy will not function. Better Buoyancy's levitation controls are also unaffected.

## Credits ##

* MWSE Team for MWSE with Lua support

## License ##

MIT License. See LICENSE file.
