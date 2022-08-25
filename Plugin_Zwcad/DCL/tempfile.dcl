
plugin : dialog {		
      
           label="Change Style";
           label="Insert Odoo URL";

           : row {
              : column {
                 width = 26;
                 fixed_width=true;
                 : text {
                    label="Used Styles";
                 }
                 : list_box {
                    key="used_styles";
                    multiple_select=true;
                 }
              }
              : column {
                 width = 26;
                 fixed_width=true;
                 : text {
                    label="Existing Styles";
                 }
                 : list_box {
                    key="existing_styles";
                 }
              }
           }
           : row {
              alignment = centered;
              fixed_width=true;
              : button{
                 label="Change";
                 key="change";
                 fixed_width=true;
                 is_enabled=false;
                 is_default=true;
                 width=14;
              }
              : button{
                 label="Cancel";
                 key="cancel";
                 fixed_width=true;
                 is_cancel=true;
                 width=14;
              }
           }
        
}
