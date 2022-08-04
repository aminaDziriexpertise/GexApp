
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

        
        layers__needs = [["GEX_EDS_sdp_2-tremie", "CO" "U" "255,255,127"],["GEX_EDS_sdp_3-h-180" "CO" "U" "165,82,82"],["GEX_EDS_sdp_5-pk" "CO" "U" "153,153,153" ],["GEX_EDS_sdp_6-combles" "CO" "U" "82,0,165"],["GEX_EDS_sdp_7-lt" "CO" "U" "0,127,255"],["GEX_EDS_sdp_8-cave" "CO" "U" "255,191,127"], ["GEX_EDS_sdp_teinte_contour" "CO" "U" "255,127,127" ],["GEX_EDS_sdp_SDP_su" "CO" "U" "255,0,0"], ["GEX_EDS_sdp_2-tremie_su" "_color" "7"], ["GEX_EDS_sdp_3-h-180_su" "_color" "7"], ["GEX_EDS_sdp_5-pk_su" "_color" "7"], ["GEX_EDS_sdp_6-combles_su" "_color" "7"], ["GEX_EDS_sdp_7-lt_su" "_color" "7" ], ["GEX_EDS_sdp_8-cave_su" "_color" "7"]]   
       
       # check = all(item in layers_names  for item in layers__needs)
       # if check:
            # print ("Oui, list1 contient tous les éléments de list2")
        #else :
             #print ("Oui, list1  ne contient pas  tous les éléments de list2")
     
        def Affiche__layer():
                #_________________________tester l'affichage du  LAYER____________________________
                layers_nums = acad.ActiveDocument.Layers.count   #  {{{acad.doc.Layers.count}}} are the same  # The total number of layers contained in the current file model space
                layers_names = [acad.ActiveDocument.Layers.Item(i).Name for i in range(layers_nums)] #layers_names = str(acad.doc.Layers.Item(i).Name)
                #print('layer_names are: ...', layers_names)
                #index = layers_names.index("GEX_EDS_sdp_2-tremie" ) 
                #acad.ActiveDocument.ActiveLayer = acad.ActiveDocument.Layers.Item(index)
                #print("index is ....",index)
        

        #def iterated_index(layers_names, calques):
        def iterated_index(layers_names, element):
              iterated_index_list = []
              ##___________________________style__________________________
              acad.TextStyleName = "SURF"
              #acad.ActiveDocument.ActiveTextStyle.SetFont("Kaiti", False, False, 1, 0 ou 0) # acad.ActiveDocument.ActiveTextStyle.SetFont(Typeface, Bold, Italic, charSet, PitchandFamily) 


              for i in range(len(layers_names)):
                   if layers_names[i] == element:
                      iterated_index_list.append(i)
                   else:
                      LayerObj = acad.ActiveDocument.Layers.Add(element)
                      acad.ActiveDocument.ActiveLayer = LayerObj
                      iterated_index_list.append(i)
              return iterated_index_list
              


        def iterated_index_layer():
              layers_nums = acad.ActiveDocument.Layers.count   #  {{{acad.doc.Layers.count}}} are the same  # The total number of layers contained in the current file model space
              layers_names = [acad.ActiveDocument.Layers.Item(i).Name for i in range(layers_nums)] #layers_names = str(acad.doc.Layers.Item(i).Name)
              if (acad.ActiveDocument.ActiveLayer == acad.ActiveDocument.Layers.Item(layers_names.index("GEX_EDS_sdp_2-tremie" ))):
                 print("index is ....", layers_names.index("GEX_EDS_sdp_2-tremie" ) )
              else:
                  print("Create Layer""GEX_EDS_sdp_2-tremie")
                  # Add a new layer, the layer name is LAYER .
                  LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_2-tremie")
                  # Set the LAYER  layer as the current layer.
                  acad.ActiveDocument.ActiveLayer = LayerObj
                  
              if (acad.ActiveDocument.ActiveLayer == acad.ActiveDocument.Layers.Item(layers_names.index("GEX_EDS_sdp_3-h-180" ))):
                 print("index is ....", layers_names.index("GEX_EDS_sdp_3-h-180" ) )
              else:
                  print("Create Layer""GEX_EDS_sdp_3-h-180")
                  # Add a new layer, the layer name is LAYER .
                  LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_3-h-180")
                  # Set the LAYER  layer as the current layer.
                  acad.ActiveDocument.ActiveLayer = LayerObj
              
              if (acad.ActiveDocument.ActiveLayer == acad.ActiveDocument.Layers.Item(layers_names.index("GEX_EDS_sdp_5-pk" ))):
                 print("index is ....", layers_names.index("GEX_EDS_sdp_5-pk" ) )
              else:
                  print("Create Layer""GEX_EDS_sdp_5-pk")
                  # Add a new layer, the layer name is LAYER .
                  LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_5-pk")
                  # Set the LAYER  layer as the current layer.
                  acad.ActiveDocument.ActiveLayer = LayerObj

              if (acad.ActiveDocument.ActiveLayer == acad.ActiveDocument.Layers.Item(layers_names.index("GEX_EDS_sdp_5-pk" ))):
                 print("index is ....", layers_names.index("GEX_EDS_sdp_6-combles" ) )
              else:
                  print("Create Layer""GEX_EDS_sdp_6-combles")
                  # Add a new layer, the layer name is LAYER .
                  LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_6-combles")
                  # Set the LAYER  layer as the current layer.
                  acad.ActiveDocument.ActiveLayer = LayerObj

              if (acad.ActiveDocument.ActiveLayer == acad.ActiveDocument.Layers.Item(layers_names.index("GEX_EDS_sdp_7-lt" ))):
                 print("index is ....", layers_names.index("GEX_EDS_sdp_7-lt" ) )
              else:
                  print("Create Layer""GEX_EDS_sdp_7-lt")
                  # Add a new layer, the layer name is LAYER .
                  LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_7-lt")
                  # Set the LAYER  layer as the current layer.
                  acad.ActiveDocument.ActiveLayer = LayerObj

              if (acad.ActiveDocument.ActiveLayer == acad.ActiveDocument.Layers.Item(layers_names.index("GEX_EDS_sdp_8-cave" ))):
                 print("index is ....", layers_names.index("GEX_EDS_sdp_8-cave" ) )
              else:
                  print("Create Layer""GEX_EDS_sdp_8-cave")
                  # Add a new layer, the layer name is LAYER .
                  LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_8-cave")
                  # Set the LAYER  layer as the current layer.
                  acad.ActiveDocument.ActiveLayer = LayerObj

              if (acad.ActiveDocument.ActiveLayer == acad.ActiveDocument.Layers.Item(layers_names.index("GEX_EDS_sdp_teinte_contour" ))):
                 print("index is ....", layers_names.index("GEX_EDS_sdp_teinte_contour" ) )
              else:
                  print("Create Layer""GEX_EDS_sdp_teinte_contour")
                  # Add a new layer, the layer name is LAYER .
                  LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_teinte_contour")
                  # Set the LAYER  layer as the current layer.
                  acad.ActiveDocument.ActiveLayer = LayerObj

              if (acad.ActiveDocument.ActiveLayer == acad.ActiveDocument.Layers.Item(layers_names.index("GEX_EDS_sdp_SDP_su" ))):
                 print("index is ....", layers_names.index("GEX_EDS_sdp_SDP_su" ) )
              else:
                  print("Create Layer""GEX_EDS_sdp_SDP_su")
                  # Add a new layer, the layer name is LAYER .
                  LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_SDP_su")
                  # Set the LAYER  layer as the current layer.
                  acad.ActiveDocument.ActiveLayer = LayerObj

              if (acad.ActiveDocument.ActiveLayer == acad.ActiveDocument.Layers.Item(layers_names.index("GEX_EDS_sdp_2-tremie_su" ))):
                 print("index is ....", layers_names.index("GEX_EDS_sdp_2-tremie_su" ) )
              else:
                  print("Create Layer""GEX_EDS_sdp_2-tremie_su")
                  # Add a new layer, the layer name is LAYER .
                  LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_2-tremie_su")
                  # Set the LAYER  layer as the current layer.
                  acad.ActiveDocument.ActiveLayer = LayerObj

              if (acad.ActiveDocument.ActiveLayer == acad.ActiveDocument.Layers.Item(layers_names.index("GEX_EDS_sdp_3-h-180_su" ))):
                 print("index is ....", layers_names.index("GEX_EDS_sdp_3-h-180_su" ) )
              else:
                  print("Create Layer""GEX_EDS_sdp_3-h-180_su")
                  # Add a new layer, the layer name is LAYER .
                  LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_3-h-180_su")
                  # Set the LAYER  layer as the current layer.
                  acad.ActiveDocument.ActiveLayer = LayerObj

              if (acad.ActiveDocument.ActiveLayer == acad.ActiveDocument.Layers.Item(layers_names.index("GEX_EDS_sdp_5-pk_su" ))):
                 print("index is ....", layers_names.index("GEX_EDS_sdp_5-pk_su" ) )
              else:
                  print("Create Layer""GEX_EDS_sdp_5-pk_su")
                  # Add a new layer, the layer name is LAYER .
                  LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_5-pk_su")
                  # Set the LAYER  layer as the current layer.
                  acad.ActiveDocument.ActiveLayer = LayerObj

              if (acad.ActiveDocument.ActiveLayer == acad.ActiveDocument.Layers.Item(layers_names.index("GEX_EDS_sdp_6-combles_su" ))):
                 print("index is ....", layers_names.index("GEX_EDS_sdp_6-combles_su" ) )
              else:
                  print("Create Layer""GEX_EDS_sdp_6-combles_su")
                  # Add a new layer, the layer name is LAYER .
                  LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_6-combles_su")
                  # Set the LAYER  layer as the current layer.
                  acad.ActiveDocument.ActiveLayer = LayerObj

              if (acad.ActiveDocument.ActiveLayer == acad.ActiveDocument.Layers.Item(layers_names.index("GEX_EDS_sdp_7-lt_su" ))):
                 print("index is ....", layers_names.index("GEX_EDS_sdp_7-lt_su" ) )
              else:
                  print("Create Layer""GEX_EDS_sdp_7-lt_su")
                  # Add a new layer, the layer name is LAYER .
                  LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_7-lt_su")
                  # Set the LAYER  layer as the current layer.
                  acad.ActiveDocument.ActiveLayer = LayerObj

              if (acad.ActiveDocument.ActiveLayer == acad.ActiveDocument.Layers.Item(layers_names.index("GEX_EDS_sdp_8-cave_su" ))):
                 print("index is ....", layers_names.index("GEX_EDS_sdp_8-cave_su" ) )
              else:
                  print("Create Layer""GEX_EDS_sdp_8-cave_su")
                  # Add a new layer, the layer name is LAYER .
                  LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_8-cave_su")
                  # Set the LAYER  layer as the current layer.
                  acad.ActiveDocument.ActiveLayer = LayerObj


        def if__calque__exist():

           layers_nums = acad.ActiveDocument.Layers.count 
           layers_names = [acad.ActiveDocument.Layers.Item(i).Name for i in range(layers_nums)] 
         
           #_________Tester calque "GEX_EDS_sdp_2-tremie"__________
           if layers_names == ['GEX_EDS_sdp_2-tremie']:
             print("Calque exist")
             
           else :
             print("Create Layer""GEX_EDS_sdp_2-tremie")
            # Add a new layer, the layer name is LAYER .
             LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_2-tremie")
            # Set the LAYER  layer as the current layer.
             acad.ActiveDocument.ActiveLayer = LayerObj
             
             #Clr.SetRGB(255,0,0)
            # LayerObj.TrueColor = Clr

          #_________Tester calque "GEX_EDS_sdp_3-h-180"__________
           if layers_names == ['GEX_EDS_sdp_3-h-180']:
             print("Calque exist")
             
           else :
             print("Create Layer""GEX_EDS_sdp_3-h-180")
            # Add a new layer, the layer name is LAYER .
             LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_3-h-180")
            # Set the LAYER  layer as the current layer.
             acad.ActiveDocument.ActiveLayer = LayerObj
             

           #_________Tester calque "GEX_EDS_sdp_5-pk"__________
           if layers_names == ['GEX_EDS_sdp_5-pk']:
             print("Calque exist")
             
           else :
             print("Create Layer""GEX_EDS_sdp_5-pk")
            # Add a new layer, the layer name is LAYER .
             LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_5-pk")
            # Set the LAYER  layer as the current layer.
             acad.ActiveDocument.ActiveLayer = LayerObj
            
             #_________Tester calque "GEX_EDS_sdp_6-combles"__________
           if layers_names == ['GEX_EDS_sdp_6-combles']:
             print("Calque exist")
             
           else :
             print("Create Layer""GEX_EDS_sdp_6-combles")
            # Add a new layer, the layer name is LAYER .
             LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_6-combles")
            # Set the LAYER  layer as the current layer.
             acad.ActiveDocument.ActiveLayer = LayerObj
            

             #_________Tester calque "GEX_EDS_sdp_7-lt"__________
           if layers_names == ['GEX_EDS_sdp_7-lt']:
             print("Calque exist")
             
           else :
             print("Create Layer""GEX_EDS_sdp_7-lt")
            # Add a new layer, the layer name is LAYER .
             LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_7-lt")
            # Set the LAYER  layer as the current layer.
             acad.ActiveDocument.ActiveLayer = LayerObj
            

               #_________Tester calque "GEX_EDS_sdp_8-cave"__________
           if layers_names == ['GEX_EDS_sdp_8-cave']:
             print("Calque exist")
             
           else :
             print("Create Layer""GEX_EDS_sdp_8-cave")
            # Add a new layer, the layer name is LAYER .
             LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_8-cave")
            # Set the LAYER  layer as the current layer.
             acad.ActiveDocument.ActiveLayer = LayerObj
            

               #_________Tester calque"GEX_EDS_sdp_teinte_contour"__________
           if layers_names == ['GEX_EDS_sdp_teinte_contour']:
             print("Calque exist")
             
           else :
             print("Create Layer""GEX_EDS_sdp_teinte_contour")
            # Add a new layer, the layer name is "GEX_EDS_sdp_teinte_contour".
             LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_teinte_contour")
            # Set the LAYER  layer as the current layer.
             acad.ActiveDocument.ActiveLayer = LayerObj
            

               #_________Tester calque "GEX_EDS_sdp_SDP_su"__________
           if layers_names == ['GEX_EDS_sdp_SDP_su']:
             print("Calque exist")
             
           else :
             print("Create Layer""GEX_EDS_sdp_SDP_su")
            # Add a new layer, the layer name is "GEX_EDS_sdp_SDP_su".
             LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_SDP_su")
            # Set the LAYER  layer as the current layer.
             acad.ActiveDocument.ActiveLayer = LayerObj
            

               #_________Tester calque "GEX_EDS_sdp_2-tremie_su"__________
           if layers_names == ['GEX_EDS_sdp_2-tremie_su']:
             print("Calque exist")
             
           else :
             print("Create Layer""GEX_EDS_sdp_2-tremie_su")
            # Add a new layer, the layer name is LAYER .
             LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_2-tremie_su")
            # Set the LAYER  layer as the current layer.
             acad.ActiveDocument.ActiveLayer = LayerObj
             

               #_________Tester calque "GEX_EDS_sdp_3-h-180_su"__________
           if layers_names == ['GEX_EDS_sdp_3-h-180_su']:
             print("Calque exist")
             
           else :
             print("Create Layer""GEX_EDS_sdp_3-h-180_su")
            # Add a new layer, the layer name is "GEX_EDS_sdp_3-h-180_su".
             LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_3-h-180_su")
            # Set the LAYER  layer as the current layer.
             acad.ActiveDocument.ActiveLayer = LayerObj
            

               #_________Tester calque "GEX_EDS_sdp_5-pk_su"__________
           if layers_names == ['GEX_EDS_sdp_5-pk_su']:
             print("Calque exist")
             
           else :
             print("Create Layer""GEX_EDS_sdp_5-pk_su")
            # Add a new layer, the layer name is LAYER .
             LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_5-pk_su")
            # Set the LAYER  layer as the current layer.
             acad.ActiveDocument.ActiveLayer = LayerObj
             

               #_________Tester calque "GEX_EDS_sdp_6-combles_su"__________
           if layers_names == ['GEX_EDS_sdp_6-combles_su']:
             print("Calque exist")
             
           else :
             print("Create Layer""GEX_EDS_sdp_6-combles_su")
            # Add a new layer, the layer name is "GEX_EDS_sdp_6-combles_su".
             LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_6-combles_su")
            # Set the LAYER  layer as the current layer.
             acad.ActiveDocument.ActiveLayer = LayerObj
             

               #_________Tester calque "GEX_EDS_sdp_7-lt_su"__________
           if layers_names == ['GEX_EDS_sdp_7-lt_su']:
             print("Calque exist")
             
           else :
             print("Create Layer""GEX_EDS_sdp_7-lt_su")
            # Add a new layer, the layer name is "GEX_EDS_sdp_7-lt_su".
            
             #acad.ActiveDocument.SendCommand('._-layer n GEX_EDS_sdp_2-tremie CO U 255,255,127 GEX_EDS_sdp_2-tremie ' '\n')
          
             LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_7-lt_su")
            # Set the LAYER  layer as the current layer.
             acad.ActiveDocument.ActiveLayer = LayerObj

             
               #_________Tester calque "GEX_EDS_sdp_8-cave_su"__________
           if layers_names == ['GEX_EDS_sdp_8-cave_su']:
             print("Calque exist")
             
           else :
             print("Create Layer ""GEX_EDS_sdp_8-cave_su")
            # Add a new layer, the layer name is "GEX_EDS_sdp_8-cave_su".
             LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_sdp_8-cave_su")
            # Set the LAYER  layer as the current layer.
             acad.ActiveDocument.ActiveLayer = LayerObj

             ##___________________________style__________________________
             acad.TextStyleName = "SURF"


        #_________________________________________________________________________
        #_________________________________________________________________________
        #_________________________________________________________________________

        

        #_________________________Surfaces  Planchers avant déductions____________ 
        
        def surface_plancher_ded():
         
              get__layer_teinte_contour = acad.ActiveDocument.SendCommand('.-layer E "0" g * l GEX_EDS_sdp_teinte_contour l GEX_EDS_sdp_SDP_su \n ' ) 
                # for i in element:
                    #get__calque_0 = acad.ActiveDocument.SendCommand("_-calque" "chr(0) ") 
                    #get__calque_l = acad.ActiveDocument.SendCommand("_-calque" "l(element) " )  
              for element in layers_names:
                  acad.ActiveDocument.SendCommand('-CALQUE chr(0)')
                  acad.ActiveDocument.SendCommand('-CALQUE l element ')
                  print("_Surfaces  Planchers avant déductions est : ", get__layer_teinte_contour)
                  sel = acad.ActiveDocument.SendCommand("(SSGET\"_X\"'((-4 . \"<OR\")(-4 . \"<AND\")(0 . \"*LWPOLYLINE\")(8 . \"element\")(-4 . \"AND>\")(0 . \"CIRCLE\")(8 . \"element\")(-4 . \"AND>\")(-4 . \"OR>\"))) ")
                  
                  acad.ActiveDocument.SendCommand('._HACHURES p s a s n a o i o h o ' '\n')
                  acad.ActiveDocument.SendCommand('._CLAYER GEX_EDS_sdp_teinte_contour ' '\n')
                  acad.ActiveDocument.SendCommand('._HACHURES s sel ' )
                  acad.ActiveDocument.SendCommand('._CLAYER GEX_EDS_sdp_SDP_su ' '\n')
              


        #_________________________    Surfaces Vides    _____________________ 
        def surface_vides():
              get__layer_teinte_contour = acad.ActiveDocument.SendCommand('._-layer E 0 g * l GEX_EDS_sdp_2-tremie l GEX_EDS_sdp_2-tremie_su ' ) 
              print("_Surfaces  Planchers avant déductions est : ", get__layer_teinte_contour)
              acad.ActiveDocument.SendCommand('._HACHURES p s a s n a o i o h o ' '\n')
              acad.ActiveDocument.SendCommand('._CLAYER GEX_EDS_sdp_teinte_contour ' '\n')
              acad.ActiveDocument.SendCommand('._HACHURES s sel ' )
              acad.ActiveDocument.SendCommand('._CLAYER GEX_EDS_sdp_SDP_su ' '\n')
              
        #__________________________    Surfaces dont h < 1.80 m   _ _____________________ 
        def surface_h_180():
              get__layer_teinte_contour = acad.ActiveDocument.SendCommand('._-layer E 0 g * l GEX_EDS_sdp_2-tremie l GEX_EDS_sdp_2-tremie_su ' ) 
              print("_Surfaces  Planchers avant déductions est : ", get__layer_teinte_contour)
              acad.ActiveDocument.SendCommand('._HACHURES p s a s n a o i o h o ' '\n')
              acad.ActiveDocument.SendCommand('._CLAYER GEX_EDS_sdp_teinte_contour ' '\n')
              acad.ActiveDocument.SendCommand('._HACHURES s sel ' )
              acad.ActiveDocument.SendCommand('._CLAYER GEX_EDS_sdp_SDP_su ' '\n')
        #__________________________    Surfaces Stationnement    ________________________
        def surface_Stationnement():
              get__layer_teinte_contour = acad.ActiveDocument.SendCommand('._-layer E 0 g * l GEX_EDS_sdp_2-tremie l GEX_EDS_sdp_2-tremie_su ' ) 
              print("_Surfaces  Planchers avant déductions est : ", get__layer_teinte_contour)
              acad.ActiveDocument.SendCommand('._HACHURES p s a s n a o i o h o ' '\n')
              acad.ActiveDocument.SendCommand('._CLAYER GEX_EDS_sdp_teinte_contour ' '\n')
              acad.ActiveDocument.SendCommand('._HACHURES s sel ' )
              acad.ActiveDocument.SendCommand('._CLAYER GEX_EDS_sdp_SDP_su ' '\n') 
        #_______________________________    Surfaces Combles    _________________________
        def surface_Combles():
              get__layer_teinte_contour = acad.ActiveDocument.SendCommand('._-layer E 0 g * l GEX_EDS_sdp_2-tremie l GEX_EDS_sdp_2-tremie_su ' ) 
              print("_Surfaces  Planchers avant déductions est : ", get__layer_teinte_contour)
              acad.ActiveDocument.SendCommand('._HACHURES p s a s n a o i o h o ' '\n')
              acad.ActiveDocument.SendCommand('._CLAYER GEX_EDS_sdp_teinte_contour ' '\n')
              acad.ActiveDocument.SendCommand('._HACHURES s sel ' )
              acad.ActiveDocument.SendCommand('._CLAYER GEX_EDS_sdp_SDP_su ' '\n')  
        
        #_________________________    Surfaces Locaux techniques    _____________________ 
        def surface_Locaux_techniques():
              get__layer_teinte_contour = acad.ActiveDocument.SendCommand('._-layer E 0 g * l GEX_EDS_sdp_2-tremie l GEX_EDS_sdp_2-tremie_su ' ) 
              print("_Surfaces  Planchers avant déductions est : ", get__layer_teinte_contour)
              acad.ActiveDocument.SendCommand('._HACHURES p s a s n a o i o h o ' '\n')
              acad.ActiveDocument.SendCommand('._CLAYER GEX_EDS_sdp_teinte_contour ' '\n')
              acad.ActiveDocument.SendCommand('._HACHURES s sel ' )
              acad.ActiveDocument.SendCommand('._CLAYER GEX_EDS_sdp_SDP_su ' '\n')
        #_____________________________    Surfaces Caves    ______________________________ 
        def surface_Caves():
              get__layer_teinte_contour = acad.ActiveDocument.SendCommand('._-layer E 0 g * l GEX_EDS_sdp_2-tremie l GEX_EDS_sdp_2-tremie_su ' ) 
              print("_Surfaces  Planchers avant déductions est : ", get__layer_teinte_contour)
              acad.ActiveDocument.SendCommand('._HACHURES p s a s n a o i o h o ' '\n')
              acad.ActiveDocument.SendCommand('._CLAYER GEX_EDS_sdp_teinte_contour ' '\n')
              acad.ActiveDocument.SendCommand('._HACHURES s sel ' )
              acad.ActiveDocument.SendCommand('._CLAYER GEX_EDS_sdp_SDP_su ' '\n')

        #_________________________Apres la calcul des différentes surfaces________________
        def Total_surface():
            surface_plancher_ded()
            surface_vides()
            surface_h_180()
            surface_Stationnement()
            surface_Combles()
            surface_Locaux_techniques()
            surface_Caves()
            acad.ActiveDocument.SendCommand('._-layer l * E 0 g GEX_EDS_sdp_teinte_contour ''\n')

            def getCalqueAppliqueApplatSDP():
                print(calqueC)
                sel1 = [(0,"HATCH"), (8, calqueC)] 
                acad.ActiveDocument.SendCommand('_draworder p _back')
                #les variables de calcul
                ind = 0
                surftotal = 0
                surfad = 0
                somme = 0
               # if (sel1 != 0):
                  #while ind in range(sel1):
                    #s1 = nm[1: ]
                   # entite  =  nm[]


            def SDT():
              #================Ajouter meme style surf  que charte graphique ================
               acad.TextStyleName = ("Standard" "SURF")
               total_val_text_SP = getDesignationEtAfficheValeursdp("GEX_EDS_sdp_SDP_su", "SP")
               total_val_text_V =  getDesignationEtAfficheValeursdp("GEX_EDS_sdp_2-tremie_su", "V")
               total_val_text_180 = getDesignationEtAfficheValeursdp("GEX_EDS_sdp_5-PK_su","ST")
               total_val_text_TA  = int("{:.2f}".total_val_text_SP)-int("{:.2f}".total_val_text_V)-int("{:.2f}".total_val_text_180)
               total_val_text_TA  = "{:.2f}".total_val_text_TA
               acad.SendCommand('_attendit N N SDP TA 0 0 ', total_val_text_TA)

               total_val_text_ST = getDesignationEtAfficheValeursdp("GEX_EDS_sdp_5-PK_su" ,"ST")
               total_val_text_CO = getDesignationEtAfficheValeursdp("GEX_EDS_sdp_6-combles_su", "CO")
               total_val_text_LT = getDesignationEtAfficheValeursdp("GEX_EDS_sdp_7-LT_su" ,"LT")
               total_val_text_c = getDesignationEtAfficheValeursdp("GEX_EDS_sdp_8-cave_su" ,"C")
               choix = acad.ActiveDocument.SendCommand('_getkword \n Type du batiment (Locaux (L), Habitation(H), Mixte (M)): <Locaux> ')
               if (choix == "M"):
                total_val_text_i  =  int(acad.ActiveDocument.SendCommand(''))*0.10
               elif (choix == "H"):
                total_val_text_i  =  (total_val_text_TA-(total_val_text_LT + total_val_text_c + total_val_text_CO + total_val_text_ST))*0.10
               elif(choix == "L"):
                total_val_text_i= 0.0
               else:
                 choix == "L"
               acad.ActiveDocument.SendCommand('_attendit N N SDP ISOL 0 0')
               print('valeur d''isolation is', int(total_val_text_i) )

            def getDesignationEtAfficheValeursdp(calqueC , texte):
              ind = 0 
              total_val = 0 
              total = 0
              sel_SP = [[8 , calqueC],[0, "TEXT"]]
              #if (sel_SP != None):
                #while(sel_SP):
                  #val_text_SP = nm[1:]
              acad.ActiveDocument.SendCommand('-attedit N N SDP texte 0 0', int(total_val))


            def sd0(): #  vider la table de la charte graphique
               acad.ActiveDocument.SendCommand('._-attedit N N SDP SP ')
               acad.ActiveDocument.SendCommand('_regen ')
               acad.ActiveDocument.SendCommand('._-attedit N N SDP V ')
               acad.ActiveDocument.SendCommand('_regen ')
               acad.ActiveDocument.SendCommand('._-attedit N N SDP 180 ')
               acad.ActiveDocument.SendCommand('_regen ')
               acad.ActiveDocument.SendCommand('._-attedit N N SDP TA ')
               acad.ActiveDocument.SendCommand('_regen ')
               acad.ActiveDocument.SendCommand('._-attedit N N SDP ST ')
               acad.ActiveDocument.SendCommand('_regen ')
               acad.ActiveDocument.SendCommand('._-attedit N N SDP CO ')
               acad.ActiveDocument.SendCommand('_regen ')
               acad.ActiveDocument.SendCommand('._-attedit N N SDP LT ')
               acad.ActiveDocument.SendCommand('_regen ')
               acad.ActiveDocument.SendCommand('._-attedit N N SDP C ')
               acad.ActiveDocument.SendCommand('_regen ')
               acad.ActiveDocument.SendCommand('._-attedit N N SDP ISOL ')
               acad.ActiveDocument.SendCommand('_regen ')
               acad.ActiveDocument.SendCommand('._-attedit N N SDP SDP ')
               acad.ActiveDocument.SendCommand('_regen ')

			      


             
             
        
        
             


             
        
        
        #Affiche__layer()
        layers_nums = acad.ActiveDocument.Layers.count 
        layers_names = [acad.ActiveDocument.Layers.Item(i).Name for i in range(layers_nums)] 

        iterated_index_list = iterated_index(layers_names, "GEX_EDS_sdp_2-tremie")
        iterated_index_list = iterated_index(layers_names, "GEX_EDS_sdp_3-h-180")
        iterated_index_list = iterated_index(layers_names, "GEX_EDS_sdp_5-pk")
        iterated_index_list = iterated_index(layers_names, "GEX_EDS_sdp_6-combles")
        iterated_index_list = iterated_index(layers_names, "GEX_EDS_sdp_7-lt")
        iterated_index_list = iterated_index(layers_names, "GEX_EDS_sdp_8-cave")
        iterated_index_list = iterated_index(layers_names, "GEX_EDS_sdp_teinte_contour")
        iterated_index_list = iterated_index(layers_names, "GEX_EDS_sdp_SDP_su")
        iterated_index_list = iterated_index(layers_names, "GEX_EDS_sdp_2-tremie_su")
        iterated_index_list = iterated_index(layers_names, "GEX_EDS_sdp_3-h-180_su")
        iterated_index_list = iterated_index(layers_names, "GEX_EDS_sdp_5-pk_su")
        iterated_index_list = iterated_index(layers_names, "GEX_EDS_sdp_6-combles_su")
        iterated_index_list = iterated_index(layers_names, "GEX_EDS_sdp_7-lt_su")
        iterated_index_list = iterated_index(layers_names, "GEX_EDS_sdp_8-cave_su")
    

        print(iterated_index_list,"test___list")
        print(layers_names)
       
        #iterated_index_layer()
        #if__calque__exist()
        layers_nums = acad.ActiveDocument.Layers.count  
        print(layers_nums)
        surface_plancher_ded()
        ##__________Lancer commande SDP______________
       # test = acad.ActiveDocument.SendCommand("_sdp ")
       # print('test SDP est vrai')
        
   
if __name__ == '__main__':
    sdp()
 