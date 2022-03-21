--- BEFORE USING, change language entries to fit your needs.

local lspconfig = require("lspconfig")
local function lsp_setup(name, config)
    lspconfig[name].setup(config)
end

local M = {}

local function default_dictionary_file(lang)
    return vim.fn.stdpath("config").."/spell/dictionary."..lang..".txt"
end

local function default_disabledRules_file(lang)
    return vim.fn.stdpath("config").."/spell/disabledRules."..lang..".txt"
end

local function default_falsePositives_file(lang)
    return vim.fn.stdpath("config").."/spell/falsePositives."..lang..".txt"
end

M.dictionary_file = {
    ["de-DE"] = default_dictionary_file("de-DE"),
    ["en-US"] = default_dictionary_file("en-US"),
}
M.disabledRules_file = {
    ["de-DE"] = default_disabledRules_file("de-DE"),
    ["en-US"] = default_disabledRules_file("en-US"),
}
M.falsePositives_file = {
    ["de-DE"] = default_falsePositives_file("de-DE"),
    ["en-US"] = default_falsePositives_file("en-US"),
}

local function read_file(file)
    local dict = {}
    local f = io.open(file, "r")
    if f == nil then
        return {}
    end

    for l in f:lines() do
        table.insert(dict, l)
    end
    return dict
end

-- might be helpful to automatically generating dictionaries etc.
-- local function get_ltex_lang()
--     local buf_clients = vim.lsp.buf_get_clients()
--     for _, client in ipairs(buf_clients) do
--         if client.name == "ltex" then
--             return client.config.settings.ltex.language
--         end
--     end
-- end

local function updateConfig(lang, configtype)
    local buf_clients = vim.lsp.buf_get_clients()
    local client = nil
    for _, lsp in ipairs(buf_clients) do
        if lsp.name == "ltex" then
            client = lsp
        end
    end
    if client then
        if configtype == 'dictionary' then
            if client.config.settings.ltex.dictionary then
                client.config.settings.ltex.dictionary = {
                    [lang] = read_file(M.dictionary_file[lang])
                };
                return client.notify('workspace/didChangeConfiguration', client.config.settings)
            else
                return vim.notify("Error when reading dictionary config, check it")
            end
        elseif configtype == 'disabledRules' then
            if client.config.settings.ltex.disabledRules then
                client.config.settings.ltex.disabledRules = {
                    [lang] = read_file(M.disabledRules_file[lang])
                };
                return client.notify('workspace/didChangeConfiguration', client.config.settings)
            else
                return vim.notify("Error when reading disabledRules config, check it")
            end

        elseif configtype == 'falsePositive' then
            if client.config.settings.ltex.hiddenFalsePositives then
                client.config.settings.ltex.hiddenFalsePositives = {
                    [lang] = read_file(M.falsePositives_file[lang])
                };
                return client.notify('workspace/didChangeConfiguration', client.config.settings)
            else
                return vim.notify("Error when reading hiddenFalsePositives config, check it")
            end
        end
    else
        return nil
    end
end

local function addToFile(filetype, lang, file, value)
    file = io.open(file, "a+")
    if file then
        file:write(value .. "\n")
        file:close()
    else
        return print("Failed insert %q", value)
    end
    updateConfig(lang, filetype)
end

local function addTo(filetype, lang, file, value)
    local dict = read_file(file)
    for _, v in ipairs(dict) do
        if v == value then
            return nil
        end
    end
    return addToFile(filetype, lang, file, value)
end


function M.setup(config)
    config.settings = {
        ltex = {
            dictionary = {
                ["de-DE"] = read_file(M.dictionary_file["de-DE"]),
                ["en-US"] = read_file(M.dictionary_file["en-US"]),
            },
            disabledRules = {
                ["de-DE"] = read_file(M.disabledRules_file["de-DE"]),
                ["en-US"] = read_file(M.disabledRules_file["en-US"]),
            },
            hiddenFalsePositives = {
                ["de-DE"] = read_file(M.falsePositives_file["de-DE"]),
                ["en-US"] = read_file(M.falsePositives_file["en-US"]),
            }
        }
    }

    lsp_setup("ltex", config)

    local orig_execute_command = vim.lsp.buf.execute_command
    vim.lsp.buf.execute_command = function(command)
        if command.command == '_ltex.addToDictionary' then
            local arg = command.arguments[1].words -- can I really access like this?
            for lang, words in pairs(arg) do
                for _, word in ipairs(words) do
                    local filetype = "dictionary"
                    addTo(filetype,lang, M.dictionary_file[lang], word)
                end
            end
        elseif command.command == '_ltex.disableRules' then
            local arg = command.arguments[1].ruleIds -- can I really access like this?
            for lang, rules in pairs(arg) do
                for _, rule in ipairs(rules) do
                    local filetype = "disable"
                    addTo(filetype,lang,M.disabledRules_file[lang], rule)
                end
            end

        elseif command.command == '_ltex.hideFalsePositives' then
            local arg = command.arguments[1].falsePositives -- can I really access like this?
            for lang, rules in pairs(arg) do
                for _, rule in ipairs(rules) do
                    local filetype = "falsePositive"
                    addTo(filetype,lang,M.falsePositives_file[lang], rule)
                end
            end
        else
          orig_execute_command(command)
        end
    end
end

return M
