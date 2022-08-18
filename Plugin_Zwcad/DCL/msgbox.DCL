hello  : dialog {
              label = "sample box";
                  : text { label = "Hello world"; }
       ok_only;
}



plugin : dialog {				//dialog name
      label = "Plugin Zwcad" ;		//give it a label
      height = 30;
      width = 30; 
      color = 1;

      	:row {
          : edit_box {				//define edit box
         key = "insert" ;				//give it a name
         label = "&Insert URL ticket Odoo": ;			//give it a label
         edit_width = 100 ;			//30 characters
        }					//end edit box

        : button {
          key = "browser" ;				//give it a name
         label = "Browser" ;			//give it a label
         edit_width = 10 ;

        }


        }
        
    
       : row {					//define row
 
        :boxed_row {		
         label = "&Calques" ;				//define boxed row
 
        :toggle {				//define toggle
        key = "tog1";				//give it a name
        label = "GEX_EDS_sdp_2-tremie";			//give it a label
        }					//end toggle
 
        :toggle {				//define toggle
        key = "tog2";				//give it a name
        label = "GEX_EDS_sdp_3-h-180";			//give it a label
        }					//end definition

        :toggle {				//define toggle
        key = "tog3";				//give it a name
        label = "GEX_EDS_sdp_5-pk";			//give it a label
        }					//end definition

         :toggle {				//define toggle
        key = "tog4";				//give it a name
        label = "GEX_EDS_sdp_7-lt";			//give it a label
        }					//end definition
 
         :toggle {				//define toggle
        key = "tog5";				//give it a name
        label = "GEX_EDS_sdp_8-cave";			//give it a label
        }					//end definition
 
         :toggle {				//define toggle
        key = "tog6";				//give it a name
        label = "GEX_EDS_sdp_teinte_contour";			//give it a label
        }					//end definition
 
        }					//end boxed row


        
 
       }					//end row

        : row {					//define row
 
       :boxed_radio_column {			//define radio column
       label = "&Style" ;				//give it a label
 
        : radio_button {			//define radion button
     	  key = "rb1" ;				//give it a name
     	  label = "swissl.ttf" ;		//give it a label
     	  value = "1" ;				//switch it on
        }					//end definition
      
     	: radio_button {			//define radio button
     	  key = "rb2" ;				//give it a name
     	  label = "INT_Roman" ;		//give it a label
        value = "2";
     	}					//end definition
    
     	: radio_button {			//define radio button
     	  key = "rb3" ;				//give it a name
     	  label = "SURF" ;	//give it a label
        value = "3";
     	  }					//end definition
        }					//end radio column


       :boxed_radio_column {			//define radio column
       label = "&Types de Hachure" ;				//give it a label
 
        : radio_button {			//define radion button
     	  key = "type1" ;				//give it a name
     	  label = "Predetermine" ;		//give it a label
     	  value = "1" ;				//switch it on
        }					//end definition
 
     	: radio_button {			//define radio button
     	  key = "type2" ;				//give it a name
     	  label = "Defini par l'utilisateur" ;		//give it a label
        value = "2";
     	}					//end definition
 
     	: radio_button {			//define radio button
     	  key = "type3" ;				//give it a name
     	  label = "Personnalise" ;	//give it a label
        value = "3";
     	  }					//end definition
        }					//end radio column
        
        :boxed_radio_column {			//define radio column
       label = "&Motif de Hachure" ;				//give it a label
 
        : radio_button {			//define radion button
     	  key = "Motif1" ;				//give it a name
     	  label = "SOLID" ;		//give it a label
     	  value = "1" ;				//switch it on
        }					//end definition
 
     	: radio_button {			//define radio button
     	  key = "Motif2" ;				//give it a name
     	  label = "ANGLE" ;		//give it a label
        value = "2";
     	}					//end definition
 
     	: radio_button {			//define radio button
     	  key = "Motif3" ;				//give it a name
     	  label = "ANSI32" ;	//give it a label
        value = "3";
     	  }					//end definition
        }					//end radio column


         : boxed_column{
          label = "&Actions" ;				//give it a label

            : button {
            
            label = "Extract";
            key = "Extract";
            mnemonic = "O";
         }

            : button {
            
            label = "SDP";
            key = "SDP";
            mnemonic = "O";
         }

          

            : button {
           
            label = "Export";
            key = "export";
            mnemonic = "O";
         }

        }


 
       }					//end row
 



        : paragraph {


        }
        : edit_box {				//define edit box
         key = "eb2" ;				//give it a name
         label = "Notes :" ;			//give it a label
        
        
        }					//end edit box

       
    
      : row {

      : column{
         ok_cancel ;				//predifined OK/Cancel
      }
 
      }
     
					
     }						//end dialog

