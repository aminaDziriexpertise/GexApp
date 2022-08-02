from asyncio.windows_events import NULL
import win32com.client
import ezdxf
import os
from pyzwcad import ZwCAD, APoint


def sdp():
  acad = ZwCAD()
  launchSdpCounter = 1
  #_______________Déclarer les variables sys dont osmode et HPISLANDDETECTIONMODE
  folder = r'C:\Users\adziri\Desktop\GexApp\charte_graphique\M20-002392_E0_SDP_SHO_Test.dwg'
  dwg_path = os.path.join(folder)
  dwg = acad.ActiveDocument.Open(dwg_path)
  if  (launchSdpCounter == 1)  :
       launchSdpCounter = launchSdpCounter+1
       liste = 'getLayersdp "GEX_EDS_sdp_1-"'
       if(dwg.SendCommand('(tblsearch "layer" "GEX_EDS_sdp_2-tremie") ') is None):
          dwg.SendCommand('command "-layer" "n" "GEX_EDS_sdp_2-tremie" "CO" "U" "255,255,127" "GEX_EDS_sdp_2-tremie" ""') 
       if(dwg.SendCommand('(tblsearch "layer" "GEX_EDS_sdp_3-h-180") ') is None):
          dwg.SendCommand('command "-layer" "n" "GEX_EDS_sdp_3-h-180" "CO" "U" "165,82,82" "GEX_EDS_sdp_3-h-180" "")') 
       if(dwg.SendCommand('(tblsearch "layer" "GEX_EDS_sdp_5-pk") ') is None):
          dwg.SendCommand('command "-layer" "n" "GEX_EDS_sdp_5-pk" "CO" "U" "153,153,153" "GEX_EDS_sdp_5-PK" ""') 
       if(dwg.SendCommand('(tblsearch "layer" "GEX_EDS_sdp_6-combles") ') is None):
          dwg.SendCommand('command "-layer" "n" "GEX_EDS_sdp_6-combles" "CO" "U" "82,0,165" "GEX_EDS_sdp_6-combles" ""') 
       if(dwg.SendCommand('(tblsearch "layer" "GEX_EDS_sdp_7-lt") ') is None):
          dwg.SendCommand('command "-layer" "n" "GEX_EDS_sdp_7-lt" "CO" "U" "0,127,255" "GEX_EDS_sdp_7-LT" "")""') 
       if(dwg.SendCommand('(tblsearch "layer" "GEX_EDS_sdp_8-cave") ') is None):
          dwg.SendCommand('command "-layer" "n" "GEX_EDS_sdp_8-cave" "CO" "U" "255,191,127" "GEX_EDS_sdp_8-cave"  ""') 
       if(dwg.SendCommand('(tblsearch "layer" "GEX_EDS_sdp_teinte_contour") ') is None):
          dwg.SendCommand('command "-layer" "n" "GEX_EDS_sdp_teinte_contour" "CO" "U" "255,127,127" "GEX_EDS_sdp_teinte_contour" ""') 
       if(dwg.SendCommand('(tblsearch "layer" "GEX_EDS_sdp_SDP_su") ') is None):
          dwg.SendCommand('command "-layer" "n" "GEX_EDS_sdp_SDP_su" "CO" "U" "255,0,0" "GEX_EDS_sdp_SDP_su"  "")""')   
       if(dwg.SendCommand('(tblsearch "layer" "GEX_EDS_sdp_2-tremie_su") ') is None):
          dwg.SendCommand('command "-layer" "n" "GEX_EDS_sdp_2-tremie_su" "_color" "7" "GEX_EDS_sdp_2-tremie_su" ""') 
       if(dwg.SendCommand('(tblsearch "layer" "GEX_EDS_sdp_3-h-180_su") ') is None):
          dwg.SendCommand('command "-layer" "n" "GEX_EDS_sdp_3-h-180_su" "_color" "7" "GEX_EDS_sdp_3-h-180_su"  ""') 
       if(dwg.SendCommand('(tblsearch "layer" "GEX_EDS_sdp_5-pk_su") ') is None):
          dwg.SendCommand('command "-layer" "n" "GEX_EDS_sdp_5-pk_su" "_color" "7" "GEX_EDS_sdp_5-PK_su" ""') 
       if(dwg.SendCommand('(tblsearch "layer" "GEX_EDS_sdp_6-combles_su") ') is None):
          dwg.SendCommand('command "-layer" "n" "GEX_EDS_sdp_6-combles_su" "_color" "7" "GEX_EDS_sdp_6-combles_su"  ""') 
       if(dwg.SendCommand('(tblsearch "layer" "GEX_EDS_sdp_7-lt_su") ') is None):
          dwg.SendCommand('command "-layer" "n" "GEX_EDS_sdp_7-lt_su" "_color" "7" "GEX_EDS_sdp_7-LT_su" "")""') 
       if(dwg.SendCommand('(tblsearch "layer" "GEX_EDS_sdp_8-cave_su") ') is None):
          dwg.SendCommand('command "-layer" "n" "GEX_EDS_sdp_8-cave_su" "_color" "7" "GEX_EDS_sdp_8-cave_su" ""') 
       if(dwg.SendCommand('(tblsearch "style" "SURF") ') is None):
          dwg.SendCommand('command "-STYLER" "SURF"  "swissl.ttf" "0.000" "" "" "" "" "")""') 
       #________________Surface Planchers avant déductions___________________________
       # Commande pour appliquer le geler
       dwg.SendCommand('command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_sdp_teinte_contour" "l" "GEX_EDS_sdp_SDP_su" ""')
       
       for element in liste:
        dwg.SendCommand('command "-calque" "ch" "0" "" ""')
        dwg.SendCommand('command "-calque" "l" element ""')
        def cons(x, xs):
            return [x, *xs]
      
      
       
        sel = list[ cons(-4 ,"<or"), cons(-4 ,"<and"),cons(0 ,"LWPOLYLINE"), cons( 8 ,element), cons( -4, "and>"), cons( -4, "<and"),
        cons(0 ,"CIRCLE"), cons(8 ,element), cons( -4, "and>"), cons(-4 ,"or>")]
        dwg.SendCommand('command  "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" ""')
        dwg.SendCommand('command "_clayer" "GEX_EDS_sdp_teinte_contour"')
        dwg.SendCommand('command "-hachures" "s" sel "" ""')
        dwg.SendCommand('command "_clayer" "GEX_EDS_sdp_SDP_su"')
       # getCalqueAppliqueApplatSDP  ("GEX_EDS_sdp_teinte_contour" ,1)

        #___________________________________Surfaces Vides______________________________________
        dwg.SendCommand('command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_sdp_2-tremie" "l" "GEX_EDS_sdp_2-tremie_su" ""')
        set_T = list[ cons(-4 ,"<or"), cons(-4 ,"<and"),cons(0 ,"LWPOLYLINE"), cons( 8 ,"GEX_EDS_sdp_2-tremie"), cons( -4, "and>"), cons( -4, "<and"),
        cons(0 ,"CIRCLE"), cons(8 ,"GEX_EDS_sdp_2-tremie"), cons( -4, "and>"), cons(-4 ,"or>")]
        dwg.SendCommand('command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" ""')
        dwg.SendCommand('command "_clayer" "GEX_EDS_sdp_2-tremie"')
        dwg.SendCommand('command "-hachures" "s" sel_T "" ""')
        dwg.SendCommand('command "_clayer" "GEX_EDS_sdp_2-tremie_su"')
        #getCalqueAppliqueApplatSDP  ("GEX_EDS_sdp_2-tremie" ,0)

        #__________________________________Surfaces dont h < 1.80 m_____________________________
        dwg.SendCommand('command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_sdp_3-h-180" "l" "GEX_EDS_sdp_3-h-180_su" ""')
        set_C = list[ cons(-4 ,"<or"), cons(-4 ,"<and"),cons(0 ,"LWPOLYLINE"), cons( 8 ,"GEX_EDS_sdp_3-h-180"), cons( -4, "and>"), cons( -4, "<and"),
        cons(0 ,"CIRCLE"), cons(8 ,"GEX_EDS_sdp_3-h-180"), cons( -4, "and>"), cons(-4 ,"or>")]
        dwg.SendCommand('command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" ""')
        dwg.SendCommand('command "_clayer" "GEX_EDS_sdp_3-h-180"')
        dwg.SendCommand('command "-hachures" "s" sel_C "" ""')
        dwg.SendCommand('command "_clayer" "GEX_EDS_sdp_3-h-180_su"')
       # getCalqueAppliqueApplatSDP  ("GEX_EDS_sdp_3-h-180" ,0)
        
        #__________________________________Surfaces Stationnement_____________________________
        dwg.SendCommand('command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_sdp_5-PK" "l" "GEX_EDS_sdp_5-PK_su" ""')
        set_H = list[ cons(-4 ,"<or"), cons(-4 ,"<and"),cons(0 ,"LWPOLYLINE"), cons( 8 ,"GEX_EDS_sdp_5-PK"), cons( -4, "and>"), cons( -4, "<and"),
        cons(0 ,"CIRCLE"), cons(8 ,"GEX_EDS_sdp_5-PK"), cons( -4, "and>"), cons(-4 ,"or>")]
        dwg.SendCommand('command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" ""')
        dwg.SendCommand('command "_clayer" "GEX_EDS_sdp_5-PK"')
        dwg.SendCommand('command "-hachures" "s" sel_H "" ""')
        dwg.SendCommand('command "_clayer" "GEX_EDS_sdp_5-PK_su"')
        #getCalqueAppliqueApplatSDP  ("GEX_EDS_sdp_5-PK" ,0)
        

        #__________________________________Surfaces Combles___________________________________
        dwg.SendCommand('command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_sdp_6-combles" "l" "GEX_EDS_sdp_6-combles_su" ""')
        set_L = list[ cons(-4 ,"<or"), cons(-4 ,"<and"),cons(0 ,"LWPOLYLINE"), cons( 8 ,"GEX_EDS_sdp_6-combles"), cons( -4, "and>"), cons( -4, "<and"),
        cons(0 ,"CIRCLE"), cons(8 ,"GEX_EDS_sdp_6-combles"), cons( -4, "and>"), cons(-4 ,"or>")]
        dwg.SendCommand('command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" ""')
        dwg.SendCommand('command "_clayer" "GEX_EDS_sdp_6-combles"')
        dwg.SendCommand('command "-hachures" "s" sel_L "" ""')
        dwg.SendCommand('command "_clayer" "GEX_EDS_sdp_6-combles_su"')
        #getCalqueAppliqueApplatSDP  ("GEX_EDS_sdp_6-combles" ,0)

        
        #______________________________Surfaces Locaux techniques____________________
        dwg.SendCommand('command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_sdp_7-LT" "l" "GEX_EDS_sdp_7-LT_su" ""')
        sel_P = list[ cons(-4 ,"<or"), cons(-4 ,"<and"),cons(0 ,"LWPOLYLINE"), cons( 8 ,"GEX_EDS_sdp_7-LT"), cons( -4, "and>"), cons( -4, "<and"),
        cons(0 ,"CIRCLE"), cons(8 ,"GEX_EDS_sdp_7-LT"), cons( -4, "and>"), cons(-4 ,"or>")]
        dwg.SendCommand('command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" ""')
        dwg.SendCommand('command "_clayer" "GEX_EDS_sdp_7-LT"')
        dwg.SendCommand('command "-hachures" "s" sel_P "" ""')
        dwg.SendCommand('command "_clayer" "GEX_EDS_sdp_7-LT_su"')
        #getCalqueAppliqueApplatSDP  ("GEX_EDS_sdp_7-LT" ,0)

        #______________________________Surfaces Caves ____________________
        dwg.SendCommand('command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_sdp_8-cave" "l" "GEX_EDS_sdp_8-cave_su" ""')
        sel_S = list[ cons(-4 ,"<or"), cons(-4 ,"<and"),cons(0 ,"LWPOLYLINE"), cons( 8 ,"GEX_EDS_sdp_8-cave"), cons( -4, "and>"), cons( -4, "<and"),
        cons(0 ,"CIRCLE"), cons(8 ,"GEX_EDS_sdp_8-cave"), cons( -4, "and>"), cons(-4 ,"or>")]
        dwg.SendCommand('command "-hachures" "p" "s" "a" "s" "n" "a" "o" "i" "o" "h" "o" "" ""')
        dwg.SendCommand('command "_clayer" "GEX_EDS_sdp_8-cave"')
        dwg.SendCommand('command "-hachures" "s" sel_S "" ""')
        dwg.SendCommand('command "_clayer" "GEX_EDS_sdp_8-cave_su"')
        #getCalqueAppliqueApplatSDP  ("GEX_EDS_sdp_8-cave" ,0)

        #_____________________Apres la calcul des différentes surfaces __________
        dwg.SendCommand('(command "-layer" "l" "*" "E" "0" "g" "GEX_EDS_sdp_teinte_contour" "")')
        dwg.SendCommand('(alert "         *********   O P E R A T I O N    T E R M I N E E   *********        ")')
        dwg.SendCommand('(setvar "osmode" os)')
        dwg.SendCommand('(princ "\n")')


        
        def getCalqueAppliqueApplatSDP ( X, Y):
            return(X,Y)
        #_____________________ Surfaces Vides________________ ;;; 
       

#dwg.SendCommand('(tblsearch "layer" "0") ') is None 


sdp()

