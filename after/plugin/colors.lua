function ColorMyPencils(color)
	color = color or "one-nvim"
	vim.cmd.colorscheme(color)
end

ColorMyPencils()
vim.cmd('colorscheme kanagawa')
