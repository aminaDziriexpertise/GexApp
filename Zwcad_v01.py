import string
from pyzwcad import ZwCAD, APoint
import array
import comtypes
import matplotlib as mpl
import matplotlib.pyplot as plt
from random import random
import numpy as np
import json
import requests
from scrapping_odoo import ID,nom_livrable,Nom__du__client,address,Cree__par,Cree__le

def main():
     acad = ZwCAD()
     print("Model", acad.model ) 
     print("ModelSpace", acad.doc.ModelSpace)
     print("Document", acad.ActiveDocument) 
     print ('Current', acad.doc.Name)


     #  _________Lancer COMMANDE pour passer vers une autre presentation_________
     command_str = 'aller sur : M2XX_E0_(SDP) '
     print (command_str)
     acad.doc.SendCommand(command_str)


     #  ________________Open the dwg file______________
     directory_name = "C:\\Program Files\\Autodesk\\AutoCAD 2018\\HELP" #replace it with a real path, use "\\" as directory delimiters. 
     temp=""
     for char in directory_name:
        if char == "\\":
          temp += "/"
        else:
          temp += char
     directory_name = temp
     filename = directory_name + "/SDP_SHO_Gabarit.dwg"
 
     #  ________________________ Add TEXT ___________________________
   
     acad.prompt("Extraire  data de Type TXT from Python\n")
     #resp = requests.get('http://127.0.0.1:5000/address')
     #txt = resp.content
     #print(txt)


     
     api_url = 'http://127.0.0.1:5000'
     r = requests.post(url=api_url)
     print(r.status_code)
     print(r.reason)
     print(r.text)



     def plotLivrable():
      p= APoint(1653934.9114,8210383.9801,0.00)
      p = acad.model.AddText(nom_livrable, p, 1.2)
      p.Color = 0
      return p 




     def plotAddress( ):
        p1 = APoint(1653944.4373,8210377.9012 ,0.000)
        #p2 = APoint(36.1251,22.6860 ,0)
        p = acad.model.AddText(address, p1, 1.3)
        p.Color = 0
        #return p


     def plotNote():
      p0 = APoint(1653939.2848,8210324.0597 ,0.000)
      p1 = APoint(1653939.6737,8210321.3752 ,0.000)
      p2 =APoint(1653939.9631,8210317.9016,0.000)
      p0 = acad.model.AddText("Note: ", p0,1.0)
      p0.Color = 0
      p = acad.model.AddText("Calcul réalisé à partir des relevés effectués en"+Cree__le+"par GEXPERTISE CONSEIL ",p1,0.68)
      p.Color = 0
      p1 = acad.model.AddText( "les affectations des locaux  correspondent aux occupations apparentes le jour du mesurage.",p2,0.68)
      p1.Color = 0
      return p 
  

     def plotDate_RESP():
        p1 = APoint(1653953.3782,8210308.7335 ,0.000)
        p = acad.model.AddText("Date :"+Cree__le +"- Resp :" +Cree__par, p1, 0.6)
        p.Color = 0
        return p 

     def plotID():
        p1 = APoint()
        p = acad.model.AddText(ID)
        return(p)


   #  ________________________EXTRACT all TEXT _______________________________
     for text in acad.iter_objects('Text'): # extraire data de type text
        # print('text: %s at: %s' % (text.TextString, text.InsertionPoint))
         text.InsertionPoint = APoint(text.InsertionPoint) 

   #  ________________________PLOT_____________________________________________
     #p = plot( )     
   
   
     #acad.app.ZoomExtents()
     plotLivrable()
     plotAddress()
     plotDate_RESP()
     plotNote()

     print ("DONE" )




if __name__ == "__main__":
   main()