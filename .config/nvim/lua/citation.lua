
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local actions = require "telescope.actions"
local previewers = require "telescope.previewers"
local action_state = require "telescope.actions.state"

local conf = require("telescope.config").values
local entry_display = require "telescope.pickers.entry_display"

local M = {}

local function get_json()
    local f = io.open("./references.json", "r")
    if f == nil then
        return {}
    end
    return vim.fn.json_decode(f:read("*a") or {})
end


local function author_list(entry)
    local year = ""
    -- if entry["issued"] ~= nil then
    --     year = ("("..entry["issued"]["date-parts"][1][1]..")") or ""
    -- end
    if entry["author"] == nil then
        return "unknown"
    else
        if #entry["author"] == 1 then
            return entry["author"][1]["family"] or ("unknown".." "..year)
        elseif #entry["author"] == 2 then
            return entry["author"][1]["family"] .. " and " .. entry["author"][2]["family"].." "..year
        else
            return (entry["author"][1]["family"] or "unknown") .. " et al" .. " "..year

            -- full list of authors, can be pretty long so not used for now
            -- local authors
            -- for _,author in pairs(entry["author"]) do
            --     if authors == nil then
            --         authors = author["family"] or ""
            --     else
            --         authors = authors .. " " .. (author["family"] or "")
            --     end
            -- end
            -- return authors
        end
    end

end

local function clean_abstract(abstract)
    if abstract == nil then
        return "no abstract"
    else
        local cleaned_abstract = abstract:gsub("[\n\r]", " ")
        return cleaned_abstract
    end
end

local function reference_preview(self, entry, status)
    local bufnr = self.state.bufnr
    local winid = self.state.winid
    vim.api.nvim_win_set_option(winid, "wrap", true)
    vim.api.nvim_win_set_option(winid, "linebreak", true)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false,
        {
            entry.value["title"],
            "",
            clean_abstract(entry.value["abstract"]),
        })
    vim.api.nvim_buf_add_highlight(bufnr, 0, "String", 0, 0,-1)
end

local function get_zotero_uri(citation_key)
    local result = vim.fn.system(
        [[curl -s http://localhost:23119/better-bibtex/json-rpc -X POST -H "Content-Type: application/json" -H "Accept: application/json" --data-binary '{"jsonrpc": "2.0", "method": "item.attachments", "params":["@]]..citation_key..[["] }']])
    local attachments = vim.fn.json_decode(result)["result"]
    if attachments == nil then
        return nil
    end
    for _,v in pairs(attachments) do
        if v["path"]:sub(-3)=="pdf" then
            return v["open"]
        end
    end
    return nil
end


local function create_citation(citation_key)
    local zotero_uri = get_zotero_uri(citation_key)
    if zotero_uri == nil then
        return "[@"..citation_key.."]"
    else
        return "[@"..citation_key.."]("..zotero_uri..")"
    end
end

-- our picker function: colors
M.telescope_cite = function(opts)
    opts = opts or {}

    local displayer = entry_display.create {
        separator = " ",
        items = {
            { width = 20 },
            { width = 5 },
            { remaining = true },
        },
    }

    local make_display = function(entry)
        local year = ""
        if entry.value["issued"] ~= nil then
            year = entry.value["issued"]["date-parts"][1][1]
        end
        return displayer {
            author_list(entry.value),
            year,
            entry.value["title"],
        }
    end

    pickers.new(
        opts,
        {
            prompt_title = "References",
            finder = finders.new_table {
                results = get_json(),
                entry_maker = function(entry)
                    return {
                      value = entry,
                      display = make_display,
                      ordinal = author_list(entry) .. " " .. entry["title"], --.. clean_abstract(entry["abstract"]),
                    }
                end
            },
            sorter = conf.generic_sorter(opts),
            previewer =  previewers.new_buffer_previewer({
                define_preview = reference_preview,
            }),
            attach_mappings = function(prompt_bufnr, map)
                    actions.select_default:replace(
                        function()
                            actions.close(prompt_bufnr)
                            local selection = action_state.get_selected_entry()
                            if selection == nil then
                                return
                            end
                            vim.api.nvim_put({ create_citation(selection.value["citation-key"]) }, "", false, true)
                        end
                    )
                return true
            end,
        }):find()
end

return M













