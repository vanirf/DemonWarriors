EnableExplicit
XIncludeFile "e:\old\lc\lua.pbi"
Global jfw.l, we.l
Prototype.l proto_nvdaController_speakText(text.p-unicode)
Prototype.l proto_nvdaController_testIfRunning()
Global nvdaController_speakText.proto_nvdaController_speakText
Global nvdaController_testIfRunning.proto_nvdaController_testIfRunning
Procedure.l nvda_running()
  If nvdaController_testIfRunning() = 0
    ProcedureReturn 1
  Else
    ProcedureReturn 0
  EndIf
  ProcedureReturn 1
EndProcedure

DeclareCDLL.l nvda_say(*l)
Structure luaL_reg
name.l
*func.l
EndStructure
Declare jfwRunning()
Declare we_running()

Procedure nvda_stop()
  If nvda_running()
  CallFunction(0, "nvdaController_cancelSpeech")
ElseIf jfw > 0 And jfwRunning()
  dhCallMethod(jfw, "SayString(%s,%i)", @"", 1)
ElseIf we > 0 And we_running()
  dhCallMethod(we, "silence")
EndIf

  ProcedureReturn 1
EndProcedure
Procedure jfwRunning()
  If FindWindow_("JFWUI2", "JAWS")
    ProcedureReturn 1
  Else
    ProcedureReturn 0
      EndIf
    ProcedureReturn 1
  EndProcedure
  ProcedureCDLL we_running()
  If FindWindow_("GWMExternalControl", "External Control")
    ProcedureReturn 1
  Else
    ProcedureReturn 0
      EndIf
    ProcedureReturn 1
  EndProcedure

  Global Dim table.luaL_reg(2)
ProcedureDLL AttachProcess(instance)
table(0)\name = @"say"
table(0)\func = @nvda_say()
table(1)\name=@"stop"
table(1)\func=@nvda_stop()
OpenLibrary(0, "nvdaControllerClient32.dll")
nvdaController_speakText = GetFunction(0, "nvdaController_speakText")
nvdaController_testIfRunning = GetFunction(0, "nvdaController_testIfRunning")
EndProcedure
ProcedureCDLL luaopen_audio(*l)
  jfw = dhCreateObject("freedomsci.jawsapi")
  If jfw = 0
    jfw = dhCreateObject("jfwapi")
  EndIf
  we = dhCreateObject("gwspeak.speak")
    luaL_register(*l, "nvda", @table(0))
ProcedureReturn 1
EndProcedure
ProcedureCDLL.l  nvda_say(*l)
Protected *string = luaL_checkstring(*l, 1)
Protected st.s = PeekS(*string)
If nvda_running()
nvdaController_speakText(st)
ElseIf jfw > 0 And jfwRunning()
  dhCallMethod(jfw, "SayString(%s, %i)", *string, 0)
ElseIf we > 0 And we_Running()
  dhCallMethod(we, "SpeakString(%s)", *string)
EndIf
ProcedureReturn 1
EndProcedure

; IDE Options = PureBasic 4.51 (Windows - x86)
; ExecutableFormat = Shared Dll
; CursorPosition = 1
; Folding = --
; EnableThread
; Executable = mushReader.dll