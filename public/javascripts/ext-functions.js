
function copySelectedUuids() {
  var uuids = [];
  var grid = Ext.getCmp('kompetansemaal_grid');

  var selRecords = grid.getSelectionModel().getSelections();

  for ( rec = 0; rec < selRecords.length; rec++)
    {
      uuids = uuids.concat([selRecords[rec].get('kompetansemaal_uuid')]);
    }
    displayKompetansemaal(uuids);
}


function displayKompetansemaal(text)
{

    win = new Ext.Window({
       title: "<b>Valgte kompetansemål uuid:</b>",
       html:text.join("<br/>"),
       minHeight:200,
       width:200
    });

    win.show();

}




