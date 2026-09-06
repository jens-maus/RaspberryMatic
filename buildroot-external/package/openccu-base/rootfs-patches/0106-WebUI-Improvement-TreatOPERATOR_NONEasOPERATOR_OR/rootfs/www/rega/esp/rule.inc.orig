<%
  Write( '<div id="rule'#oR.ID()#'">' );
  if( oR )
  {
    if( oR.ElseIfFlag() )
    {
      Write( '<div class="Rule j_translate">' );
        object oP = dom.GetObject( pid );
        !Write( '<div class="CLASS02300">Bedingung: ' );
        Write( '<div class="CLASS02300">${ruleCondition} ' );
        if( oP.Rule().ID() == oR.ID() )
        {
          !Write( 'Wenn...' );
          Write( '${ruleConditionIf}' );
        }
        else
        {
          !Write( '<select onchange="DeleteSubRuleSelectChange(this.selectedIndex,'#oR.RuleParentID()#');" class="SelectBox BigFont"><option>Sonst...</option><option selected>Sonst Wenn...</option></select>' );
          Write( '<select onchange="DeleteSubRuleSelectChange(this.selectedIndex,'#oR.RuleParentID()#');" class="SelectBox BigFont"><option>${ruleSelectElse}</option><option selected>${ruleSelectElseIf}</option></select>' );
        }
        Write( '</div>' );
        integer iRuleCondCount = oR.RuleConditions().Count();
        if( iRuleCondCount > 0 )
        {
          
          string sCondIndex;
          foreach( sCondIndex, system.GenerateEnum(0,(iRuleCondCount-1)) )
          {
            object oC = oR.RuleCondition(sCondIndex);
            if( oC )
            {
              Write( '<div class="Condition">' );
                integer iSingleCount = oC.CndSingleCount();
                if( iSingleCount > 0 )
                {
                  string sSingleIndex;
                  foreach( sSingleIndex, system.GenerateEnum(0,(iSingleCount-1)) )
                  {
                    object oSC = oC.CndSingleCondition(sSingleIndex);
                    if( oSC )
                    {
                      if( sSingleIndex.ToInteger() > 0 )
                      {
                        if( oSC.OperatorType() == 0 ) { Write( "<div><b>?</b></div>" ); }
                        if( oSC.OperatorType() == 1 ) { Write( "<div><b>${ruleSelectAND}</b></div>" ); }
                        if( oSC.OperatorType() == 2 ) { Write( "<div><b>${ruleSelectOR}</b></div>" ); }
                      }
                      Write( '<div>' );
                      Write( '<span id="sico'#oSC.ID()#'">' );
                      #inc("/esp/sico.inc");
                      Write( '</span>' );
                      Write( ' ' );
                      Write( '<img src="/ise/img/delete.png" class="CLASS02301" onclick="isePrograms.DeleteSingleCondition('#oR.ID()#','#oC.ID()#','#oSC.ID()#');" />' );
                      Write( '</div>' );
                      if( sSingleIndex > 1 )
                      {
                        oSC.OperatorType( oC.CndSingleCondition(0).OperatorType() );
                      }
                    }
                  }
                }
                Write( '<span><img src="/ise/img/add.png" onclick="AddSingleCondition('#oR.ID()#','#oC.ID()#');" /></span>' );
                if( iSingleCount == 1 )
                {
                  Write( '<span><select onchange="iseSingleCondition.OperatorType('#oC.ID()#','#oSC.ID()#',this.selectedIndex+1);" class="SelectBox">' );
                  string sSelected = "";
                  if( oSC.OperatorType() == 1 ) { sSelected = " selected"; } else { sSelected = ""; }
                  Write( '<option'#sSelected#'>${ruleSelectAND}</option>' );
                  if( oSC.OperatorType() == 2 ) { sSelected = " selected"; } else { sSelected = ""; }
                  Write( '<option'#sSelected#'>${ruleSelectOR}</option>' );
                  Write( '</select></span>' );
                }
                !Write( '<span><img src="/ise/img/delete.png" class="CLASS02301" onclick="isePrograms.DeleteCondition('#oR.ID()#','#oC.ID()#');" /></span>' );
              Write( "</div>" );
              if( sCondIndex.ToInteger() < (iRuleCondCount-1) )
              {
                Write( '<div class="CLASS02300">' );
                if( oC.CndOperatorType() == 0 ) { Write( '?' ); }
                if( oC.CndOperatorType() == 1 ) { Write( '${ruleSelectAND}' ); }
                if( oC.CndOperatorType() == 2 ) { Write( '${ruleSelectOR}' ); }
                Write( '</div>' );
              }
            }
          }
        }
        Write( '<div>' );
        Write( '<img src="/ise/img/add.png" onclick="isePrograms.AddCondition('#oR.ID()#');" />' );
        if( iRuleCondCount == 1 )
        {
          Write( '<span><select onchange="isePrograms.OperatorType('#oR.ID()#','#oC.ID()#',this.selectedIndex+1);" class="SelectBox">' );
          string sSelected = "";
          if( oC.CndOperatorType() == 1 ) { sSelected = " selected"; } else { sSelected = ""; }
          Write( '<option'#sSelected#'>${ruleSelectAND}</option>' );
          if( oC.CndOperatorType() == 2 ) { sSelected = " selected"; } else { sSelected = ""; }
          Write( '<option'#sSelected#'>${ruleSelectOR}</option>' );
          Write( '</select></span>' );
        }
        Write( '</div>' );
      Write( '</div>' );
    }
  }
  if( oR )
  {
    Write( '<div class="Rule">' );
      object oD = oR.RuleDestination();
      if( oD )
      {
        if( oR.ElseIfFlag() )
        {
          string sChecked = "";
          if( oD.BreakOnRestart() ) { sChecked = "checked"; }
          !Write( '<div class="CLASS02300">Aktivität: Dann...<label><input type="checkbox" '#sChecked#' onclick="isePrograms.SetBreakOnRestart('#oR.ID()#','#oD.ID()#',this.checked);" class="SelectBox">Vor dem Ausführen alle laufenden Verzögerungen für diese Aktivitäten beenden (z.B. Retriggern).</label></div>' );
          Write( '<div class="CLASS02300">${ruleActivityThen}<label><input type="checkbox" '#sChecked#' onclick="isePrograms.SetBreakOnRestart('#oR.ID()#','#oD.ID()#',this.checked);" class="SelectBox">${ruleLblStopAllDelays}</label></div>' );
        }
        else
        {
          string sChecked = "";
          if( oD.BreakOnRestart() ) { sChecked = "checked"; }
          !Write( '<div class="CLASS02300">Aktivität: <select onchange="AddSubRuleSelectChange(this.selectedIndex,'#oR.ID()#');" class="SelectBox BigFont"><option selected>Sonst...</option><option>Sonst Wenn...</option></select><label><input type="checkbox" '#sChecked#' onclick="isePrograms.SetBreakOnRestart('#oR.ID()#','#oD.ID()#',this.checked);" class="SelectBox">Vor dem Ausführen alle laufenden Verzögerungen für diese Aktivitäten beenden (z.B. Retriggern).</label></div>' );
          Write( '<div class="CLASS02300">${ruleActivity} <select onchange="AddSubRuleSelectChange(this.selectedIndex,'#oR.ID()#');" class="SelectBox BigFont"><option selected>${ruleSelectElse}</option><option>${ruleSelectElseIf}</option></select><label><input type="checkbox" '#sChecked#' onclick="isePrograms.SetBreakOnRestart('#oR.ID()#','#oD.ID()#',this.checked);" class="SelectBox">${ruleLblStopAllDelays}</label></div>' );
        }

        integer iSingleDestCount = oD.DestSingleCount();
        string sSingleDestIndex;
        foreach( sSingleDestIndex, system.GenerateEnum(0, (iSingleDestCount-1)) )
        {
          object oSD = oD.DestSingleDestination( sSingleDestIndex );
          if( oSD )
          {
            Write( '<div>' );
            Write( '<span id="side'#oSD.ID()#'">' );
            #inc("/esp/side.inc");
            Write( '</span>' );
            Write( ' <img src="/ise/img/delete.png" class="CLASS02301" onclick="isePrograms.DeleteSingleDestination('#oR.ID()#','#oD.ID()#','#oSD.ID()#');" /></div>' );
          }
        }
      }
      if( oR.ElseIfFlag() )
      {
        Write( '<span><img src="/ise/img/add.png" onclick="isePrograms.AddSingleDestination('#oR.ID()#','#oD.ID()#');" /></span>' );
      }
      else
      {
        Write( '<span><img src="/ise/img/add.png" onclick="isePrograms.AddSingleDestination('#oR.ID()#','#oD.ID()#');" /></span>' );
      }
    Write( '</div>' );
  }
  if( (!oSR) && (oR.ElseIfFlag()) )
  {
    Write( '<div class="Rule">' );
      !Write( '<div class="CLASS02300">Aktivität: <select onchange="AddSubRuleSelectChange(this.selectedIndex,'#oR.ID()#');" class="SelectBox BigFont"><option selected>Sonst...</option><option>Sonst Wenn...</option></select><label><input type="checkbox" onclick="isePrograms.AddSubRuleBreakOnRestart('#oR.ID()#',this.checked);" class="SelectBox">Vor dem Ausführen alle laufenden Verzögerungen für diese Aktivitäten beenden (z.B. Retriggern).</label></div>' );
      ! Die vorherige Zeile leserlicher dargestellt...
      Write( '<div class="CLASS02300">${ruleActivity}' );
        Write( '<select onchange="AddSubRuleSelectChange(this.selectedIndex,'#oR.ID()#');" class="SelectBox BigFont">' );
          Write( '<option selected>${ruleSelectElse}</option>' );
          Write( '<option>${ruleSelectElseIf}</option>' );
        Write( '</select>');

        Write( '<label><input type="checkbox" onclick="isePrograms.AddSubRuleBreakOnRestart('#oR.ID()#',this.checked);" class="SelectBox">${ruleLblStopAllDelays}</label>' );
      Write( '</div>' );

      Write( '<span><img src="/ise/img/add.png" onclick="isePrograms.AddSubRuleDest('#oR.ID()#');" /></span>' );
    Write( '</div>' );
  }
  Write( '</div>' );
%>

