-- Short summaries of the patch notes (written by Claude/AI, NOT generated automatically).
--
-- Key = entry id from News.lua. "date" must match the entry's date; if an entry is extended later
-- (e.g. the continuously updated hotfixes), its summary counts as outdated.
--
-- Every entry has one block per language: en (required, also the fallback) and de.
-- The addon shows the block for the game client's language. To add a language, add a block such as `fr = { ... }`
-- to every entry (see Locales.lua for the interface texts).
--
-- Style: simple language, short sentences, one statement per bullet, numbers exactly as in the original.
-- Names of abilities and talents stay in English (as in the game).
-- A bullet that starts with "Planned" / "Geplant" is shown in orange (it means: not live yet).

ForeverNewsSummaries = {

  -- Announcement, November 8, 2026
  [2406595] = {
    date = "2026-11-08",
    asOf = "2026-11-09",

    en = {
      overall = {
        "Dungeon kill experience (XP) increased by 50%.",
        "This hotfix went live around 11:05 PST on November 8.",
      },
    },

    de = {
      overall = {
        "Erfahrungspunkte (XP) für Kills in Dungeons um 50 % erhöht.",
        "Der Hotfix ist seit etwa 11:05 Uhr PST am 8. November live.",
      },
    },
  },

  -- Launch patch, November 3, 2026
  [2026110309] = {
    date = "2026-11-03",
    asOf = "2026-11-07",

    en = {
      overall = {
        "Every class deals more damage. In return, stronger enemies have more health.",
        "Almost all talent trees were rebuilt.",
        "Learning spells now costs the same for every class: about 207 gold up to level 60.",
        "New spells no longer land on your action bars by themselves. You equip bags yourself.",
        "Racial abilities were adjusted.",
        "No big balance changes until the raids open in December.",
      },
      classes = {
        DRUID = {
          "Cat: much more damage (e.g. Shred 200% instead of 155%).",
          "Bear: holds enemies better (threat +115% instead of +50%).",
          "New: the passive ability Poised (level 32) and the healer talent Bloom.",
          "Gone: the talent Berserk.",
        },
        HUNTER = {
          "More damage: Aimed Shot (about +110%), Arcane Shot and Serpent Sting.",
          "All traps now share one 30 sec cooldown.",
          "Hunter's Mark can no longer be stacked with different ranks.",
        },
        MAGE = {
          "Frost Blast is gone.",
          "Arcane Blast costs less mana per stack and lasts 18 sec.",
          "Frost: Ice Barrier now gives +15% frost damage.",
        },
        PALADIN = {
          "Righteous Fury is available from level 10 and gives more threat.",
          "Gone: Salvation and Blessing of Light.",
          "New talents for Holy, Protection and Retribution.",
        },
        PRIEST = {
          "Shadow Word: Death now costs you 30% of your health on a miss (was 10%).",
          "Holy: Binding Heal is gone, replaced by Holy Binding.",
        },
        ROGUE = {
          "New spell: Shank (from level 24).",
          "Poisons deal twice as much damage.",
          "Many talents were rebuilt; some are new, some are gone.",
        },
        SHAMAN = {
          "Lightning Bolt and Chain Lightning deal more damage.",
          "Enhancement: Stormstrike deals more damage and is ready sooner (6 sec).",
          "Elemental: Lava Burst is gone.",
          "Restoration: Riptide costs less but now only heals over time.",
        },
        WARLOCK = {
          "Pets are less durable (2 instead of 7.5 health per Stamina).",
          "Affliction: Wrack deals much more damage.",
          "Destruction: Shadow and Flame is twice as strong.",
        },
        WARRIOR = {
          "Defensive Stance: much more threat (+80% instead of +30%).",
          "Slam is ready sooner (15 sec).",
          "Fury: new talents; Flurry and Bloodthirst work differently.",
        },
      },
    },

    de = {
      overall = {
        "Alle Klassen machen mehr Schaden. Dafür haben starke Gegner mehr Leben.",
        "Fast alle Talentbäume wurden umgebaut.",
        "Zauber lernen kostet jetzt für alle Klassen gleich viel: etwa 207 Gold bis Stufe 60.",
        "Neue Zauber landen nicht mehr automatisch in deiner Leiste. Taschen legst du selbst an.",
        "Die Völker wurden angepasst.",
        "Bis die Raids im Dezember öffnen, gibt es keine großen Balance-Änderungen mehr.",
      },
      classes = {
        DRUID = {
          "Katze: viel mehr Schaden (z. B. Shred 200 % statt 155 %).",
          "Bär: hält Gegner besser (Bedrohung +115 % statt +50 %).",
          "Neu: die passive Fähigkeit Poised (Stufe 32) und das Heiler-Talent Bloom.",
          "Weg: das Talent Berserk.",
        },
        HUNTER = {
          "Mehr Schaden: Aimed Shot (etwa +110 %), Arcane Shot und Serpent Sting.",
          "Alle Fallen teilen sich jetzt 30 Sek. Abklingzeit.",
          "Hunter's Mark lässt sich nicht mehr mit verschiedenen Rängen stapeln.",
        },
        MAGE = {
          "Frost Blast gibt es nicht mehr.",
          "Arcane Blast kostet pro Stapel weniger Mana und hält 18 Sek.",
          "Frost: Ice Barrier gibt jetzt +15 % Frostschaden.",
        },
        PALADIN = {
          "Righteous Fury gibt es schon ab Stufe 10 und bringt mehr Bedrohung.",
          "Weg: Salvation (Segen des Heils) und Blessing of Light.",
          "Neue Talente bei Heilig, Schutz und Vergeltung.",
        },
        PRIEST = {
          "Shadow Word: Death kostet dich bei einem Fehlschlag jetzt 30 % deines Lebens (vorher 10 %).",
          "Heilig: Binding Heal ist weg, dafür gibt es Holy Binding.",
        },
        ROGUE = {
          "Neuer Zauber: Shank (ab Stufe 24).",
          "Gifte machen doppelt so viel Schaden.",
          "Viele Talente wurden umgebaut, einige sind neu oder weg.",
        },
        SHAMAN = {
          "Lightning Bolt und Chain Lightning machen mehr Schaden.",
          "Verstärker: Stormstrike macht mehr Schaden und ist schneller wieder bereit (6 Sek.).",
          "Elementar: Lava Burst ist weg.",
          "Wiederherstellung: Riptide kostet weniger, heilt aber nur noch über Zeit.",
        },
        WARLOCK = {
          "Pets halten weniger aus (2 statt 7,5 Leben pro Ausdauer).",
          "Gebrechen: Wrack macht deutlich mehr Schaden.",
          "Zerstörung: Shadow and Flame ist doppelt so stark.",
        },
        WARRIOR = {
          "Defensivhaltung: viel mehr Bedrohung (+80 % statt +30 %).",
          "Slam ist früher wieder bereit (15 Sek.).",
          "Furor: neue Talente, Flurry und Bloodthirst funktionieren anders.",
        },
      },
    },
  },

  -- Announcement "Class Tuning Incoming - November 10" (Blizzard forum, November 6, 2026): PLANNED, not live yet
  [2404092] = {
    date = "2026-11-06",
    asOf = "2026-11-07",

    en = {
      overall = {
        "Planned for Tuesday, November 10. Not live yet!",
        "More adjustments may follow every Tuesday.",
      },
      classes = {
        HUNTER = {
          "Hunter pets should hold up better as tanks (like in Classic Era).",
        },
        WARLOCK = {
          "Voidwalkers should hold up better as tanks.",
          "Affliction: DoTs like Corruption and Bane of Agony should be worth casting again.",
        },
        SHAMAN = {
          "Enhancement: Strength should be the best stat again, not Intellect.",
          "Tip from Blizzard: while leveling, collect gear with Strength and Attack Power.",
        },
      },
    },

    de = {
      overall = {
        "Geplant für Dienstag, 10. November. Noch nicht live!",
        "Weitere Anpassungen können jeden Dienstag folgen.",
      },
      classes = {
        HUNTER = {
          "Jäger-Pets sollen als Tank mehr aushalten (wie in Classic Era).",
        },
        WARLOCK = {
          "Voidwalker sollen als Tank mehr aushalten.",
          "Gebrechen: DoTs wie Corruption und Bane of Agony sollen sich wieder lohnen.",
        },
        SHAMAN = {
          "Verstärker: Stärke soll wieder der beste Wert sein, nicht Intelligenz.",
          "Tipp von Blizzard: Sammle beim Leveln Ausrüstung mit Stärke und Angriffskraft.",
        },
      },
    },
  },

  -- Hotfixes (continuously updated Blizzard article), newest block: November 10, 2026
  [24315281] = {
    date = "2026-11-10",
    asOf = "2026-11-11",

    en = {
      overall = {
        "Auction House: minimum deposit now 1 copper (was 1 silver).",
        "Most quests level 48 and higher now also reward gold.",
        "The Drowned City: enemies dealt about 30% too much damage, now fixed. Deathless Marrow (inside it): creature health and Fireball damage both -25%.",
        "Dungeon kill experience (XP) still increased by 50% (hotfix from November 9).",
        "Blackrock Depths: Heart of the Mountain can now be looted more than once.",
        "All racial vendor mounts are now Bind-on-Pickup. Some crafted armor items now sell to vendors for less gold.",
      },
      classes = {
        DRUID = {
          "Omen of Clarity can activate again after swapping specializations (was broken).",
          "Restoration: Nature's Swiftness now also makes Wild Growth instant.",
          "Bloom now heals correctly. Several tooltips were fixed (Bear Form, Ravage, Swiftmend).",
        },
        HUNTER = {
          "Pet health bug fixed: pets now correctly have 115% of normal health (was wrongly 150%).",
          "Arcane Shot now costs 11% of base Mana at every rank (previously differed by rank).",
          "Beast Mastery: Summon Hawk also costs 11% of base Mana now. Hawk pet melee damage increased by about 80%.",
        },
        PALADIN = {
          "Redoubt can now be tracked in the Cooldown Manager.",
          "Consecration no longer stops dealing bonus damage if targets inside it despawned earlier.",
        },
        PRIEST = {
          "The Revelation enchant no longer wrongly triggers from Vampiric Embrace healing.",
          "Shadowform no longer breaks when casting Fear Ward. Power Infusion now correctly persists on allies.",
        },
        SHAMAN = {
          "Weapon imbues and weapon totems can now be used at the same time (e.g. Windfury Weapon together with Windfury Totem).",
          "Enhancement: Stormstrike damage reduced to 100% weapon damage (was 150%); cooldown now 8 sec (was 6 sec).",
          "Enhancement: Mental Dexterity now converts 33/66/100% Intellect to Attack Power (was 50/100/150%).",
          "Enhancement: Maelstrom Weapon now reduces cast time/Mana cost by 20% per stack (was 4/8/12/16/20%) and procs 6/7/8/9/10 times per minute by rank (was a flat 20/min at every rank).",
        },
        WARLOCK = {
          "Imp, Voidwalker, Incubus and Succubus all have about 15% more health; Imp's Firebolt damage (first 4 ranks) also increased.",
          "Affliction: Wrack damage reduced by 30% and no longer boosts periodic damage directly - instead Corruption, Siphon Life and Bane of Agony tick 100% faster (twice as often) while Wrack is channeled.",
          "Affliction: Soul Siphon's bonus to Drain Life/Drain Soul/Wrack now scales per active DoT (4/8/12% each, up to 36% max), instead of applying for any Affliction spell.",
          "Destruction: Bane of Havoc now correctly triggers a global cooldown again (was bugged).",
        },
        WARRIOR = {
          "Arms: Sweeping Strikes no longer loses charges if the second target isn't hit.",
        },
      },
    },

    de = {
      overall = {
        "Auktionshaus: Mindestkaution jetzt 1 Kupfer (vorher 1 Silber).",
        "Die meisten Quests ab Level 48 geben jetzt zusätzlich Gold.",
        "The Drowned City: Gegner machten etwa 30 % zu viel Schaden, jetzt behoben. Deathless Marrow (darin): Leben der Gegner und Schaden von Fireball je um 25 % reduziert.",
        "Dungeon-Erfahrung (XP) weiterhin um 50 % erhöht (Hotfix vom 9. November).",
        "Blackrock Depths: Heart of the Mountain kann jetzt mehrfach geplündert werden.",
        "Reit-Mounts von Völkern sind jetzt Bind-on-Pickup. Manche gefertigte Rüstung bringt beim Verkauf an Händler weniger Gold.",
      },
      classes = {
        DRUID = {
          "Omen of Clarity funktioniert nach einem Spezialisierungswechsel wieder (war vorher kaputt).",
          "Wiederherstellung: Nature's Swiftness macht jetzt auch Wild Growth sofort wirksam.",
          "Bloom heilt jetzt richtig. Mehrere Tooltip-Fehler behoben (Bear Form, Ravage, Swiftmend).",
        },
        HUNTER = {
          "Pet-Fehler behoben: Pets haben jetzt korrekt 115 % ihres normalen Lebens (vorher fälschlich 150 %).",
          "Arcane Shot kostet jetzt bei jedem Rang 11 % des Grundmana (vorher je Rang unterschiedlich).",
          "Beast Mastery: Summon Hawk kostet jetzt ebenfalls 11 % Grundmana. Nahkampfschaden des Hawk-Pets um etwa 80 % erhöht.",
        },
        PALADIN = {
          "Redoubt lässt sich jetzt im Cooldown Manager verfolgen.",
          "Consecration hört nicht mehr auf, Bonusschaden zu machen, wenn Ziele darin vorher verschwunden sind.",
        },
        PRIEST = {
          "Das Revelation-Enchant wird nicht mehr fälschlich durch Vampiric Embrace-Heilung ausgelöst.",
          "Shadowform bricht nicht mehr beim Wirken von Fear Ward. Power Infusion hält jetzt korrekt auf Verbündeten an.",
        },
        SHAMAN = {
          "Waffenverzauberungen (Weapon Imbues) und Waffentotems lassen sich jetzt gleichzeitig nutzen (z. B. Windfury Weapon zusammen mit Windfury Totem).",
          "Verstärker: Stormstrike-Schaden auf 100 % Waffenschaden reduziert (vorher 150 %); Abklingzeit jetzt 8 Sek. (vorher 6 Sek.).",
          "Verstärker: Mental Dexterity wandelt jetzt 33/66/100 % Intelligenz in Angriffskraft um (vorher 50/100/150 %).",
          "Verstärker: Maelstrom Weapon verringert Zauberzeit/Manakosten jetzt um 20 % pro Stapel (vorher 4/8/12/16/20 %) und löst je nach Rang 6/7/8/9/10 Mal pro Minute aus (vorher pauschal 20 Mal/Minute bei jedem Rang).",
        },
        WARLOCK = {
          "Imp, Voidwalker, Incubus und Succubus haben alle etwa 15 % mehr Leben; Imp's Firebolt-Schaden (erste 4 Ränge) ebenfalls erhöht.",
          "Gebrechen: Wrack-Schaden um 30 % reduziert und erhöht nicht mehr direkt den Schaden über Zeit - stattdessen ticken Corruption, Siphon Life und Bane of Agony während des Kanalisierens 100 % schneller (doppelt so oft).",
          "Gebrechen: Der Bonus von Soul Siphon auf Drain Life/Drain Soul/Wrack richtet sich jetzt nach aktiven DoTs (je 4/8/12 %, maximal 36 %), statt nach irgendeinem Gebrechen-Zauber.",
          "Zerstörung: Bane of Havoc löst jetzt wieder korrekt die globale Abklingzeit aus (war fehlerhaft).",
        },
        WARRIOR = {
          "Arms: Sweeping Strikes verliert keine Ladungen mehr, wenn kein zweites Ziel getroffen wird.",
        },
      },
    },
  },
}
