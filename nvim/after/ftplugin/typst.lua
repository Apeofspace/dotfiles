-- if the plugin is installed then start it
local ok, typst_prev = pcall(require, "typst-preview")
if ok then
  typst_prev.start()
end
