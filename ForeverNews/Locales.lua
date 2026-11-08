-- Translations for Forever News.
--
-- English is the base language: the English text in the code is also the lookup key, so there is
-- no English table. The addon picks the table that matches the game client's language (GetLocale()).
-- Anything missing here simply shows up in English.
--
-- To add a language: copy the deDE block, change the name (frFR, esES, ptBR, ...), translate the values on
-- the right, and add the same language code ("fr", "es", ...) to every entry in Summaries.lua.
--
-- Special keys:  _months     month names (1-12)
--                _dateLong   format for the headline date: day, month name, year
--                _dateShort  format for the date in the list: day, month, year (two-digit strings)

ForeverNewsLocales = {

  deDE = {
    _months    = { "Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember" },
    _dateLong  = "%d. %s %s",
    _dateShort = "%s.%s.%s",

    -- window, list and buttons
    ["Search in all patches..."] = "Suche in allen Patches...",
    ["Summary only"] = "Nur Zusammenfassung",
    ["Shows only the short summary and hides the detailed changes."] = "Zeigt nur die kurze Zusammenfassung und blendet die ausführlichen Änderungen aus.",
    ["Copy text"] = "Text kopieren",
    ["Back to view"] = "Zurück zur Ansicht",
    ["Shows the text selected. Then just press Ctrl+C."] = "Zeigt den Text markiert an. Dann einfach Strg+C drücken.",
    ["All"] = "Alle",
    ["All classes"] = "Alle Klassen",
    ["Summary"] = "Zusammenfassung",
    ["Details"] = "Details",

    -- header and text
    ["Status as of %s"] = "Stand %s",
    ["Patch notes as of %s"] = "Patch Notes von %s",
    ["Announcement of %s"] = "Ankündigung vom %s",
    ["Key points"] = "Das Wichtigste",
    ["Written by an AI"] = "Von einer KI geschrieben",
    ["Original patch notes (Blizzard)"] = "Originale Patch Notes (Blizzard)",
    ["Short summary by an AI. The details below are what counts."] = "Kurz erklärt von einer KI. Die Details unten gelten.",
    ["The summary is outdated. Please read the details below."] = "Die Kurzfassung ist veraltet. Bitte die Details unten lesen.",
    ['Search "%s"'] = 'Suche "%s"',
    ["Filter: %s | %d hits in %d patch(es)"] = "Filter: %s | %d Treffer in %d Patch(es)",
    ["No hits."] = "Keine Treffer.",
    ["No patch notes yet."] = "Keine Patch Notes vorhanden.",
    ["Run tools\\Update-News.cmd and reload the interface (/reload)."] = "Führe tools\\Update-News.cmd aus und lade das Interface neu (/reload).",
    ["All changes in detail"] = "Alle Änderungen im Detail",
    ["No changes for this selection in this patch."] = "Keine Änderungen für diese Auswahl in diesem Patch.",
    ['%d general changes hidden - pick "All" to see them'] = '%d allgemeine Änderungen ausgeblendet - mit "Alle" siehst du sie',
    ["There is no summary for this entry."] = "Für diesen Eintrag gibt es keine Zusammenfassung.",
    ["Source: "] = "Quelle: ",
    ["General"] = "Allgemein",
    ["Planned"] = "Geplant",

    -- tooltips and chat messages
    ["%d unread patches"] = "%d ungelesene Patches",
    ["Updated: "] = "Stand: ",
    ["Movable in Edit Mode"] = "Im Edit-Modus verschiebbar",
    ["|cff4dccffForever News:|r %d unread patch notes. Open with /fnews"] = "|cff4dccffForever News:|r %d ungelesene Patch Notes. Öffnen mit /fnews",
    ["|cff4dccffForever News:|r News button is back at its default spot beneath the chat buttons."] = "|cff4dccffForever News:|r News-Button wieder an seinem Standardplatz unter den Chat-Buttons.",

    -- headings that come from Blizzard's patch notes (the text under them stays in English)
    ["Classes"] = "Klassen",
    ["Gamepad Support"] = "Gamepad-Unterstützung",
    ["Races"] = "Völker",
    ["Quests and World"] = "Quests und Welt",
    ["Changes and Updates"] = "Änderungen und Updates",
    ["Professions"] = "Berufe",
    ["Player versus Player"] = "Spieler gegen Spieler",
    ["Items"] = "Gegenstände",
    ["Bug Fixes"] = "Fehlerbehebungen",
    ["User Interface"] = "Benutzeroberfläche",
    ["User Interface and Accessibility"] = "Benutzeroberfläche und Barrierefreiheit",
    ["Enemies and NPCs"] = "Gegner und NPCs",
    ["World"] = "Welt",
    ["Legacy System"] = "Legacy-System",
    ["Undead"] = "Untote",
    ["Dwarf"] = "Zwerg",
    ["Human"] = "Mensch",
  },

}
