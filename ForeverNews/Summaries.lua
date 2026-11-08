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

  -- Patch Notes, November 4, 2026: small UI fixes
  [2026110410] = {
    date = "2026-11-04",
    asOf = "2026-11-08",

    en = {
      overall = {
        "Swing Timer bar no longer fades out by distance until the swing finishes.",
        "Combined bag: slot background art now shows which bag a slot belongs to.",
        "Nameplates now correctly show Elite status.",
        "Debuff icons on nameplates can now be clicked through.",
        "Spellbook and Talents frame opens at the same height as other panels.",
        "Combat mode makes the Spellbook frame smaller.",
        "PvP scoreboard display was updated.",
        "Killing a player at the Honor cap no longer shows honor gained text.",
        "Keybinds menu: hovering over an action bar keybind highlights that button.",
      },
    },

    de = {
      overall = {
        "Die Kampftempo-Leiste blendet sich wegen Entfernung erst nach dem Schlag aus.",
        "Kombinierte Tasche: Der Hintergrund zeigt jetzt, zu welcher Tasche ein Slot gehört.",
        "Namensschilder zeigen jetzt richtig an, wenn ein Gegner Elite ist.",
        "Debuff-Symbole auf Namensschildern lassen sich jetzt durchklicken.",
        "Zauberbuch und Talente öffnen sich jetzt auf gleicher Höhe wie andere Fenster.",
        "Im Kampfmodus wird das Zauberbuch-Fenster kleiner angezeigt.",
        "Die PvP-Anzeigetafel wurde überarbeitet.",
        "Tötest du einen Spieler am Ehre-Limit, wird kein Ehre-Text mehr angezeigt.",
        "Tastenbelegungs-Menü: Zeigt beim Drüberfahren den passenden Button auf der Leiste.",
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

  -- Hotfixes (continuously updated Blizzard article), newest block: November 6, 2026
  [24315281] = {
    date = "2026-11-06",
    asOf = "2026-11-07",

    en = {
      overall = {
        "Only small fixes, no big changes.",
        "Dungeons: bugs fixed in Maraudon, Blackmaw Hold and The Drowned City.",
        "Tauren: Plainsrunning can no longer be stacked in battlegrounds.",
        "The Legacy talent The Quick and the Dead works properly now.",
        "The Cooldown Manager now shows crowd control durations correctly.",
      },
      classes = {
        DRUID = {
          "Bloom now heals correctly. Several tooltips were fixed.",
        },
        MAGE = {
          "Research is gone, only Study remains. Arcane Blast now really lasts 18 sec.",
        },
        ROGUE = {
          "Shank now shows rank and combo points correctly.",
        },
        WARLOCK = {
          "Voidwalker has about 40 more health. Soul Siphon no longer wrongly boosts Wrack.",
        },
        WARRIOR = {
          "The Reckless Swings tooltip was fixed.",
        },
      },
    },

    de = {
      overall = {
        "Nur kleine Fehler behoben, keine großen Änderungen.",
        "Dungeons: Fehler in Maraudon, Blackmaw Hold und The Drowned City behoben.",
        "Tauren: Plainsrunning lässt sich im Schlachtfeld nicht mehr stapeln.",
        "Das Legacy-Talent The Quick and the Dead geht jetzt richtig.",
        "Der Cooldown Manager zeigt die Dauer von Kontrollzaubern richtig an.",
      },
      classes = {
        DRUID = {
          "Bloom heilt jetzt richtig. Mehrere Tooltips wurden korrigiert.",
        },
        MAGE = {
          "Research ist weg, nur Study bleibt. Arcane Blast hält jetzt wirklich 18 Sek.",
        },
        ROGUE = {
          "Shank zeigt Rang und Combopunkte richtig an.",
        },
        WARLOCK = {
          "Voidwalker hat etwa 40 Leben mehr. Soul Siphon macht Wrack nicht mehr fälschlich stärker.",
        },
        WARRIOR = {
          "Der Tooltip von Reckless Swings wurde korrigiert.",
        },
      },
    },
  },
}
