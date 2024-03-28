local plugin = require 'todo-comments'

plugin.setup {
  signs = false,
  keywords = {
    -- BUG:
    FIX  = { icon = "B", alt = { "BUG" } },
    -- TODO:
    TODO = { icon = "T" },
    -- HACK:
    HACK = { icon = "H" },
    -- WARN:
    WARN = { icon = "W" },
    -- PERF:
    PERF = { icon = "P" },
    -- INFO:
    NOTE = { icon = "I", alt = { "INFO" } },
    -- TEST:
    TEST = { icon = "T" },
  },
}
