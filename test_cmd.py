 #Import needed modules
import os
from re import T
from click import command
import comtypes.client
from comtypes import COMError
from comtypes.client import CreateObject, GetModule, GetActiveObject
from pyzwcad import ZwCAD, APoint, aDouble
import shlex,subprocess
#from Autodesk.AutoCAD.ApplicationServices import *
#import Autodesk.AutoCAD.ApplicationServices as aas





def sdp():
        acad = ZwCAD()
        acad.ActiveDocument.SetVariable("OSMODE", 16383) # Activer l'accrochage aux objets
        acad.ActiveDocument.SetVariable("HPISLANDDETECTIONMODE", 0)
        launchSdpCounter = 1
      #_______________Déclarer les variables sys dont osmode et HPISLANDDETECTIONMODE
        folder = r'C:\Users\adziri\Desktop\GexApp\charte_graphique\M20-002392_E0_SDP_SHO_Test.dwg'
        lispfile = 'EDS_SDP_zwcad_v2202.lsp'
        #dwg_path = os.path.join(folder)
        #doc = acad.ActiveDocument.Open(dwg_path)
        doc = acad.ActiveDocument
        p = aDouble(0,0,10,10,20,10)
        print(p)
        pl = acad.model.AddLightWeightPolyline(p)
        print(pl)
     
        #acad.ActiveDocument.SendCommand('-layer n  GEX_EDS_sdp_3-h-180  ''\n ''  CO U 165,82,82 GEX_EDS_sdp_3-h-180 ')
        #acad.ActiveDocument.SendCommand('-layer n  GEX_EDS_sdp_2-tremie CO U 255,255,127 GEX_EDS_sdp_2-tremie ')

       # (command "-layer" "E" 0 "g" "*" "l" "GEX_EDS_sdp_teinte_contour" "l" "GEX_EDS_sdp_SDP_su" "")""
         #Our example command is to draw a line from (0,0) to (5,5)
         
        command_str = '.-layer E 'f'{0}'' \n  g * \n  l  GEX_EDS_sdp_teinte_contour \n  l GEX_EDS_sdp_SDP_su \n ' #  Notice that the last SPACE is equivalent to hiting ENTER
                                        #  You should separate the command's arguments also with SPACE
       # doc.PostCommand(command_str)

         #acad.ActiveDocument.SendCommand('-calque E  GEX_EDS_sdp_2-tremie_su     \n ') #affecter calque courant: GEX_EDS_sdp_2-tremie_su
        command_str = '.-layer E 'f'{0}'' \n  g * \n  l  GEX_EDS_sdp_teinte_contour \n  l GEX_EDS_sdp_SDP_su \n ' 
        liste = acad.ActiveDocument.PostCommand(command_str)
        #acad.ActiveDocument.SendCommand('.-layer E 'f'{0}'' \n  g * \n  l  GEX_EDS_sdp_teinte_contour \n  l GEX_EDS_sdp_SDP_su \n '  ) 
        

        #liste = acad.ActiveDocument.PostCommand(command_str)
        searchparam = acad.ActiveDocument.PostCommand('tblnext layer ')
        layers_nums = acad.ActiveDocument.Layers.count   #  {{{acad.doc.Layers.count}}} are the same  # The total number of layers contained in the current file model space
        for i in range(layers_nums):
             layers_names = [acad.ActiveDocument.Layers.Item(i).Name ]

        for element in layers_names:
                 acad.ActiveDocument.PostCommand('.-calque ch  'f'{0}'' \n ')
                 acad.ActiveDocument.PostCommand('.-calque l  'f'{element}'' \n ')
        #Send the command to the drawing
        #doc.SendCommand(command_str)
        #sel = doc.SendCommand("(SSGET\"_X\"'((-4 . \"<OR\")(-4 . \"<AND\")(0 . \"*LWPOLYLINE\")(8 . \"element\")(-4 . \"AND>\")(0 . \"CIRCLE\")(8 . \"element\")(-4 . \"AND>\")(-4 . \"OR>\"))) ")
        
        
        #acad.ActiveDocument.SendCommand('._CLAYER GEX_EDS_sdp_SDP_su \n')

        #acad.ActiveDocument.SendCommand('princ  calqueC  \n')
			   
        #acad.doc.Menu.Add('MENU  ')
        

        
        


        #liste =  acad.ActiveDocument.SendCommand('getLayersdp "GEX_EDS_sdp_1-" ')

        #for element in liste:
          #acad.ActiveDocument.SendCommand('-CALQUE chr(0)')
          #acad.ActiveDocument.SendCommand('-CALQUE l element ')
       # acad.ActiveDocument.SendCommand('-CALQUE E  g  *  l  GEX_EDS_sdp_teinte_contour  l  GEX_EDS_sdp_SDP_su  ' )
       # test = acad.ActiveDocument.SendCommand("_sdp ")
        #print('test SDP est vrai', test )


if __name__ == '__main__':
    sdp()
 