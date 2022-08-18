#Import needed modules
import os
import comtypes.client
from comtypes import COMError
from comtypes.client import CreateObject, GetModule, GetActiveObject

def main():
    #1- Get the AutoCAD instance
    try:
        acad = comtypes.client.GetActiveObject("AutoCAD.Application")
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
    filename = directory_name + "/SDP_SHO_Gabarit.dwg"
    lispfile = directory_name + "/linedraw.lsp"

    #3- Open the drawing file
    print ("Opening Drawing File ...")
    doc = acad.Documents.Open(filename)
    print ("Drawing is successsfuly Opened")
    print ("########")

    #4- Construct the AutoLISP expression that loads AutoLISP files
    command_str = '(load ' + '"' + lispfile + '")' + " "

    #5-Execute the AutoLISP expression
    print ("Sending AutoLISP Expression ...")
    print ("Expression: " + command_str)
    doc.SendCommand("(setq *LOAD_SECURITY_STATE* (getvar 'SECURELOAD)) ")
    doc.SendCommand("(setvar \"SECURELOAD\" 0) ")
    doc.SendCommand(command_str)
    doc.SendCommand("(setvar \"SECURELOAD\" *LOAD_SECURITY_STATE*) ")
    print ("AutoLISP Expression is successfuly sent")
    print ("########")

    #6- Save and Close the drawing file and AutoCAD application
    doc.Save()
    doc.Close()
    acad.Quit()

    print ("Process Finished")
    print ("__________")

if __name__ == '__main__':
    main()