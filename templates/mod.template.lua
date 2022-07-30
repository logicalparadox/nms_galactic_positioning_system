Author = "<%= env.Mod.Author %>"
ModName = "<%= env.Mod.Name %>"
BaseDescription = [[<%= (env.Mod.Description || '').trim() %>]]
GameVersion = "<%= `${(env.Mod.GameVersion || '')}`.replace(new RegExp('\\.', 'g'), '-') %>"
ModVersion = "<%= `${(env.Mod.Version || '')}`.replace(new RegExp('\\.', 'g'), '-') %>"

--[[
<% env.tables.forEach((file) => { %>
<%= file.filename %>
<% file.gcArray.forEach((e) => { %>- <%= e.id %>
<% }); %><% }); %>
--]]

NMS_MOD_DEFINITION_CONTAINER = {

["MOD_FILENAME"]				= Author.."_"..ModName.."_"..GameVersion.."_"..ModVersion..".pak",
["MOD_DESCRIPTION"]			= BaseDescription,
["MOD_AUTHOR"]					= Author,
["NMS_VERSION"]					= GameVersion,

["MODIFICATIONS"]	= {
{["MBIN_CHANGE_TABLE"] = {

  -- Dialog Removals
  {["MBIN_FILE_SOURCE"] = "METADATA\\REALITY\\TABLES\\NMS_DIALOG_GCALIENPUZZLETABLE.MBIN",
  ["EXML_CHANGE_TABLE"] = {
    {
      ["SPECIAL_KEY_WORDS"] = {"Id", "SIGNALSCANNER"},
      ["REMOVE"] = "SECTION",
    },
    {
      ["SPECIAL_KEY_WORDS"] = {"Id", "FLEET_NAVIGATOR"}, 
      ["REMOVE"] = "SECTION",
      ["REPLACE_TYPE"] = "ALL"
    },
    {
      ["SPECIAL_KEY_WORDS"] = {"Id", "FLEET_NAVIGATOR_NEW"}, 
      ["REMOVE"] = "SECTION",
      ["REPLACE_TYPE"] = "ALL"
    },
  }},

  -- Injected Tables<% env.tables.forEach((table) => { %>
  {["MBIN_FILE_SOURCE"] = "<%= table.MBIN_FILE_SOURCE %>",
  ["EXML_CHANGE_TABLE"] = {
    {["LINE_OFFSET"] = 0,
    --<% if (table.SPECIAL_KEY_WORDS.length) { %>
    ["SPECIAL_KEY_WORDS"] = {
      --<% table.SPECIAL_KEY_WORDS.forEach((key) => { %>
      "<%= key %>", --<% }); %>
    },--<% } %>
    --<% if (table.PRECEDING_KEY_WORDS.length) { %>
    ["PRECEDING_KEY_WORDS"] = {
      --<% table.PRECEDING_KEY_WORDS.forEach((key) => { %>
      "<%= key %>", --<% }); %>
    },--<% } %>
    ["ADD"] = [[
<%~ table.getFinalXml() %>      
]]
    },
  }},

  --<% }) %>

}}}}