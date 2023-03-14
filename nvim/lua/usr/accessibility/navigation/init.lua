local function getconfig(name)
  return require(string.format("usr.accessibility.navigation.%s", name))
end
---@type LazySpec[]
return {
  getconfig("tmux-navigator"),
  getconfig("bufferline"),
  getconfig("dashboard"),
  getconfig("alpha"),
}
