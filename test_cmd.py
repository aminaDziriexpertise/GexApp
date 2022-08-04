 #Import needed modules
import os
from re import T
from click import command
import comtypes.client
from comtypes import COMError
from comtypes.client import CreateObject, GetModule, GetActiveObject
from pyzwcad import ZwCAD, APoint
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

         #Our example command is to draw a line from (0,0) to (5,5)
        command_str = '._line 0,0 5,5 ' #  Notice that the last SPACE is equivalent to hiting ENTER
                                        #  You should separate the command's arguments also with SPACE
        #Send the command to the drawing
        #doc.SendCommand(command_str)
        #sel = doc.SendCommand("(SSGET\"_X\"'((-4 . \"<OR\")(-4 . \"<AND\")(0 . \"*LWPOLYLINE\")(8 . \"element\")(-4 . \"AND>\")(0 . \"CIRCLE\")(8 . \"element\")(-4 . \"AND>\")(-4 . \"OR>\"))) ")
        acad.ActiveDocument.SendCommand('.-layer E "0" g * l GEX_EDS_sdp_teinte_contour l GEX_EDS_sdp_SDP_su  ') 
        

        
        


        #liste =  acad.ActiveDocument.SendCommand('getLayersdp "GEX_EDS_sdp_1-" ')

        #for element in liste:
          #acad.ActiveDocument.SendCommand('-CALQUE chr(0)')
          #acad.ActiveDocument.SendCommand('-CALQUE l element ')
       # acad.ActiveDocument.SendCommand('-CALQUE E  g  *  l  GEX_EDS_sdp_teinte_contour  l  GEX_EDS_sdp_SDP_su  ' )
       # test = acad.ActiveDocument.SendCommand("_sdp ")
        #print('test SDP est vrai', test )


if __name__ == '__main__':
    sdp()
 