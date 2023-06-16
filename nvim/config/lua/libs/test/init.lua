---@type LazySpec[]
if not rnv.opt.dev then
  return {}
end


---@type LazySpec[]
return {
  require("libs.test.hackertype"),
}
