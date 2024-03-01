-- Get the content of the current line in Neovim using Lua
function get_current_line_content()
    -- Get the current buffer
    local current_buffer = vim.api.nvim_get_current_buf()
    -- Get the current window
    local current_window = vim.api.nvim_get_current_win()
    -- Get the cursor position (line and column) in the current window
    local line_number, _ = unpack(vim.api.nvim_win_get_cursor(current_window))
    -- Get the content of the current line
    local line_content = vim.api.nvim_buf_get_lines(current_buffer, line_number - 1, line_number, false)[1]
    return line_content
end

function get_content_of_line(line_number)
  -- Get the current buffer
  local current_buffer = vim.api.nvim_get_current_buf()
  -- Get the content of the specified line
  local line_content = vim.api.nvim_buf_get_lines(current_buffer, line_number - 1, line_number, false)[1]
  return line_content
end

-- Replace the content of the current line in Neovim using Lua
function replace_current_line_content(new_content)
    -- Get the current buffer
    local current_buffer = vim.api.nvim_get_current_buf()
    -- Get the current window
    local current_window = vim.api.nvim_get_current_win()
    -- Get the cursor position (line and column) in the current window
    local line_number, _ = unpack(vim.api.nvim_win_get_cursor(current_window))
    -- Replace the content of the current line with the new string
    vim.api.nvim_buf_set_lines(current_buffer, line_number - 1, line_number, false, {new_content})
end

function starts_with(input_string, substring)
    return input_string:sub(1, #substring) == substring
end

function first_char_to_lowercase(input_string)
    return input_string:sub(1, 1):lower() .. input_string:sub(2)
end

function first_char_to_uppercase(input_string)
    return input_string:sub(1, 1):upper() .. input_string:sub(2)
end

function parse_camel_case(input_string)
 local words = {}
    
  -- Match the first word separately and keep it in lowercase
  local first_word = input_string:match("%l+")
  if first_word then
      table.insert(words, first_word)
  end
  
  -- -- Match the rest of the words in the CamelCase string

  words[2] = first_char_to_lowercase(string.gsub(input_string, first_word, "", 1))

  return words
end

-- Example usage


local function find_line_with_text(text)
    -- Get the current buffer
    local current_buffer = vim.api.nvim_get_current_buf()
    -- Get the total number of lines in the buffer
    local total_lines = vim.api.nvim_buf_line_count(current_buffer)
    -- Iterate over each line in the buffer
    for line_num = 1, total_lines do
        -- Get the content of the current line
        local line_content = vim.api.nvim_buf_get_lines(current_buffer, line_num - 1, line_num, false)[1]
        if line_content and line_content:find(text) then
            return line_num, line_content
        end
    end
    return nil, nil  -- Return nil if the text is not found
end

local function line_with_text_exists(text)
    return find_line_with_text(text) ~= nil
end

function add_imports(iname)
  local line_num, line_content = find_line_with_text("queries%.types")

  if not line_content then
    return
  end

  if line_content:find(iname) then
    return
  end

  line_content = line_content:gsub("import {", "import { " .. iname .. ",")

  -- Replace the content of the current line with the new string
  vim.api.nvim_buf_set_lines(vim.api.nvim_get_current_buf(), line_num - 1, line_num, false, {line_content})
end


function insert_line_after(line_number, new_line)
    -- Get the current buffer
    local current_buffer = vim.api.nvim_get_current_buf()
    -- Insert the new line after the specified line number
    vim.api.nvim_buf_set_lines(current_buffer, line_number, line_number, false, {new_line})
end

local function add_export(fname)
  local words = parse_camel_case(fname)
  local export = words[2]:gsub("Query", "") .. ": " .. fname .. ","

  if line_with_text_exists(export) then
    return
  end

  local l, _ = find_line_with_text(words[1] .. ": {")
  insert_line_after(l, "    " .. export)
end

local function main()

  local current_line_content = get_current_line_content()

  print(current_line_content)
  if not starts_with(current_line_content, "export const ") then
    print("no export const")
    return
  end
  local fname = string.gsub(current_line_content, "export const ", ""):match("%w+")

  local iname = "I" .. first_char_to_uppercase(fname) .. "Query"

  current_line_content = current_line_content:gsub("sql`", "sql<" .. iname .. ">`")

  add_export(fname)

  replace_current_line_content(current_line_content)

  add_imports(iname)
end


vim.keymap.set("n", "s", function()
  main()
end)
