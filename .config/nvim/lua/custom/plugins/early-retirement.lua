local M = {
	"chrisgrieser/nvim-early-retirement",
	enabled = false, -- why do i need this honestly?
	event = "VeryLazy",
	opts = {
		retirementAgeMins = 5,
		notificationOnAutoClose = false,
	},
}

return M
