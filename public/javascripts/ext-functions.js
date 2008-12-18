
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


function displayKompetansemaal(text, tittel)
{

    win = new Ext.Window({
       title: "<b>"+tittel+"</b>",
       html:text.join("<br/>"),
       height:200,
       width:200
    });

    win.show();

}




