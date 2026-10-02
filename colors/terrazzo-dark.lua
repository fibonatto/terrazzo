vim.cmd("hi clear")

if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end

vim.g.colors_name = "terrazzo-dark"

require("terrazzo.highlights").apply(require("terrazzo.palette").dark)
