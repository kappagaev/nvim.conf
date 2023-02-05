require("bufferline").setup {
	options = {
		enforce_regular_tabs = true,
		close_icon = '',
		hover = {
			enabled = true,
			delay = 200,
			reveal = { 'close' }
		},
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer ",
			}
		}
	},
}
