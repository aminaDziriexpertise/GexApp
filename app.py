from this import d
import requests
import json
from scrapping_odoo import nom_livrable,Nom__du__client,address,Cree__par,Cree__le
from flask import Flask,jsonify,request,make_response,url_for,redirect
import requests, json
from scrapping_odoo import return_data



url = 'http://127.0.0.1:5000'
app = Flask(__name__)
app.config["DEBUG"] = True


#def return_data():
    #result=(nom_livrable,Nom__du__client,address,Cree__par,Cree__le)
    #return result

@app.route('/get', methods=['GET','POST'])
def get_nom_livrable():
    #result=request.args.get(nom_livrable,Nom__du__client)
    return (nom_livrable)


@app.route('/client', methods=['GET','POST'])
def get_Nom__du__client():
    #result=request.args.get(nom_livrable,Nom__du__client)
    return ( Nom__du__client)

@app.route('/address', methods=['GET','POST'])
def get_address():
    #result=request.args.get(nom_livrable,Nom__du__client)
    return (address)

@app.route('/Cree__par', methods=['GET','POST'])
def get_Cree__par():
    #result=request.args.get(nom_livrable,Nom__du__client)
    return (Cree__par)

@app.route('/Cree__le', methods=['GET','POST'])   
def get_Cree__le():
    #result=request.args.get(nom_livrable,Nom__du__client)
    return ( Cree__le)





@app.route('/', methods=['GET','POST'])
def resultat():
        return  '{} {} {} {} {}'.format(nom_livrable, address, Nom__du__client,Cree__par,Cree__le)

#def parse_request():
 #     nom_livrable = request.args.get('nom_livrable')
  #    print(nom_livrable)
   #   address= request.args.get('address')
   #   print(address)
    #  Nom__du__client= request.args.get('Nom__du__client')
     # print(Nom__du__client)
     # Cree__par= request.args.get('Cree__par')
      #print(Cree__par)
      #Cree__le= request.args.get('Cree__le')
      #print(Cree__le)
    

    
@app.route('/sendData', methods=['GET','POST'])
def resultat2():
    if request.method == 'GET':
           return make_response('failure')
    if request.method == 'POST':
        nom_livrable = request.json['nom_livrable']
        address = request.json['address']
        Nom__du__client = request.json['Nom__du__client']
        Cree__par = request.json['Cree__par']
        Cree__le = request.json['Cree__le']

    response = requests.post(
            url, data=json.dumps( ),
            headers={'Content-Type': 'application/json'}
        )
    return response.content


if __name__ == "__main__":
    app.run()
  
   