local U = require("terrazzo.util")

local M = {}

function M.apply(p)
	local bg_alt = p.bg_alt or p.ui
	local bg_soft = p.bg_soft or p.cursorline
	local border = p.border or p.ui
	local fg_soft = p.fg_soft or p.comment
	local err = p.error or p.variable

	local constant = p.constant or p.number
	local typ = p.type or p.number
	local property = p.property or p.func
	local parameter = p.parameter or p.variable
	local builtin = p.builtin or p.func
	local macro = p.macro or p.keyword

	vim.g.terminal_color_0 = p.bg
	vim.g.terminal_color_1 = err
	vim.g.terminal_color_2 = p.string
	vim.g.terminal_color_3 = p.number
	vim.g.terminal_color_4 = p.func
	vim.g.terminal_color_5 = p.keyword
	vim.g.terminal_color_6 = p.property or p.variable
	vim.g.terminal_color_7 = p.fg
	vim.g.terminal_color_8 = fg_soft
	vim.g.terminal_color_9 = err
	vim.g.terminal_color_10 = p.string
	vim.g.terminal_color_11 = p.type or p.number
	vim.g.terminal_color_12 = p.builtin or p.func
	vim.g.terminal_color_13 = p.macro or p.keyword
	vim.g.terminal_color_14 = p.property or p.variable
	vim.g.terminal_color_15 = p.fg

	U.h("Normal", { fg = p.fg, bg = p.bg })
	U.h("NormalNC", { fg = p.fg, bg = p.bg })
	U.h("Cursor", { fg = p.bg, bg = p.fg })
	U.h("CursorLine", { bg = p.cursorline })
	U.h("ColorColumn", { bg = bg_soft })
	U.h("LineNr", { fg = p.gutter })
	U.h("Visual", { bg = p.visual })
	U.h("Search", { fg = p.fg, bg = p.search })
	U.h("IncSearch", { fg = p.bg, bg = p.number, bold = true })
	U.h("MatchParen", { fg = p.bg, bg = p.func, bold = true })
	U.h("Underlined", { fg = p.func, underline = true })

	U.h("ErrorMsg", { fg = err, bg = p.bg })
	U.h("WarningMsg", { fg = p.number, bg = p.bg })
	U.h("Todo", { fg = p.keyword, bg = p.bg, bold = true, italic = true })
	U.h("VertSplit", { fg = border, bg = p.bg })
	U.h("StatusLine", { fg = p.fg, bg = bg_alt })
	U.h("StatusLineNC", { fg = fg_soft, bg = bg_alt })
	U.h("NormalFloat", { fg = p.fg, bg = bg_alt })
	U.h("FloatBorder", { fg = border, bg = bg_alt })
	U.h("FloatTitle", { fg = p.func, bg = bg_alt })
	U.h("Pmenu", { fg = p.fg, bg = bg_alt })
	U.h("PmenuSel", { fg = p.bg, bg = p.func })

	U.h("SpellBad", { sp = err, undercurl = true })
	U.h("SpellCap", { sp = p.func, undercurl = true })
	U.h("SpellLocal", { sp = p.number, undercurl = true })
	U.h("SpellRare", { sp = p.keyword, undercurl = true })

	U.h("Comment", { fg = p.comment, italic = true })
	U.h("String", { fg = p.string })
	U.h("SpecialChar", { fg = property })
	U.h("Number", { fg = p.number })
	U.h("Constant", { fg = constant })
	U.h("Boolean", { fg = constant })

	U.h("Identifier", { fg = p.variable })
	U.h("Property", { fg = property })
	U.h("Parameter", { fg = parameter })
	U.h("Function", { fg = p.func, bold = true })
	U.h("Builtin", { fg = builtin })

	U.h("Statement", { fg = p.keyword })
	U.h("Keyword", { fg = p.keyword, bold = true })
	U.h("Type", { fg = typ })

	U.h("PreProc", { fg = macro })
	U.h("Macro", { fg = macro })

	U.h("Special", { fg = p.builtin or p.variable })
	U.h("Operator", { fg = p.fg })
	U.h("Delimiter", { fg = fg_soft })
	U.h("Error", { fg = err, bold = true })

	local diagnostics = {
		Error = err,
		Warn = p.number,
		Info = p.func,
		Hint = p.property or p.comment,
		Ok = p.string,
	}

	for sev, color in pairs(diagnostics) do
		U.h("Diagnostic" .. sev, { fg = color })
		U.h("DiagnosticSign" .. sev, { fg = color, bg = p.bg })
		U.h("DiagnosticVirtualText" .. sev, { fg = color, bg = bg_soft })
		U.h("DiagnosticFloating" .. sev, { fg = color, bg = bg_alt })
		U.h("DiagnosticUnderline" .. sev, {
			sp = color,
			undercurl = true,
		})
	end

	U.h("DiffAdd", { fg = p.string, bg = p.diff_add })
	U.h("DiffChange", { fg = p.number, bg = p.diff_change })
	U.h("DiffDelete", { fg = err, bg = p.diff_delete })
	U.h("DiffText", {
		fg = p.fg,
		bg = p.diff_change,
		bold = true,
	})

	local links = {
		CursorColumn = "CursorLine",
		CursorLineNr = "Function",
		SignColumn = "LineNr",
		FoldColumn = "LineNr",
		WinSeparator = "VertSplit",
		CurSearch = "IncSearch",
		VisualNOS = "Visual",
		MoreMsg = "String",
		Question = "Function",
		PmenuSbar = "ColorColumn",
		PmenuThumb = "Comment",
		TabLine = "StatusLineNC",
		TabLineFill = "StatusLineNC",
		TabLineSel = "StatusLine",
		WildMenu = "PmenuSel",
		DiagnosticUnnecessary = "Comment",

		Character = "String",
		Float = "Number",

		Conditional = "Keyword",
		Repeat = "Keyword",
		Exception = "Keyword",
		Label = "Statement",

		Include = "Keyword",
		Define = "PreProc",
		PreCondit = "PreProc",

		StorageClass = "Keyword",
		Structure = "Keyword",
		Typedef = "Type",

		Tag = "Identifier",
		SpecialComment = "Comment",
		Debug = "Special",

		diffAdded = "DiffAdd",
		diffRemoved = "DiffDelete",
		diffChanged = "DiffChange",
		diffFile = "Comment",
		diffLine = "Function",

		["@comment"] = "Comment",

		["@string"] = "String",
		["@string.escape"] = "SpecialChar",
		["@string.regexp"] = "SpecialChar",
		["@character"] = "String",
		["@character.special"] = "SpecialChar",

		["@number"] = "Number",
		["@number.float"] = "Number",
		["@boolean"] = "Boolean",

		["@keyword"] = "Keyword",
		["@keyword.function"] = "Keyword",
		["@keyword.return"] = "Keyword",
		["@keyword.operator"] = "Keyword",
		["@keyword.modifier"] = "Keyword",
		["@keyword.import"] = "Keyword",
		["@keyword.conditional"] = "Keyword",
		["@keyword.repeat"] = "Keyword",
		["@keyword.exception"] = "Keyword",
		["@keyword.directive"] = "PreProc",
		["@keyword.directive.define"] = "PreProc",

		["@variable"] = "Identifier",
		["@variable.builtin"] = "Builtin",
		["@variable.parameter"] = "Parameter",
		["@variable.member"] = "Property",
		["@property"] = "Property",

		["@function"] = "Function",
		["@function.call"] = "Function",
		["@function.method"] = "Function",
		["@function.method.call"] = "Function",
		["@function.builtin"] = "Builtin",
		["@function.macro"] = "Macro",

		["@type"] = "Type",
		["@type.builtin"] = "Type",
		["@type.definition"] = "Type",
		["@constructor"] = "Type",
		["@module"] = "Type",
		["@module.builtin"] = "Builtin",
		["@attribute"] = "Macro",

		["@constant"] = "Constant",
		["@constant.builtin"] = "Constant",
		["@constant.macro"] = "Macro",

		["@operator"] = "Operator",
		["@punctuation.delimiter"] = "Delimiter",
		["@punctuation.bracket"] = "Delimiter",
		["@punctuation.special"] = "Special",

		["@tag"] = "Identifier",
		["@tag.attribute"] = "Property",
		["@tag.delimiter"] = "Delimiter",
		["@label"] = "Label",

		["@markup.raw"] = "String",
		["@markup.link"] = "Function",
		["@markup.link.label"] = "Function",
		["@markup.link.url"] = "Constant",

		["@lsp.type.parameter"] = "Parameter",
		["@lsp.type.property"] = "Property",
		["@lsp.type.enumMember"] = "Constant",

		["@lsp.type.function"] = "Function",
		["@lsp.type.method"] = "Function",
		["@lsp.type.macro"] = "Macro",
		["@lsp.type.decorator"] = "Macro",

		["@lsp.type.type"] = "Type",
		["@lsp.type.class"] = "Type",
		["@lsp.type.struct"] = "Type",
		["@lsp.type.enum"] = "Type",
		["@lsp.type.interface"] = "Type",
		["@lsp.type.typeParameter"] = "Type",
		["@lsp.type.namespace"] = "@module",

		["@lsp.type.operator"] = "Operator",

		["@lsp.typemod.variable.defaultLibrary"] = "Builtin",
		["@lsp.typemod.function.defaultLibrary"] = "Builtin",
		["@lsp.typemod.method.defaultLibrary"] = "Builtin",

		TSComment = "Comment",
		TSFunction = "Function",
		TSKeyword = "Keyword",
		TSString = "String",
		TSNumber = "Number",
		TSVariable = "Identifier",
		TSProperty = "Property",
		TSType = "Type",
		TSOperator = "Operator",

		TelescopeBorder = "FloatBorder",
		TelescopePromptBorder = "Function",
		TelescopeResultsBorder = "FloatBorder",
		TelescopePreviewBorder = "FloatBorder",
		TelescopeMatching = "Function",
		TelescopePromptPrefix = "Special",

		NERDTreeFile = "Normal",
		NERDTreeExecFile = "String",
		NERDTreeDir = "Function",
		NERDTreeDirSlash = "Function",
		NERDTreeCWD = "Keyword",
		NERDTreeOpenable = "String",
		NERDTreeClosable = "Identifier",
		NERDTreeUp = "Comment",

		GitGutterAdd = "DiffAdd",
		GitGutterChange = "DiffChange",
		GitGutterDelete = "DiffDelete",
		GitGutterChangeDelete = "DiffChange",

		ALEError = "DiagnosticError",
		ALEWarning = "DiagnosticWarn",
		ALEErrorSign = "DiagnosticSignError",
		ALEWarningSign = "DiagnosticSignWarn",

		CocErrorSign = "DiagnosticSignError",
		CocWarningSign = "DiagnosticSignWarn",
		CocInfoSign = "DiagnosticSignInfo",
		CocHintSign = "DiagnosticSignHint",

		LspErrorText = "DiagnosticError",
		LspWarningText = "DiagnosticWarn",
		LspInformationText = "DiagnosticInfo",
		LspHintText = "DiagnosticHint",
		LspReferenceHighlight = "CursorLine",
		LspHover = "NormalFloat",

		htmlTag = "Identifier",
		htmlEndTag = "Identifier",
		htmlTagName = "Identifier",

		cssProp = "Normal",
		cssIdentifier = "Function",
		cssClassName = "Constant",

		javaScriptFunction = "Keyword",
		javaScriptMember = "Identifier",

		pythonOperator = "Keyword",

		rubySymbol = "String",

		phpMemberSelector = "Normal",

		markdownCode = "String",
		markdownH1 = "Identifier",
		markdownH2 = "Identifier",
		markdownLinkText = "Function",
		markdownUrl = "Constant",
	}

	for k, v in pairs(links) do
		U.h(k, { link = v })
	end

	U.h("@markup.heading", {
		fg = p.variable,
		bold = true,
	})

	U.h("@markup.italic", {
		italic = true,
	})

	U.h("@markup.strong", {
		bold = true,
	})

	U.h("MiniIndentscopeSymbol", {
		fg = border,
	})
end

return M
