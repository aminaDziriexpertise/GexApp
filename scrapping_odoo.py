from time import sleep
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from flask import Flask



driver = webdriver.Firefox()
url = 'https://odoo-r7.gexpertise.fr/web/login'
new_url = 'https://odoo-r7.gexpertise.fr/web?#id=403&model=livrables.actif.client&view_type=form&menu_id=203'
driver.get(url)
username = driver.find_element(By.ID,"login")
password = driver.find_element(By.ID,"password")
username.send_keys("i.benabdallah@gexpertise.fr")
password.send_keys("i$XnRR6H*l8d")
sleep(3)
print("time out")
    # Do some stuff
def getMeG():
      pass # do nothing
    # This is not working 
sleep(3)
page = driver.get(new_url)
    # Do more Stuff
def getMeV():
    pass # do nothing
    # waits for 3 seconds
sleep(3)
#*********************ID*************************
element = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.XPATH, ".//div[3]/div/div/div/div[2]/span[@class='o_field_char o_field_widget o_readonly_modifier o_required_modifier oe_inline']"))
    ) 
ID = element.get_attribute("innerHTML")
print('ID', ID)

#*********************Nom__Livrable*************************
element = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.XPATH, ".//div[3]/div/div/div/div[2]/h1/span[@class='o_field_char o_field_widget o_required_modifier']"))
    )
nom_livrable = element.get_attribute("innerHTML")
print('nom_livrable', nom_livrable)
#***********************Address****************************
element1 = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.XPATH, ".//div[3]/div/div/div/div[2]/div[@class='o_group']/table/tbody/tr/td[2]/a[@class='o_form_uri o_field_widget']"))
        
    )
address= element1.get_attribute("innerHTML")
print('address', address)

#**********************Nom__du__client**********************
element2 = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.XPATH, ".//div[3]/div/div/div/div[2]/div[@class='o_group']/table/tbody/tr/td[2]/a[@class='o_form_uri o_field_widget o_required_modifier']"))
    )
Nom__du__client= element2.get_attribute("innerHTML")
print('Nom__du__client',Nom__du__client)




#**********************Cree__par****************************
element3 = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.XPATH, ".//div[3]/div/div/div/div[2]/table[@class='o_group o_inner_group']/tbody/tr/td[2]/a[@class='o_form_uri o_field_widget o_readonly_modifier']"))
    )
Cree__par= element3.get_attribute("innerHTML")
print('Cree__par',Cree__par)


#**********************Cree__le*****************************
element3 = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.XPATH, ".//div[3]/div/div/div/div[2]/table[@class='o_group o_inner_group']/tbody/tr[2]/td[2]/span[@class='o_field_date o_field_widget o_readonly_modifier']"))
    )
Cree__le= element3.get_attribute("innerHTML")
print('Cree__le',Cree__le)



def return_data():
    result=(ID,nom_livrable,Nom__du__client,address,Cree__par,Cree__le)
    return result

print (return_data())