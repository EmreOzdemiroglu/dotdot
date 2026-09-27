local M = {}

M.path = vim.fn.stdpath("config") .. "/cheatsheet.md"

-- En son açık kalan sekme, tekrar açınca oradan devam eder
local current = 1

-- cheatsheet.md'yi "## " başlıklarına göre sekmelere böl
local function parse()
  local tabs = {}
  for _, line in ipairs(vim.fn.readfile(M.path)) do
    local name = line:match("^## (.+)")
    if name then
      table.insert(tabs, { name = name, lines = { line } })
    elseif #tabs > 0 then
      table.insert(tabs[#tabs].lines, line)
    end
  end
  return tabs
end

-- Sığmazsa sadece aktif sekmenin adını, o da sığmazsa sadece numaraları göster
local function title(tabs, width)
  local function build(label)
    local chunks, len = { { " ", "FloatBorder" } }, 1
    for i, tab in ipairs(tabs) do
      local text = " " .. label(i, tab) .. " "
      local hl = i == current and "TabLineSel" or "TabLine"
      table.insert(chunks, { text, hl })
      table.insert(chunks, { " ", "FloatBorder" })
      len = len + vim.fn.strdisplaywidth(text) + 1
    end
    return chunks, len
  end

  local modes = {
    function(i, tab) return i .. " " .. tab.name end,
    function(i, tab) return i == current and (i .. " " .. tab.name) or tostring(i) end,
    function(i) return tostring(i) end,
  }
  local chunks
  for _, label in ipairs(modes) do
    local len
    chunks, len = build(label)
    if len <= width - 2 then break end
  end
  return chunks
end

function M.open()
  local tabs = parse()
  if #tabs == 0 then
    vim.notify("cheatsheet.md içinde '## ' başlığı yok", vim.log.levels.WARN)
    return
  end
  current = math.min(current, #tabs)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"

  local width = math.min(80, vim.o.columns - 4)
  local height = math.floor(vim.o.lines * 0.85)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
    title = title(tabs, width),
    title_pos = "center",
    footer = width >= 62 and " Tab/S-Tab sekme · 1-0 atla · q kapat · Space c e düzenle "
      or " Tab ⇄ · q kapat ",
    footer_pos = "center",
  })
  vim.wo[win].conceallevel = 2
  vim.wo[win].cursorline = true
  -- Pencere açıldıktan sonra ayarla ki render-markdown bu pencereye bağlansın
  vim.bo[buf].filetype = "markdown"

  local function show(i)
    current = (i - 1) % #tabs + 1
    vim.bo[buf].modifiable = true
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, tabs[current].lines)
    vim.bo[buf].modifiable = false
    vim.api.nvim_win_set_cursor(win, { 1, 0 })
    vim.api.nvim_win_set_config(win, { title = title(tabs, width), title_pos = "center" })
  end

  local function map(key, fn)
    vim.keymap.set("n", key, fn, { buffer = buf, nowait = true })
  end
  map("<Tab>", function() show(current + 1) end)
  map("<S-Tab>", function() show(current - 1) end)
  for i = 1, math.min(#tabs, 10) do
    map(tostring(i % 10), function() show(i) end)
  end
  map("q", "<cmd>close<cr>")
  map("<Esc>", "<cmd>close<cr>")

  show(current)
end

return M
