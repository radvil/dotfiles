local function getconfig(name)
  return require(string.format("libs.accessibility.navigation.%s", name))
end
---@type LazySpec[]
return {
  getconfig("tmux-navigator"),
  getconfig("smart-splits"),
  getconfig("bufferline"),
  getconfig("dashboard"),
  getconfig("alpha"),
}
