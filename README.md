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

**Encumbrance Percentage**: the actor's encumbrance percentage (carrying 120 of 300 = 40% or 0.4) is multiplied by triple the down-pull multiplier.

The default down-pull multiplier value of 100 acts somewhat the same across all formulas. Encumbrance is a bit different, as while it's possible,
and quite easy, to have values of 0 for equipped armour and total equipment weight, the same cannot be said of encumbrance. It also can
vary greatly from character to character, while armour class and weight are static across the board. For a happy medium between the frustration
of realism and frustration-free video game-ness, I recommend the default values, and not wearing heavy armour whilst swimming, but the options
are there for those who desire them.

Enable debug logging, and check MWSE for the exact values being used.

## Requirements ##
MGE XE with MWSE @ [Nexus Mods](https://www.nexusmods.com/morrowind/mods/41102) \(Make sure you run MWSE-Update.exe\)

## Credits ##

* MWSE Team for MWSE with Lua support

## License ##

MIT License. See LICENSE file.
