
function copy(text) {  
  var textArea = new Ext.form.TextArea({
         value: text
    });
    var win = new Ext.Window({
      width: 1,
      height: 1,
      x: 0,
      y: 0,
      items: [
        textArea
      ]
    });
    win.show();
    textArea.focus(true);
    new Ext.util.DelayedTask(function(){
      this.close();
    }, win).delay(5);
}

function copySelectedUuids() {
  var uuids = "";
  var grid = Ext.getCmp('kompetansemaal_grid');

  var selRecords = grid.getSelectionModel().getSelections();

  for ( rec = 0; rec < selRecords.length; rec++)
    {
      uuids += selRecords[rec].get('kompetansemaal_uuid') + "\n"; 
    }
    copy(uuids);
}