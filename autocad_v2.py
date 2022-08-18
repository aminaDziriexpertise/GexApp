#Import needed modules
from  pyautocad  import Autocad,APoint
import os
import comtypes.client
from comtypes import COMError
from comtypes.client import CreateObject, GetModule, GetActiveObject
from math import *


def main():

    #1- Get the AutoCAD instance
    try:
        acad = comtypes.client.GetActiveObject("AutoCAD.Application")
        acadModel = acad.ActiveDocument.ModelSpace
        print ("AutoCAD is Active")
        print ("########")
    except(OSError, COMError): #If AutoCAD isn't running, run it
        acad = comtypes.client.CreateObject("AutoCAD.Application")
        #acad = CreateObject("AutoCAD.Application.20",dynamic=True)
        print ("AutoCAD is successfuly Opened")
        print ("########")

    #2- Get the paths to the lisp file and the dwg file
    directory_name = "C:\\Program Files\\Autodesk\\AutoCAD 2018\\HELP" #replace it with a real path, use "\\" as directory delimiters.
    '''
    Note that "\\" is transformed automatically to "\", & in order to comply with
    the AutoLISP "load" function, every "\" must be transformed again to "/".
    '''
    temp=""
    for char in directory_name:
        if char == "\\":
            temp += "/"
        else:
            temp += char
    directory_name = temp
    
    filename = directory_name + "/Test_SDP_E0_03_11-2020.dwg"
    #3- Open the drawing file
    print ("Opening Drawing File ...")
    doc = acad.Documents.Open(filename)
    print(doc.Name)
    print ("Drawing is successsfuly Opened")
    print ("########")
   # mt1 = acadModel.AddMText("This is auotocad text")
   # mt1.Height = 25
   # acad.app.ZoomExtents()

    print ("Process Finished")
    print ("__________")

if __name__ == '__main__':
    main()