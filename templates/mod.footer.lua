Ref = NMS_MOD_DEFINITION_CONTAINER.MODIFICATIONS[1].MBIN_CHANGE_TABLE;

local navigatorDialog = [[        <Property value="GcAlienPuzzleOption.xml">
          <Property name="Name" value="ALCH_SCAN_MENU_PQ_NAME"/>
          <Property name="Text" value=""/>
          <Property name="IsAlien" value="False"/>
          <Property name="Cost" value=""/>
          <Property name="Rewards"/>
          <Property name="Mood" value="GcAlienMood.xml">
            <Property name="Mood" value="Neutral"/>
          </Property>
          <Property name="Prop" value="GcNPCPropType.xml">
            <Property name="NPCProp" value="HoloSolarSystem"/>
          </Property>
          <Property name="OverrideWithAlienWord" value="False" />
          <Property name="ReseedInteractionOnUse" value="False" />
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
            <Property name="wordcategorytableEnum" value="MISC"/>
          </Property>
        </Property>]]

table.insert(Ref, 1, {
  MBIN_FILE_SOURCE = "METADATA/REALITY/TABLES/NMS_DIALOG_GCALIENPUZZLETABLE.MBIN",
  EXML_CHANGE_TABLE = {
    -- remove original signal scanner dialog so quest injected dialog takes over
    {
      SPECIAL_KEY_WORDS = {"Id", "SIGNALSCANNER"},
      REMOVE = "SECTION",
    },

    -- add dialog option to freighter navigator
    {
      SPECIAL_KEY_WORDS = {"Id", "FLEET_NAVIGATOR", "Name", "NPC_NAVIGATOR_OPT_B"},
      LINE_OFFSET = -2,
      ADD = navigatorDialog,
      REPLACE_TYPE = "ALL"
    },
    {
      SPECIAL_KEY_WORDS = {"Id", "FLEET_NAVIGATOR_NEW", "Name", "NPC_NAVIGATOR_OPT_B"},
      LINE_OFFSET = -2,
      ADD = navigatorDialog,
      REPLACE_TYPE = "ALL"
    },
    {
      SPECIAL_KEY_WORDS = {"Id", "FLEET_NAVIGATOR_FULL_POST", "Name", "ALL_REQUEST_LEAVE"},
      LINE_OFFSET = -2,
      ADD = navigatorDialog,
      REPLACE_TYPE = "ALL"
    },
  }
})