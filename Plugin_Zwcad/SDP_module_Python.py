#Import needed modules
import os
from re import T
from tkinter.ttk import Style
from click import command
import comtypes.client
from comtypes import COMError
from comtypes.client import CreateObject, GetModule, GetActiveObject
from pyzwcad import ZwCAD, APoint
import json
import re



def main():
    #initialiser extension Zwcad
    acad = ZwCAD()
    #Declartion variable systéme Zwcad
    acad.ActiveDocument.SetVariable("OSMODE", 16383) # Activer l'accrochage aux objets
    acad.ActiveDocument.SetVariable("HPISLANDDETECTIONMODE", 0)
    acad.ActiveDocument.SetVariable("HPNAME", 'SOLID')
    

    #Declartion critéres __layers SDP/SHO
    #f = open('SDP_layer.json')
    #data = json.load(f)
 
    SDP_layers_list = [
    {'id': 1, 'name': 'GEX_EDS_sdp_2-tremie',"style":"CO", "epaisseur": "U", "Color":{"red":255, "green": 255,"blue": 127 } },
    {'id': 2, 'name': 'GEX_EDS_sdp_3-h-180',"style":"CO", "epaisseur": "U", "Color":{ "red": 165, "green": 82,"blue": 82 } },
    {'id': 3, 'name': 'GEX_EDS_sdp_5-pk',"style":"CO", "epaisseur": "U", "Color":{ "red": 153, "green": 153,"blue": 153 }},
    {'id': 4, 'name': 'GEX_EDS_sdp_6-combles',"style":"CO", "epaisseur": "U", "Color":{ "red": 82, "green": 0,"blue": 165}},
    {'id': 5, 'name': 'GEX_EDS_sdp_7-lt',"style":"CO", "epaisseur": "U", "Color":{ "red": 0, "green": 127,"blue": 255} },
    {'id': 6, 'name': 'GEX_EDS_sdp_8-cave',"style":"CO", "epaisseur": "U", "Color":{ "red": 255, "green": 191,"blue": 127} },
    {'id': 7, 'name': 'GEX_EDS_sdp_teinte_contour',"style":"CO", "epaisseur": "U", "Color":{ "red": 255, "green": 127,"blue": 127}},
    {'id': 8, 'name': 'GEX_EDS_sdp_SDP_su',"style":"CO", "epaisseur": "U", "Color":{  "red": 255, "green": 0,"blue": 0} },
    {'id': 9, 'name': 'GEX_EDS_sdp_2-tremie_su',"style":"CO", "epaisseur": "U", "Color":"_color" },
    {'id': 10, 'name': 'GEX_EDS_sdp_3-h-180_su',"style":"CO", "epaisseur": "U", "Color":"_color" },
    {'id': 11, 'name': 'GEX_EDS_sdp_5-pk_su',"style":"CO", "epaisseur": "U", "Color":"_color" },
    {'id': 12, 'name': 'GEX_EDS_sdp_6-combles_su',"style":"CO", "epaisseur": "U", "Color":"_color"},
    {'id': 13, 'name': 'GEX_EDS_sdp_7-lt_su',"style":"CO", "epaisseur": "U", "Color":"_color" },
    {'id': 14, 'name': 'GEX_EDS_sdp_8-cave_su',"style":"CO", "epaisseur": "U", "Color":"_color" },
    ]
  
    SHO_layers_list = [
        {'id': 1, 'name': 'GEX_EDS_shob_contour',"style":"CO", "epaisseur": "U", "Color":{"red":255, "green": 255,"blue": 127 } },
        {'id': 2, 'name': 'GEX_EDS_shob_tremie',"style":"CO", "epaisseur": "U", "Color":{ "red": 165, "green": 82,"blue": 82 } },
        {'id': 3, 'name': 'GEX_EDS_shon_h-180',"style":"CO", "epaisseur": "U", "Color":{ "red": 153, "green": 153,"blue": 153 }},
        {'id': 4, 'name': 'GEX_EDS_shon_snc',"style":"CO", "epaisseur": "U", "Color":{ "red": 82, "green": 0,"blue": 165}},
    ]
 
    #----------------------------------------------------------------------------------------------------------------------------------------------      
    #Tester l'existance des calques SDP sinon les creer.
    #----------------------------------------------------------------------------------------------------------------------------------------------      
   
    result = SDP_layers_list[3]['Color']['red']
    for i in range(13):
          test = SDP_layers_list[i]['name']

          if 'GEX_EDS_sdp_2-tremie' not in test :
             command_str_tremie = '.-layer n GEX_EDS_sdp_2-tremie  \n  CO U 255,255,127 GEX_EDS_sdp_2-tremie \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
             acad.ActiveDocument.PostCommand(command_str_tremie)
          else:
           print('existe déja')

           if 'GEX_EDS_sdp_3-h-180' not in test :
              command_str_h_180 = '.-layer n GEX_EDS_sdp_3-h-180  \n  CO U 165,82,82 GEX_EDS_sdp_3-h-180 \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
              acad.ActiveDocument.PostCommand(command_str_h_180)
           else:
              print('existe déja')

           if 'GEX_EDS_sdp_5-pk' not in test :
              command_str_pk = '.-layer n GEX_EDS_sdp_5-pk  \n  CO U 153,153,153 GEX_EDS_sdp_5-pk \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
              acad.ActiveDocument.PostCommand(command_str_pk)
           else:
              print('existe déja')

           if 'GEX_EDS_sdp_6-combles' not in test :
              command_str_comble = '.-layer n GEX_EDS_sdp_6-combles  \n  CO U 82,0,165 GEX_EDS_sdp_6-combles \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
              acad.ActiveDocument.PostCommand(command_str_comble)
           else:
              print('existe déja')

           if 'GEX_EDS_sdp_7-lt' not in test :
              command_str_lt = '.-layer n GEX_EDS_sdp_7-lt  \n  CO U 0,127,255 GEX_EDS_sdp_7-lt \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
              acad.ActiveDocument.PostCommand(command_str_lt)
           else:
              print('existe déja')


           if 'GEX_EDS_sdp_8-cave' not in test :
              command_str_lt = '.-layer n GEX_EDS_sdp_8-cave  \n  CO U 255,191,127 GEX_EDS_sdp_8-cave \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
              acad.ActiveDocument.PostCommand(command_str_lt)
           else:
              print('existe déja')

           if 'GEX_EDS_sdp_teinte_contour' not in test :
               command_str_teinte_contours = '.-layer n GEX_EDS_sdp_teinte_contour  \n  CO U 255,127,127 GEX_EDS_sdp_teinte_contour \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
               acad.ActiveDocument.PostCommand(command_str_teinte_contours)
           else:
              print('existe déja')
           if 'GEX_EDS_sdp_SDP_su' not in test :
              command_str_SDP_su = '.-layer n GEX_EDS_sdp_SDP_su  \n  CO U 255,0,0 GEX_EDS_sdp_SDP_su \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
              acad.ActiveDocument.PostCommand(command_str_SDP_su)
           else:
              print('existe déja')

           if 'GEX_EDS_sdp_2-tremie_su' not in test :
               command_str_tremie_su = '.-layer n GEX_EDS_sdp_2-tremie_su  \n  _color 7 GEX_EDS_sdp_2-tremie_su \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
               acad.ActiveDocument.PostCommand(command_str_tremie_su)
           else:
              print('existe déja')

           if 'GEX_EDS_sdp_3-h-180_su' not in test :
              command_str_h_180_su = '.-layer n GEX_EDS_sdp_3-h-180_su  \n  _color 7 GEX_EDS_sdp_3-h-180_su \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
              acad.ActiveDocument.PostCommand(command_str_h_180_su)
           else:
              print('existe déja')

           if 'GEX_EDS_sdp_5-pk_su' not in test :
               command_str_pk_su = '.-layer n GEX_EDS_sdp_5-pk_su  \n  _color 7 GEX_EDS_sdp_5-pk_su \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
               acad.ActiveDocument.PostCommand(command_str_pk_su)
           else:
              print('existe déja')
           if 'GEX_EDS_sdp_6-combles_su' not in test :
              command_str_combles_su = '.-layer n GEX_EDS_sdp_6-combles_su  \n  _color 7 GEX_EDS_sdp_6-combles_su \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
              acad.ActiveDocument.PostCommand(command_str_combles_su)
           else:
              print('existe déja')
           if 'GEX_EDS_sdp_7-lt_su' not in test :
              command_str_lt_su = '.-layer n GEX_EDS_sdp_7-lt_su  \n  _color 7 GEX_EDS_sdp_7-lt_su \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
              acad.ActiveDocument.PostCommand(command_str_lt_su)
           else:
              print('existe déja')
           if 'GEX_EDS_sdp_8-cave_su' not in test :
               command_str_cave_su = '.-layer n GEX_EDS_sdp_8-cave_su  \n  _color 7 GEX_EDS_sdp_8-cave_su \n ' #  Notice that the last SPACE is equivalent to hiting ENTER   
               acad.ActiveDocument.PostCommand(command_str_cave_su)
           else:
              print('existe déja')

    #----------------------------------------------------------------------------------------------------------------------------------------------      
    #Tester la saisie des nouveaux calques 
    #----------------------------------------------------------------------------------------------------------------------------------------------      
    def Ajouter_New_calque():
       # a = input("GEX_EDS_")
       # calque = f"GEX_EDS_{Nom_new_calque}"
        new_string = ''.join(filter(str.isalnum, "GEX_EDS_"+a)) 
        print(new_string)  


    #----------------------------------------------------------------------------------------------------------------------------------------------      
    # Surfaces  Planchers avant déductions 
    #----------------------------------------------------------------------------------------------------------------------------------------------      
    def surface_planchers_Before_deductions():
       command_str = '.-layer E 'f'{0}'' \n  g * \n  l  GEX_EDS_sdp_teinte_contour \n  l GEX_EDS_sdp_SDP_su \n ' 
       liste = acad.ActiveDocument.PostCommand(command_str)
       layers_nums = acad.ActiveDocument.Layers.count   #  {{{acad.doc.Layers.count}}} are the same  # The total number of layers contained in the current file model space
       for i in range(layers_nums):
             layers_names = [acad.ActiveDocument.Layers.Item(i).Name ]
           
       acad.ActiveDocument.PostCommand('.-calque ch  'f'{0}'' \n ')
       acad.ActiveDocument.PostCommand('.-calque l  'f'{layers_names}'' \n ')
       sel = acad.ActiveDocument.PostCommand("(setq sel (SSGET\"_X\"'((-4 . \"<OR\")(-4 . \"<AND\")(0 . \"*LWPOLYLINE\")(8 . \"element\")(-4 . \"AND>\")(0 . \"CIRCLE\")(8 . \"element\")(-4 . \"AND>\")(-4 . \"OR>\")))) ")
       acad.ActiveDocument.PostCommand('.-HACHURES p s a s n a o i o h o   ') 
       acad.ActiveDocument.PostCommand('clayer  GEX_EDS_sdp_teinte_contour \n')
       acad.ActiveDocument.PostCommand('.-HACHURES s 'f'{sel}'' \n ')
       acad.ActiveDocument.PostCommand('clayer  GEX_EDS_sdp_SDP_su \n')

    #----------------------------------------------------------------------------------------------------------------------------------------------      
    # Surfaces Vides 
    #----------------------------------------------------------------------------------------------------------------------------------------------      




   # Ajouter_New_calque()
    surface_planchers_Before_deductions()
        


   

if __name__ == '__main__':
    main()






    

