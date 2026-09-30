local m = {}

local set = vim.api.nvim_set_hl

function m.h(group, spec)
	set(0, group, spec)
end

function m.link(from, to)
	set(0, from, { link = to })
end

return m