lspOkCancel : dialog {

	key = "main";

	: column {

	: text {
	key = "message1";
	       }

	: text {
	key = "message2";
	       }

	: text {
	key = "message3";
	       }
	}
   	: row {

	: spacer { width = 1; }

	: button {
	label = "OK";
	key = "accept";
	width = 0.5; //Sets width of button
  height = 2; //Sets height of button
	fixed_width = true;
	mnemonic = "O";
	is_default = true;
	}

	: button {
	label = "Cancel";
	key = "cancel";
	width = 0.5; //Sets width of button
  height = 2; //Sets height of button
	fixed_width = true;
	mnemonic = "C";
	is_cancel = true;
  	}

	: spacer { width = 1;}

	}

  		 }

////////////////////////////////////////////////

lspYesNo : dialog {

	key = "main";

	: column {

	: text {
	key = "message1";
	       }

	: text {
	key = "message2";
	       }

	: text {
	key = "message3";
	       }
	}
   	: row {

	: spacer { width = 1; }

	: button {
	label = "Yes";
	key = "yes";
	width = 12;
	fixed_width = true;
	mnemonic = "Y";
	is_default = true;
	}

	: button {
	label = "No";
	key = "no";
	width = 12;
	fixed_width = true;
	mnemonic = "N";
	is_cancel = true;
  	}

	: spacer { width = 1;}

	}

  		 }

////////////////////////////////////////////

lspOkOnly : dialog {

	key = "main";

	: column {

	: text {
	key = "message1";
	       }

	: text {
	key = "message2";
	       }

	: text {
	key = "message3";
	       }
	}
   	: row {

	: spacer { width = 1; }

	: button {
	label = "OK";
	key = "accept";
	width = 12;
	fixed_width = true;
	mnemonic = "O";
	is_default = true;
	alignment = centered;
	}

	: spacer { width = 1;}

	}

  		 }

////////////////////////////////////////////////

lspYesNoCancel : dialog {

	key = "main";

	: column {

	: text {
	key = "message1";
	       }

	: text {
	key = "message2";
	       }

	: text {
	key = "message3";
	       }
	}
   	: row {

	: spacer { width = 1; }

	: button {
	label = "Yes";
	key = "yes";
	width = 12;
	fixed_width = true;
	mnemonic = "Y";
	is_default = true;
	}

	: button {
	label = "No";
	key = "no";
	width = 12;
	fixed_width = true;
	mnemonic = "N";
  	}

	: button {
	label = "Cancel";
	key = "cancel";
	width = 12;
	fixed_width = true;
	mnemonic = "C";
	is_cancel = true;
  	}

	: spacer { width = 1;}

	}

  		 }

////////////////////////////////////////////

lspRentryCancel : dialog {

	key = "main";

	: column {

	: text {
	key = "message1";
	       }

	: text {
	key = "message2";
	       }

	: text {
	key = "message3";
	       }
	}
   	: row {

	: spacer { width = 1; }

	: button {
	label = "Rentry";
	key = "rentry";
	width = 12;
	fixed_width = true;
	mnemonic = "R";
	is_default = true;
	}

	: button {
	label = "Cancel";
	key = "Cancel";
	width = 12;
	fixed_width = true;
	mnemonic = "C";
	is_cancel = true;
  	}

	: spacer { width = 1;}

	}

  		 }

////////////////////////////////////////////