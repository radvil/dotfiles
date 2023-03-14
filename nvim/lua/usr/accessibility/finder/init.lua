local function getconfig(name)
  return require(string.format("usr.accessibility.finder.%s", name))
end
return {
  getconfig("todo-comments"),
  getconfig("git-conflict"),
  getconfig("telescope"),
  getconfig("which-key"),
  getconfig("gitsigns"),
  getconfig("trouble"),
  getconfig("spectre"),
  getconfig("undodir"),
  getconfig("harpoon"),
  getconfig("leap"),
  getconfig("hop"),
}
