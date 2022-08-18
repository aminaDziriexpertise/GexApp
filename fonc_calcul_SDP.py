#Import needed modules
import os
from re import T
from click import command
import comtypes.client
from comtypes import COMError
from comtypes.client import CreateObject, GetModule, GetActiveObject
from pyzwcad import ZwCAD, APoint
from regex import P
#import Autodesk.AutoCAD.ApplicationServices as aas

def sdp():
    acad = ZwCAD()
    acad.ActiveDocument.SetVariable("OSMODE", 16383) # Activer l'accrochage aux objets
    acad.ActiveDocument.SetVariable("HPISLANDDETECTIONMODE", 0)
    acad.ActiveDocument.SetVariable("HPNAME", 'SOLID')
    #clr = acad.ActiveDocument.Application.GetInterfaceObject("AutoCAD.AcCmColor.19")
    #clr.SetRGB(255, 0, 255) # R=255, G=0, B=255.
 
    
    def cheeck_layers():
            layers_nums = acad.ActiveDocument.Layers.count   #  {{{acad.doc.Layers.count}}} are the same  # The total number of layers contained in the current file model space
            for i in range(layers_nums):
             layers_names = [acad.ActiveDocument.Layers.Item(i).Name ]
             #print(layers_nums)
             #print(layers_names)
           
            if layers_names != ['GEX_EDS_sdp_2-tremie']:
                    #acad.ActiveDocument.Layers.Add('GEX_EDS_sdp_2-tremie')
                    command_str_tremie = '.-layer n GEX_EDS_sdp_2-tremie  \n  CO U 255,255,127 GEX_EDS_sdp_2-tremie \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
                    acad.ActiveDocument.PostCommand(command_str_tremie)
            if layers_names != ['GEX_EDS_sdp_3-h-180']:
                     #acad.ActiveDocument.Layers.Add('GEX_EDS_sdp_3-h-180')
                    command_str_h_180 = '.-layer n GEX_EDS_sdp_3-h-180  \n  CO U 165,82,82 GEX_EDS_sdp_3-h-180 \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
                    acad.ActiveDocument.PostCommand(command_str_h_180)
                     
            if layers_names != ['GEX_EDS_sdp_5-pk']:
                    #acad.ActiveDocument.Layers.Add('GEX_EDS_sdp_5-pk')
                    command_str_pk = '.-layer n GEX_EDS_sdp_5-pk  \n  CO U 153,153,153 GEX_EDS_sdp_5-pk \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
                    acad.ActiveDocument.PostCommand(command_str_pk)
                 
            if layers_names !=['GEX_EDS_sdp_6-combles']:
                    #acad.ActiveDocument.Layers.Add('GEX_EDS_sdp_6-combles')
                    command_str_comble = '.-layer n GEX_EDS_sdp_6-combles  \n  CO U 82,0,165 GEX_EDS_sdp_6-combles \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
                    acad.ActiveDocument.PostCommand(command_str_comble)
                    
            if layers_names !=['GEX_EDS_sdp_7-lt']:
                    #acad.ActiveDocument.Layers.Add('GEX_EDS_sdp_7-lt')
                    command_str_lt = '.-layer n GEX_EDS_sdp_7-lt  \n  CO U 0,127,255 GEX_EDS_sdp_7-lt \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
                    acad.ActiveDocument.PostCommand(command_str_lt)
                    
            if layers_names !=['GEX_EDS_sdp_8-cave']:
                    #acad.ActiveDocument.Layers.Add('GEX_EDS_sdp_8-cave')
                    command_str_lt = '.-layer n GEX_EDS_sdp_8-cave  \n  CO U 255,191,127 GEX_EDS_sdp_8-cave \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
                    acad.ActiveDocument.PostCommand(command_str_lt)
                    
            if layers_names !=['GEX_EDS_sdp_teinte_contour']:
                    #acad.ActiveDocument.Layers.Add('GEX_EDS_sdp_teinte_contour')
                    command_str_teinte_contours = '.-layer n GEX_EDS_sdp_teinte_contour  \n  CO U 255,127,127 GEX_EDS_sdp_teinte_contour \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
                    acad.ActiveDocument.PostCommand(command_str_teinte_contours)
                
            if layers_names !=['GEX_EDS_sdp_SDP_su']:
                    #acad.ActiveDocument.Layers.Add('GEX_EDS_sdp_SDP_su')
                    command_str_SDP_su = '.-layer n GEX_EDS_sdp_SDP_su  \n  CO U 255,0,0 GEX_EDS_sdp_SDP_su \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
                    acad.ActiveDocument.PostCommand(command_str_SDP_su)
                    
            if layers_names !=['GEX_EDS_sdp_2-tremie_su']:
                    #acad.ActiveDocument.Layers.Add('GEX_EDS_sdp_2-tremie_su')
                    command_str_tremie_su = '.-layer n GEX_EDS_sdp_2-tremie_su  \n  _color 7 GEX_EDS_sdp_2-tremie_su \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
                    acad.ActiveDocument.PostCommand(command_str_tremie_su)
                    
            if layers_names !=['GEX_EDS_sdp_3-h-180_su']:
                    #acad.ActiveDocument.Layers.Add('GEX_EDS_sdp_3-h-180_su')
                    command_str_h_180_su = '.-layer n GEX_EDS_sdp_3-h-180_su  \n  _color 7 GEX_EDS_sdp_3-h-180_su \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
                    acad.ActiveDocument.PostCommand(command_str_h_180_su)
                   
            if layers_names !=['GEX_EDS_sdp_5-pk_su']:
                    #acad.ActiveDocument.Layers.Add('GEX_EDS_sdp_5-pk_su')
                    command_str_pk_su = '.-layer n GEX_EDS_sdp_5-pk_su  \n  _color 7 GEX_EDS_sdp_5-pk_su \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
                    acad.ActiveDocument.PostCommand(command_str_pk_su)
                 
            if layers_names !=['GEX_EDS_sdp_6-combles_su']:
                    #acad.ActiveDocument.Layers.Add('GEX_EDS_sdp_6-combles_su')
                    command_str_combles_su = '.-layer n GEX_EDS_sdp_6-combles_su  \n  _color 7 GEX_EDS_sdp_6-combles_su \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
                    acad.ActiveDocument.PostCommand(command_str_combles_su)
                    
            if layers_names !=['GEX_EDS_sdp_7-lt_su']:
                    #acad.ActiveDocument.Layers.Add('GEX_EDS_sdp_7-lt_su')
                    command_str_lt_su = '.-layer n GEX_EDS_sdp_7-lt_su  \n  _color 7 GEX_EDS_sdp_7-lt_su \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
                    acad.ActiveDocument.PostCommand(command_str_lt_su)
            if  layers_names !=['GEX_EDS_sdp_8-cave_su']:
                    #acad.ActiveDocument.Layers.Add('GEX_EDS_sdp_8-cave_su')
                    command_str_cave_su = '.-layer n GEX_EDS_sdp_8-cave_su  \n  _color 7 GEX_EDS_sdp_8-cave_su \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
                    acad.ActiveDocument.PostCommand(command_str_cave_su)

                    

            layers_nums = acad.ActiveDocument.Layers.count 
               # print(layers_names)
               # print(layers_nums)

            layers='GEX_EDS_sdp_3-h-180'
            # if layers in layers_names:
            #       # Print success message
               # print("%s is found in the list" %(layers_names))
            # else:
                  # Imprimer le message introuvable
               # print("%s is not found in the list" %(layers_names))



            # i = 0
             # parcourir avec la boucle while
            # while i < len(layers_names): 
              #   print(layers_names[i]) 
                # i = i+1


            b = [['GEX_EDS_sdp_2-tremie'],['GEX_EDS_sdp_3-h-180'],['GEX_EDS_sdp_5-pk'],['GEX_EDS_sdp_6-combles'],['GEX_EDS_sdp_7-lt'],['GEX_EDS_sdp_8-cave'],['GEX_EDS_sdp_teinte_contour'],['GEX_EDS_sdp_SDP_su'],['GEX_EDS_sdp_2-tremie_su'],['GEX_EDS_sdp_3-h-180_su'],['GEX_EDS_sdp_5-pk_su'],['GEX_EDS_sdp_6-combles_su'],['GEX_EDS_sdp_7-lt_su'],['GEX_EDS_sdp_8-cave_su']]

             #b = [['GEX_EDS_sdp_2-tremieeeee'],['GEX_EDS_sdp_3-h-180'],['GEX_EDS_sdp_5-pk'],['GEX_EDS_sdp_6-combles'],['GEX_EDS_sdp_7-lt'],['GEX_EDS_sdp_8-cave'],['GEX_EDS_sdp_teinte_contour'],['GEX_EDS_sdp_SDP_su'],['GEX_EDS_sdp_2-tremie_su'],['GEX_EDS_sdp_3-h-180_su'],['GEX_EDS_sdp_5-pk_su'],['GEX_EDS_sdp_6-combles_su'],['GEX_EDS_sdp_7-lt_su'],['GEX_EDS_sdp_8-cave_su']]

             #if ([i for i,j in enumerate(layers_names) for k,l in enumerate(b) if i == k and j!=l]):
             #for i,j in enumerate(layers_names):
                #for k,l in enumerate(b):
                    #if i == k and j!=l:
                  #     print(i)
                    #   print("True")
                   # else:
                      # print("False")
              #acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_2-tremie")
    def getLayersdp(searchparamtext):
        searchparam = '*'+ searchparamtext +'*' # concat strings
        newelem = 0
        while  (newelem  in searchparamtext) & (searchparamtext!= None) :
            if (newelem[2])
            if acad.ActiveDocument.PostCommand('(wcmatch (cdr (assoc 2 newelem)) searchparam)')

        searchparam = acad.ActiveDocument.PostCommand('tblnext layer ')





    def calcul_surface(element):
              acad.ActiveDocument.SendCommand("(setq sel (SSGET\"_X\"'((-4 . \"<OR\")(-4 . \"<AND\")(0 . \"*LWPOLYLINE\")(8 . \"element\")(-4 . \"AND>\")(0 . \"CIRCLE\")(8 . \"element\")(-4 . \"AND>\")(-4 . \"OR>\")))) ")




    ## Surfaces  Planchers avant déductions
    def surface_plancher_ded():
           
              
              #acad.ActiveDocument.SendCommand('-calque E  GEX_EDS_sdp_2-tremie_su     \n ') #affecter calque courant: GEX_EDS_sdp_2-tremie_su
              command_str = '.-layer E 'f'{0}'' \n  g * \n  l  GEX_EDS_sdp_teinte_contour \n  l GEX_EDS_sdp_SDP_su \n ' 
              liste = acad.ActiveDocument.PostCommand(command_str)
              #acad.ActiveDocument.SendCommand('.-layer E 'f'{0}'' \n  g * \n  l  GEX_EDS_sdp_teinte_contour \n  l GEX_EDS_sdp_SDP_su \n '  ) 
              for element in liste:
                 acad.ActiveDocument.PostCommand('.-calque ch  'f'{0}'' \n ')
                 acad.ActiveDocument.PostCommand('.-calque l  'f'{element}'' \n ')
                 
              
              
              layers_nums = acad.ActiveDocument.Layers.count   #  {{{acad.doc.Layers.count}}} are the same  # The total number of layers contained in the current file model space
              for i in range(layers_nums):
                 layers_names = [acad.ActiveDocument.Layers.Item(i).Name ]
                 #print(layers_names)
                 for element in layers_names:
                     acad.ActiveDocument.SendCommand('-CALQUE ')
                     acad.ActiveDocument.SendCommand('-CALQUE l 'f'{element}'' \n  ')
                     sel = acad.ActiveDocument.SendCommand("(setq sel (SSGET\"_X\"'((-4 . \"<OR\")(-4 . \"<AND\")(0 . \"*LWPOLYLINE\")(8 . \"element\")(-4 . \"AND>\")(0 . \"CIRCLE\")(8 . \"element\")(-4 . \"AND>\")(-4 . \"OR>\")))) ")
                     acad.ActiveDocument.SendCommand('.-HACHURES p s a s n a o i o h o   ') 
                     acad.ActiveDocument.SendCommand('.clayer  GEX_EDS_sdp_teinte_contour \n')
                     acad.ActiveDocument.SendCommand('.-HACHURES s  "(setq sel (SSGET\"_X\"''((-4 . \"<OR\")(-4 . \"<AND\")(0 . \"*LWPOLYLINE\")(8 . \"element\")(-4 . \"AND>\")(0 . \"CIRCLE\")(8 . \"element\")(-4 . \"AND>\")(-4 . \"OR>\")))) " '  '') 
                     acad.ActiveDocument.SendCommand('.clayer  GEX_EDS_sdp_SDP_su \n') 
    ## Surface Vides
    def Surface_vide():
              acad.ActiveDocument.SendCommand('.-layer E 'f'{0}'' \n  g * \n  l  GEX_EDS_sdp_2-tremie \n  l GEX_EDS_sdp_2-tremie_su \n '  ) 
              sel_T = acad.ActiveDocument.SendCommand("(SSGET\"_X\"'((-4 . \"<OR\")(-4 . \"<AND\")(0 . \"*LWPOLYLINE\")(8 . \"GEX_EDS_sdp_2-tremie\")(-4 . \"AND>\")(0 . \"CIRCLE\")(8 . \"GEX_EDS_sdp_2-tremie\")(-4 . \"AND>\")(-4 . \"OR>\"))) ")
              acad.ActiveDocument.SendCommand('.-HACHURES p s a s n a o i o h o   ') 
              acad.ActiveDocument.SendCommand('.clayer GEX_EDS_sdp_2-tremie \n') 
              acad.ActiveDocument.SendCommand('.-HACHURES s  'f'{sel_T}'' \n   ') 
              acad.ActiveDocument.SendCommand('.clayer  GEX_EDS_sdp_2-tremie_su \n') 
   
    ## Surfaces dont h < 1.80 m

    def surface_h_180():
             # acad.ActiveDocument.SendCommand('-layer E  GEX_EDS_sdp_2-tremie_su  \n     ') #affecter calque courant: GEX_EDS_sdp_2-tremie_su
              acad.ActiveDocument.SendCommand('.-layer E 'f'{0}'' \n  g * \n  l  GEX_EDS_sdp_3-h-180 \n  l GEX_EDS_sdp_3-h-180_su \n '  ) 
              sel_C = acad.ActiveDocument.SendCommand("(SSGET\"_X\"'((-4 . \"<OR\")(-4 . \"<AND\")(0 . \"*LWPOLYLINE\")(8 . \"GEX_EDS_sdp_3-h-180\")(-4 . \"AND>\")(0 . \"CIRCLE\")(8 . \"GEX_EDS_sdp_3-h-180\")(-4 . \"AND>\")(-4 . \"OR>\"))) ")
              acad.ActiveDocument.SendCommand('.-HACHURES p s a s n a o i o h o   ') 
              acad.ActiveDocument.SendCommand('.clayer GEX_EDS_sdp_3-h-180 \n') 
              acad.ActiveDocument.SendCommand('.-HACHURES s  'f'{sel_C}'' \n   ') 
              acad.ActiveDocument.SendCommand('.clayer  GEX_EDS_sdp_3-h-180_su \n') 
               
              

    ## Surfaces Stationnement    
    def surface_Stationnement():
             # acad.ActiveDocument.SendCommand('-layer E  GEX_EDS_sdp_2-tremie_su  \n     ') #affecter calque courant: GEX_EDS_sdp_2-tremie_su
              acad.ActiveDocument.SendCommand('.-layer E 'f'{0}'' \n  g * \n  l  GEX_EDS_sdp_5-PK \n  l GEX_EDS_sdp_5-PK_su \n '  ) 
              sel_H = acad.ActiveDocument.SendCommand("(SSGET\"_X\"'((-4 . \"<OR\")(-4 . \"<AND\")(0 . \"*LWPOLYLINE\")(8 . \"GEX_EDS_sdp_5-PK\")(-4 . \"AND>\")(0 . \"CIRCLE\")(8 . \"GEX_EDS_sdp_5-PK\")(-4 . \"AND>\")(-4 . \"OR>\"))) ")
              acad.ActiveDocument.SendCommand('.-HACHURES p s a s n a o i o h o   ') 
              acad.ActiveDocument.SendCommand('.clayer GEX_EDS_sdp_5-PK \n') 
              acad.ActiveDocument.SendCommand('.-HACHURES s  'f'{sel_H}'' \n   ') 
              acad.ActiveDocument.SendCommand('.clayer  GEX_EDS_sdp_5-PK_su \n') 
                 
 
    ## Surfaces Combles    
    def surface_combles():
              acad.ActiveDocument.SendCommand('.-layer E 'f'{0}'' \n  g * \n  l  GEX_EDS_sdp_6-combles \n  l GEX_EDS_sdp_6-combles_su \n '  ) 
              sel_L = acad.ActiveDocument.SendCommand("(SSGET\"_X\"'((-4 . \"<OR\")(-4 . \"<AND\")(0 . \"*LWPOLYLINE\")(8 . \"GEX_EDS_sdp_6-combles\")(-4 . \"AND>\")(0 . \"CIRCLE\")(8 . \"GEX_EDS_sdp_6-combles\")(-4 . \"AND>\")(-4 . \"OR>\"))) ")
              acad.ActiveDocument.SendCommand('.-HACHURES p s a s n a o i o h o   ') 
              acad.ActiveDocument.SendCommand('.clayer GEX_EDS_sdp_6-combles \n') 
              acad.ActiveDocument.SendCommand('.-HACHURES s  'f'{sel_L}'' \n   ') 
              acad.ActiveDocument.SendCommand('.clayer  GEX_EDS_sdp_6-combles_su \n') 
             


    ## Surfaces Locaux techniques    
    def surface_Locaux_tech():
              acad.ActiveDocument.SendCommand('.-layer E 'f'{0}'' \n  g * \n  l  GEX_EDS_sdp_7-LT \n  l GEX_EDS_sdp_7-LT_su \n '  ) 
              sel_P = acad.ActiveDocument.SendCommand("(SSGET\"_X\"'((-4 . \"<OR\")(-4 . \"<AND\")(0 . \"*LWPOLYLINE\")(8 . \"GEX_EDS_sdp_7-LT\")(-4 . \"AND>\")(0 . \"CIRCLE\")(8 . \"GEX_EDS_sdp_7-LT\")(-4 . \"AND>\")(-4 . \"OR>\"))) ")
              acad.ActiveDocument.SendCommand('.-HACHURES p s a s n a o i o h o   ') 
              acad.ActiveDocument.SendCommand('.clayer GEX_EDS_sdp_7-LT \n') 
              acad.ActiveDocument.SendCommand('.-HACHURES s  'f'{sel_P}'' \n   ') 
              acad.ActiveDocument.SendCommand('.clayer  GEX_EDS_sdp_7-LT_su \n') 
              


     ## Surfaces Caves    
    def surface_Caves():
              acad.ActiveDocument.SendCommand('.-layer E 'f'{0}'' \n  g * \n  l  GEX_EDS_sdp_8-cave \n  l GEX_EDS_sdp_8-cave_su \n '  ) 
              sel_S = acad.ActiveDocument.SendCommand("(SSGET\"_X\"'((-4 . \"<OR\")(-4 . \"<AND\")(0 . \"*LWPOLYLINE\")(8 . \"GEX_EDS_sdp_8-cave\")(-4 . \"AND>\")(0 . \"CIRCLE\")(8 . \"GEX_EDS_sdp_8-cave\")(-4 . \"AND>\")(-4 . \"OR>\"))) ")
              acad.ActiveDocument.SendCommand('.-HACHURES p s a s n a o i o h o   ') 
              acad.ActiveDocument.SendCommand('.clayer GEX_EDS_sdp_8-cave \n') 
              acad.ActiveDocument.SendCommand('.-HACHURES s  'f'{sel_S}'' \n   ') 
              acad.ActiveDocument.SendCommand('.clayer  GGEX_EDS_sdp_8-cave_su \n') 
              






              #def msg():

                   # doc = aas.Application.DocumentManager.MdiActiveDocument
                    #ed = doc.Editor
                    #ed.WriteMessage("\nOur test command works!")

    cheeck_layers()
    #surface_plancher_ded()
    #Surface_vide()
    

if __name__ == '__main__':
    sdp()
 