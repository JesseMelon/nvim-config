---@diagnostic disable: undefined-global
local lush = require("lush")
local hsl = lush.hsl  -- Allows using HSL color values

local theme = lush(function()
  return {
    -- Set Transparent Background
    Normal { bg = "none", fg = hsl(220, 90, 80) },  -- Light Blue Text

    -- Comments (Soft Purple)
    Comment { fg = hsl(280, 99, 80), gui = "italic" },

    -- Strings (Green)
    String { fg = hsl(150, 100, 65) },

    -- Keywords (Cyan)
    Keyword { fg = hsl(180, 100, 50) },
    KeywordFunction { fg = hsl(120, 50, 65)},
    KeywordControl {fg = hsl(330, 80, 70)},

    -- Types (Green)
    Type {fg = hsl(120, 50, 65)},
    StorageClass {fg = hsl(120, 50, 65)},
    PreProc {fg = hsl(120, 50, 65)},
    Special {fg = hsl(120, 50, 65)},
    -- Functions (Brown)
    Function { fg = hsl(20, 50, 55), gui = "bold" },

    -- Variables (White)
    Identifier { fg = hsl(0, 0, 90) },

    -- Numbers (Pink)
    Number { fg = hsl(330, 80, 70) },

    -- Background colors for UI elements
    Visual { bg = hsl(210, 60, 30) }, -- Selection color
    LineNr { fg = hsl(200, 50, 50) }, -- Line numbers
    CursorLine { bg = hsl(220, 30, 20) }, -- Highlight current line

    -- Transparency for non-code UI elements
    NormalNC { bg = "none" },
    EndOfBuffer { fg = hsl(120, 40, 40)},
    VertSplit { fg = hsl(120, 40, 40)},
    WinSeparator { fg = hsl(120, 40, 40) },

    -- NeoTree Customization
    -- NeoTreeFileName { fg = hsl(120, 70, 50) },  -- green for file names
    -- NeoTreeFileNameOpened { fg = hsl(30, 50, 40) },  -- Green for open file names
    -- NeoTreeRootName { fg = hsl(30, 50, 40) },  -- Dark Green for root folder
    -- NeoTreeDirectoryName { fg = hsl(120, 70, 50) },  -- Darker Green for directories
    -- NeoTreeDirectoryIcon { fg = hsl(120, 70, 50) },  -- Darker Green for directory icons
    -- NeoTreeStatusLine { bg = hsl(120, 40, 40) },  -- Dark background for the status line

    -- Tildas and vertical lines (Green)
    -- NeoTreeNorma l { fg = hsl(120, 40, 40) },  -- Green for normal text in NeoTree (including tildas ~)
    -- NeoTreeIndentMarker { fg = hsl(120, 50, 30) },  -- Darker green for the indent markers (|) and lines
    -- NeoTreeFileIcon { fg = hsl(120, 40, 40) },  -- Green for file icons and tildas

    NeoTreeGitIgnored { fg = hsl(280, 99, 80) },  -- Soft purple for git-ignored files

    -- Set the horizontal split line (separator) to green
    StatusLine { fg = hsl(120, 50, 40), bg = hsl(0, 0, 20) },  -- Green for the horizontal split line
    StatusLineNC { fg = hsl(120, 50, 40), bg = hsl(0, 0, 20) },  -- Green for inactive horizontal split line

    -- border of windows to green
    TelescopeBorder { fg = hsl(120, 50, 40) },  -- Green for the border

  }
end)

return theme

