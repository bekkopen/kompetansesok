

function getSelectedKompetansemaal(){
    return getSelectedRowsFrom('kompetansemaal_grid');
};

function getSelectedRowsFrom(extGridPanelId)
{
  var grid = Ext.getCmp(extGridPanelId);
  var selRecords = grid.getSelectionModel().getSelections();
  return selRecords;
}

function merkPopupText()
{
    
 }

