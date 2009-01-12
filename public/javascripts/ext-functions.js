
function copySelectedUuids() {
  var uuids = [];
  var grid = Ext.getCmp('kompetansemaal_grid');

  var selRecords = grid.getSelectionModel().getSelections();

  for ( rec = 0; rec < selRecords.length; rec++)
    {
      uuids = uuids.concat(selRecords[rec].get('kompetansemaal_uuid')+"");
    }
    displayKompetansemaal(uuids, "Valgte kompetansemål uuid:");
}

function copySelectedCodesAndUuids() {
  var rows = [];
  var grid = Ext.getCmp('kompetansemaal_grid');

  var selRecords = grid.getSelectionModel().getSelections();

  for ( rec = 0; rec < selRecords.length; rec++)
    {
      text = [selRecords[rec].get('kompetansemaal_kode')] + ", " + [selRecords[rec].get('kompetansemaal_uuid')]
      rows = rows.concat(text);
    }
    displayKompetansemaal(rows, "Valgte kompetansemål med kode og uuid:");
}

function merkPopupText()
{
    
 }

function displayKompetansemaal(text, tittel)
{
    style ="width:100%; height:100%; background:none;"
    text_area = "<textarea id='popuptext' style='"+style+"'>"+ text.join("\n") +"</textarea>"


    win = new Ext.Window({
       title: "<b>"+tittel+"</b>",
       html:text_area,
       minheight:200,
       width:400,
       id:"popup",
       keys:{
           key: 'a',
           ctrl: true,
           stopEvent:true,
           handler: function(){
               Ext.getDom('popuptext').select();
           }
       },
       buttons: [
        {
           text:"Lukk",
           handler:function(){
                win.close();
        }}]
    });
  

    win.show();

}



