jQuery.extend(true, langJSON, {
  "en": {

    "stringTableDoorLockStateTransceiverMsgPosA" : "Message if unlocked",
    "stringTableDoorLockStateTransceiverMsgPosB" : "Message if locked",
    "stringTableDoorLockStateTransmitterActivityStateStable" : "Status stable",

    "modeBatNotSupported" : "(not supported because battery operation)",

    "helpPrgPermanentFullRX" :
      "These functions can only performed when 'Mains operation' is selected as the power supply. 'Battery operation' is currently set.<br/></br>" +
      "If you require this functionality, then switch the 'Power supply' parameter under Device settings (channel 0) to 'Mains operation'.",

    "stringTableServoPowerOff" : "Servo switch-on time",

    "stringTableServoLevel" : "Servo position",
    "lblRestartNeeded" : "Restart required",

    "stringTableServoActivityStateUnknown" : "Servo activity unknown",
    "stringTableDeviceSensorSensibility" : "Sensor sensitivity",

    "comment" : "Translated by the software department",

    "stringTableServoRamp" : "Speed/driving time",

    "lblRotationSwap" : "Change direction of rotation",

    "optionNormallyClose" : "NC (normally closed)",
    "optionNormallyOpen" : "NO (normally open)",

    "stringTableBlockingOnSabotage" : "Lock in case of sabotage",
    "stringTableSabotageContactType" : "Type of sabotage contact",

    "stringTableBlockingPermanent" : "Number of further faulty entries for complete locking "+
      "after temporary input lock",
    "stringTableBlockingTemporary" : "Number of faulty entries for temporary locking",

    "helpServoRampTime" :
      "With value 0, the driving time is only dependent on the positioning time of the servo.<br/><br/>" +
      "The speed/driving time only affects the driving time if it is greater than the driving time caused by the positioning time of the servo.",

    "stringTableAbortEventSendingChannelsAccessTransceiver" : "Faster reaction by cancelling all transmissions of the following channels",
    "lblStopRunningLinkAccessTransceiver" : "Cancel old transmissions<br/>of these channels",

    "stringTableBlockedPermanently" : "Permanently locked",
    "stringTableBlockedTemporarily" : "Temporarily locked",

    "codeInUse" : "Codes used",

    "codeIdle" : "--",
    "codeKnownCodeIDReceived" : "Code ID received",
    "codeUnKnownCodeIDReceived" : "Unknown",
    "codeLearnModeForCodeIDStarted" : "Code is being taught in",
    "codeLearnModeExitForCodeWithSuccess" : "Code successfully taught in",
    "codeLearnModeExitForCodeWithTimeout" : "Timeout during code teach-in",
    "codeLearnModeExitForCodeWithErrorDuplicateCode" : "Code already exists",
    "codeCodeErased" : "Code deleted",

    "codeManagement" : "Code<br/>management",
    "clearStatusMessages" : "Reset<br/>locks",

    "lblCodeReceived" : "Received code",

    "lblFWISetCodeCommand" : "Action",
    "lblFWIClearError" : "Reset lock",

    "codeStartOfLearn" : "Teach in code",
    "codeStopOfLearn" : "End teach-in",
    "codeErase" : "Delete code",

    "clearAll" : "All",

    "hintFWITargetNotPossible" :
      "\n\nChannels 1 - 8 do not support the astro function.\n\n" +
      "Use the condition  \"Fixed time of day\"\n\n",

    "dialogCodeCommandTitle" : "Code Management",
    "dialogClearErrorTitle" : "Reset locks",

    "channelRights" : "Channel authorisation",

    "stringTableAccessTransceiverTitle" : "Access authorisation",
    "stringTableAccessTransceiverStateFalse" : "Channel authorised: No",
    "stringTableAccessTransceiverStateTrue" : "Channel authorised: Yes",
    "stringTableAccessTransceiverAccessAuthorizationTrue" : "Authorisation granted",
    "stringTableAccessTransceiverAccessAuthorizationFalse" : "Authorisation not granted",

    "stringTableBlockedPermanentFalse" : "Input permanently locked: No",
    "stringTableBlockedPermanentTrue" : "Input permanently locked: Yes",
    "stringTableBlockedTemporaryFalse" : "Input temporarily locked: No",
    "stringTableBlockedTemporaryTrue" : "Input temporarily locked: Yes",
    "stringTableAccessTransCodeID" : "Code ID",
    "stringTableAccessTransCodeStateCodeErased" : "Code deleted",
    "stringTableAccessTransCodeStateIdle" : "Idle state",
    "stringTableAccessTransCodeStateKnownCodeIDReceived" : "Code ID received"
    ,
    "stringTableAccessTransCodeStateLearnModeLearnModeExitWithErrorDuplicateCode" : "Error during teach-in: code exists",
    "stringTableAccessTransCodeStateLearnModeLearnModeExitWithSuccess" : "Code successfully taught in",
    "stringTableAccessTransCodeStateLearnModeLearnModeExitWithTimeout" : "Error during code teach-in: Timeout",
    "stringTableAccessTransCodeStateLearnModeForCodeIDStarted" : "Teach-in process started",
    "stringTableAccessTransCodeStateUnknownCodeDetected" : "Code unknown",

    "stringTableAccessTransCodeSCodeUsed01False" : "Code 1 not active",
    "stringTableAccessTransCodeSCodeUsed01True" : "Code 1 active",
    "stringTableAccessTransCodeSCodeUsed02False" : "Code 2 not active",
    "stringTableAccessTransCodeSCodeUsed02True" : "Code 2 active",
    "stringTableAccessTransCodeSCodeUsed03False" : "Code 3 not active",
    "stringTableAccessTransCodeSCodeUsed03True" : "Code 3 active",
    "stringTableAccessTransCodeSCodeUsed04False" : "Code 4 not active",
    "stringTableAccessTransCodeSCodeUsed04True" : "Code 4 active",
    "stringTableAccessTransCodeSCodeUsed05False" : "Code 5 not active",
    "stringTableAccessTransCodeSCodeUsed05True" : "Code 5 active",
    "stringTableAccessTransCodeSCodeUsed06False" : "Code 6 not active",
    "stringTableAccessTransCodeSCodeUsed06True" : "Code 6 active",
    "stringTableAccessTransCodeSCodeUsed07False" : "Code 7 not active",
    "stringTableAccessTransCodeSCodeUsed07True" : "Code 7 active",
    "stringTableAccessTransCodeSCodeUsed08False" : "Code 8 not active",
    "stringTableAccessTransCodeSCodeUsed08True" : "Code 8 active",
    "stringTableAccessTransCodeSCodeUsed09False" : "Code 9 not active",
    "stringTableAccessTransCodeSCodeUsed09True" : "Code 9 active",
    "stringTableAccessTransCodeSCodeUsed10False" : "Code 10 not active",
    "stringTableAccessTransCodeSCodeUsed10True" : "Code 10 active",
    "stringTableAccessTransCodeSCodeUsed11False" : "Code 11 not active",
    "stringTableAccessTransCodeSCodeUsed11True" : "Code 11 active",
    "stringTableAccessTransCodeSCodeUsed12False" : "Code 12 not active",
    "stringTableAccessTransCodeSCodeUsed12True" : "Code 12 active",
    "stringTableAccessTransCodeSCodeUsed13False" : "Code 13 not active",
    "stringTableAccessTransCodeSCodeUsed13True" : "Code 13 active",
    "stringTableAccessTransCodeSCodeUsed14False" : "Code 14 not active",
    "stringTableAccessTransCodeSCodeUsed14True" : "Code 14 active",
    "stringTableAccessTransCodeSCodeUsed15False" : "Code 15 not active",
    "stringTableAccessTransCodeSCodeUsed15True" : "Code 15 active",
    "stringTableAccessTransCodeSCodeUsed16False" : "Code 16 not active",
    "stringTableAccessTransCodeSCodeUsed16True" : "Code 16 active",
    "stringTableAccessTransCodeSCodeUsed17False" : "Code 17 not active",
    "stringTableAccessTransCodeSCodeUsed17True" : "Code 17 active",
    "stringTableAccessTransCodeSCodeUsed18False" : "Code 18 not active",
    "stringTableAccessTransCodeSCodeUsed18True" : "Code 108active",
    "stringTableAccessTransCodeSCodeUsed19False" : "Code 19 not active",
    "stringTableAccessTransCodeSCodeUsed19True" : "Code 19 active",
    "stringTableAccessTransCodeSCodeUsed20False" : "Code 20 not active",
    "stringTableAccessTransCodeSCodeUsed20True" : "Code 20 active",

    "stringTableSabotageSticky" : "Sabotage attempt",
    "stringTableSabotageStickyFalse" : "Sabotage attempt: No",
    "stringTableSabotageStickyTrue" : "Sabotage attempt: Yes",
    "stringTableClearErrorAll" : "Clear error: All",

    "stringTableClearErrorBlockedPermanent" : "Clear error: permanently locked",
    "stringTableClearErrorBlockedTemporary" : "Clear Error: temporarily locked",
    "stringTableClearErrorSabotage" : "Clear Error: Sabotage",
    "stringTableClearErrorSabotageSticky" : "Clear Error: Sabotage attempt",
    "stringTableCodeCommandErase" : "Delete code",
    "stringTableCodeCommandStartOfLearn" : "Start teach-in process for code",
    "stringTableCodeCommandStopOfLearn" : "Cancel teach-in process",

    "stringTableDisableDoorLockAcousticChannelState" : "Deactivate acoustic feedback",
    "hintDoorLockHoldTime" : "Please note that a longer holding time has a negative effect on the battery life of the door lock drive.",

    "stringTableDoorLockHoldTime" : "Holding time when opening",

    "stringTableErrorJammed" : "Locking mechanism blocked",

    "optionOpenOnly" : "Open only",
    "optionNormal" : "Normal",
    "optionLong" : "Long",
    "optionExtraLong" : "Extra long",

    "stringTableBurstLimit" : "Burst-limit",
    "stringTableBurstLimitFalse" : "Burst-limit not reached",
    "stringTableBurstLimitTrue" : "Burst-limit reached",

    "stringTableNumericPinCode" : "PIN code",

    "dialogAskCreateBakupCheckboxText" : "Create system backup before update.",
    "dialogAskCreateBakupText" : "The backup is created and downloaded directly before the installation. This process may take a few minutes",

    "unitNumericPinCode" : "(max. 8 digits from 0 to 9)",

    "stringTableUserAuthorization01false" : "User 1 authorised: No",
    "stringTableUserAuthorization01true" : "User 1 authorised: Yes",
    "stringTableUserAuthorization02false" : "User 2 authorised: No",
    "stringTableUserAuthorization02true" : "User 2 authorised: Yes",
    "stringTableUserAuthorization03false" : "User 3 authorised: No",
    "stringTableUserAuthorization03true" : "User 3 authorised: Yes",
    "stringTableUserAuthorization04false" : "User 4 authorised: No",
    "stringTableUserAuthorization04true" : "User 4 authorised: Yes",
    "stringTableUserAuthorization05false" : "User 5 authorised: No",
    "stringTableUserAuthorization05true" : "User 5 authorised: Yes",
    "stringTableUserAuthorization06false" : "User 6 authorised: No",
    "stringTableUserAuthorization06true" : "User 6 authorised: Yes",
    "stringTableUserAuthorization07false" : "User 7 authorised: No",
    "stringTableUserAuthorization07true" : "User 7 authorised: Yes",
    "stringTableUserAuthorization08false" : "User 8 authorised: No",
    "stringTableUserAuthorization08true" : "User 8 authorised: Yes",

    "lblPinOfChannelLockA" : "The PIN code of the channel 'User",
    "lblPinOfChannelLockB" : "Lock' is used.",

    "stringTableKeyPressLongRelease" : "Stop long key press",
    "stringTableKeyPressLongStart" : "Start long key press",

    "lblChannelActivInactivWhenNoOutput" : "Device inactive or in standby<br/>at 0% output voltage",
    "optionRelayInactive" : "Device not active",
    "optionRelayOffDelay05S" : "Standby after 0.5 s.",
    "optionRelayOffDelay1S" : "Standby after 1s s.",
    "optionRelayOffDelay10S" : "Standby after 10 s.",

    "optionModeConsumption" : "Consumption mode",
    "optionModeFeeding" : "Feeding mode",

    "comment" : "This has yet to be translated",
    "hintSetReadyNotComplete" : "Click on 'Done' to complete the channel configuration then access the device in the device list.",

    "lblCode" : "Code",
    "lblBellButton" : "Bell button",

    "stringTableServoTitle" : "Servo Control",

    "noMoreKeys" : ""
  }
});
