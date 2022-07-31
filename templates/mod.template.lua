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

local navigatorDialog = [[        <Property value="GcAlienPuzzleOption.xml">
          <Property name="Name" value="ALCH_SCAN_MENU_PQ_NAME"/>
          <Property name="Text" value=""/>
          <Property name="IsAlien" value="False"/>
          <Property name="Cost" value=""/>
          <Property name="Rewards"/>
          <Property name="Mood" value="GcAlienMood.xml">
            <Property name="Mood" value="Neutral"/>
          </Property>
          <Property name="Prop" value="GcNPCPropTypes.xml">
            <Property name="NPCProp" value="HoloSolarSystem"/>
          </Property>
          <Property name="KeepOpen" value="True"/>
          <Property name="DisplayCost" value="True"/>
          <Property name="TruncateCost" value="False"/>
          <Property name="MarkInteractionComplete" value="True"/>
          <Property name="NextInteraction" value="D_ALSCFB_HOME"/>
          <Property name="SelectedOnBackOut" value="False"/>
          <Property name="AudioEvent" value="GcAudioWwiseEvents.xml">
            <Property name="AkEvent" value="INVALID_EVENT"/>
          </Property>
          <Property name="TitleOverride" value=""/>
          <Property name="EnablingConditionTest" value="GcMissionConditionTest.xml">
            <Property name="ConditionTest" value="AnyFalse"/>
          </Property>
          <Property name="EnablingConditions"/>
          <Property name="EnablingConditionId" value=""/>
          <Property name="WordCategory" value="GcWordCategoryTableEnum.xml">
            <Property name="gcwordcategorytableEnum" value="MISC"/>
          </Property>
        </Property>]]

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
      ["SPECIAL_KEY_WORDS"] = {"Id", "FLEET_NAVIGATOR", "Name", "NPC_NAVIGATOR_OPT_B"},
      ["LINE_OFFSET"] = -2,
      ["ADD"] = navigatorDialog,
      ["REPLACE_TYPE"] = "ALL"
    },
    {
      ["SPECIAL_KEY_WORDS"] = {"Id", "FLEET_NAVIGATOR_NEW", "Name", "NPC_NAVIGATOR_OPT_B"},
      ["LINE_OFFSET"] = -2,
      ["ADD"] = navigatorDialog,
      ["REPLACE_TYPE"] = "ALL"
    },
    {
      ["SPECIAL_KEY_WORDS"] = {"Id", "FLEET_NAVIGATOR_FULL_POST", "Name", "ALL_REQUEST_LEAVE"},
      ["LINE_OFFSET"] = -2,
      ["ADD"] = navigatorDialog,
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