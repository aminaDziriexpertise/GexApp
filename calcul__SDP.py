
#Import needed modules
import os
from re import T
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
                layers_nums = acad.ActiveDocument.Layers.count   #  {{{acad.doc.Layers.count}}} are the same 
                # The total number of layers contained in the current file model space
                layers_names = [acad.ActiveDocument.Layers.Item(i).Name for i in range(layers_nums)] #layers_names = str(acad.doc.Layers.Item(i).Name)
                print('layer_names are: ...', layers_names)
                # index = layers_names.index("GEX_EDS___Amina_Layer" ) 
                # acad.ActiveDocument.ActiveLayer = acad.ActiveDocument.Layers.Item(index)
                # print("index is ....",index)

        
        #def iterated_index(layers_names, calques):
        def iterated_index(layers_names, element):

              iterated_index_list = []
             
              for i in range(len(layers_names)):
                   if layers_names[i] == element:
                      iterated_index_list.append(i)
                   else:
                      LayerObj = acad.ActiveDocument.Layers.Add("GEX_EDS_testttt")
                      acad.ActiveDocument.ActiveLayer = LayerObj
              return iterated_index_list
        layers_nums = acad.ActiveDocument.Layers.count 
        layers_names = [acad.ActiveDocument.Layers.Item(i).Name for i in range(layers_nums)] 
        #iterated_index_list = iterated_index(layers_names, "GEX_EDS_testttt")
        #print(iterated_index_list,"test___list")
       

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



        #_________________________Surfaces  Planchers avant déductions____________ 
        def surface_plancher_ded():
              get__layer_teinte_contour = acad.ActiveDocument.SendCommand('._-layer E 0 g * l GEX_EDS_sdp_teinte_contour l GEX_EDS_sdp_SDP_su ' ) 
                # for i in element:
                    #get__calque_0 = acad.ActiveDocument.SendCommand("_-calque" "chr(0) ") 
                    #get__calque_l = acad.ActiveDocument.SendCommand("_-calque" "l(element) " )  
             
              print("_Surfaces  Planchers avant déductions est : ", get__layer_teinte_contour)
              acad.ActiveDocument.SendCommand('._-hachures p s a s n a o i o h o ' '\n')
              acad.ActiveDocument.SendCommand('._clayer GEX_EDS_sdp_teinte_contour ' '\n')
              acad.ActiveDocument.SendCommand('._-hachures s sel ' )
              acad.ActiveDocument.SendCommand('._clayer GEX_EDS_sdp_SDP_su ' '\n')
              


        #_________________________    Surfaces Vides    _____________________ 
        def surface_vides():
              get__layer_teinte_contour = acad.ActiveDocument.SendCommand('._-layer E 0 g * l GEX_EDS_sdp_2-tremie l GEX_EDS_sdp_2-tremie_su ' ) 
              print("_Surfaces  Planchers avant déductions est : ", get__layer_teinte_contour)
              acad.ActiveDocument.SendCommand('._-hachures p s a s n a o i o h o ' '\n')
              acad.ActiveDocument.SendCommand('._clayer GEX_EDS_sdp_teinte_contour ' '\n')
              acad.ActiveDocument.SendCommand('._-hachures s sel ' )
              acad.ActiveDocument.SendCommand('._clayer GEX_EDS_sdp_SDP_su ' '\n')
              
        #__________________________    Surfaces dont h < 1.80 m   _ _____________________ 
        def surface_h_180():
              get__layer_teinte_contour = acad.ActiveDocument.SendCommand('._-layer E 0 g * l GEX_EDS_sdp_2-tremie l GEX_EDS_sdp_2-tremie_su ' ) 
              print("_Surfaces  Planchers avant déductions est : ", get__layer_teinte_contour)
              acad.ActiveDocument.SendCommand('._-hachures p s a s n a o i o h o ' '\n')
              acad.ActiveDocument.SendCommand('._clayer GEX_EDS_sdp_teinte_contour ' '\n')
              acad.ActiveDocument.SendCommand('._-hachures s sel ' )
              acad.ActiveDocument.SendCommand('._clayer GEX_EDS_sdp_SDP_su ' '\n')
        #__________________________    Surfaces Stationnement    ________________________
        def surface_Stationnement():
              get__layer_teinte_contour = acad.ActiveDocument.SendCommand('._-layer E 0 g * l GEX_EDS_sdp_2-tremie l GEX_EDS_sdp_2-tremie_su ' ) 
              print("_Surfaces  Planchers avant déductions est : ", get__layer_teinte_contour)
              acad.ActiveDocument.SendCommand('._-hachures p s a s n a o i o h o ' '\n')
              acad.ActiveDocument.SendCommand('._clayer GEX_EDS_sdp_teinte_contour ' '\n')
              acad.ActiveDocument.SendCommand('._-hachures s sel ' )
              acad.ActiveDocument.SendCommand('._clayer GEX_EDS_sdp_SDP_su ' '\n') 
        #_______________________________    Surfaces Combles    _________________________
        def surface_Combles():
              get__layer_teinte_contour = acad.ActiveDocument.SendCommand('._-layer E 0 g * l GEX_EDS_sdp_2-tremie l GEX_EDS_sdp_2-tremie_su ' ) 
              print("_Surfaces  Planchers avant déductions est : ", get__layer_teinte_contour)
              acad.ActiveDocument.SendCommand('._-hachures p s a s n a o i o h o ' '\n')
              acad.ActiveDocument.SendCommand('._clayer GEX_EDS_sdp_teinte_contour ' '\n')
              acad.ActiveDocument.SendCommand('._-hachures s sel ' )
              acad.ActiveDocument.SendCommand('._clayer GEX_EDS_sdp_SDP_su ' '\n')  
        
        #_________________________    Surfaces Locaux techniques    _____________________ 
        def surface_Locaux_techniques():
              get__layer_teinte_contour = acad.ActiveDocument.SendCommand('._-layer E 0 g * l GEX_EDS_sdp_2-tremie l GEX_EDS_sdp_2-tremie_su ' ) 
              print("_Surfaces  Planchers avant déductions est : ", get__layer_teinte_contour)
              acad.ActiveDocument.SendCommand('._-hachures p s a s n a o i o h o ' '\n')
              acad.ActiveDocument.SendCommand('._clayer GEX_EDS_sdp_teinte_contour ' '\n')
              acad.ActiveDocument.SendCommand('._-hachures s sel ' )
              acad.ActiveDocument.SendCommand('._clayer GEX_EDS_sdp_SDP_su ' '\n')
        #_____________________________    Surfaces Caves    ______________________________ 
        def surface_Caves():
              get__layer_teinte_contour = acad.ActiveDocument.SendCommand('._-layer E 0 g * l GEX_EDS_sdp_2-tremie l GEX_EDS_sdp_2-tremie_su ' ) 
              print("_Surfaces  Planchers avant déductions est : ", get__layer_teinte_contour)
              acad.ActiveDocument.SendCommand('._-hachures p s a s n a o i o h o ' '\n')
              acad.ActiveDocument.SendCommand('._clayer GEX_EDS_sdp_teinte_contour ' '\n')
              acad.ActiveDocument.SendCommand('._-hachures s sel ' )
              acad.ActiveDocument.SendCommand('._clayer GEX_EDS_sdp_SDP_su ' '\n')

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
                print(' def getCalqueAppliqueApplatSDP():')

			 

             
             
        
        
             


             
        
        
        #Affiche__layer()
        if__calque__exist()
        layers_nums = acad.ActiveDocument.Layers.count  
        print(layers_nums)
        surface_plancher_ded()
        ##__________Lancer commande SDP______________
       # test = acad.ActiveDocument.SendCommand("_sdp ")
       # print('test SDP est vrai')
        
   
if __name__ == '__main__':
    sdp()
 