function setSelectedKompetansemaal()
{
    valgte_kompetansemaal = getSelectedKompetansemaal();
    valgte_data = retriveDataFromGrid(valgte_kompetansemaal);

    valgte_grid = document.getElementById("valgte_kompetansemaal");
    valgte_grid.data = valgte_data;

    showValgteKompetansemaal();

};

function showValgteKompetansemaal()
{
    valgte_window = document.getElementById("valgte_tekst");
    valgte_grid = document.getElementById("valgte_kompetansemaal");

    data = valgte_grid.data
    valgte_window.innerHTML = "";
    for(i in data){
        valgte_window.innerHTML = valgte_window.innerHTML + "<br/>" + formatedKompetansemaalLinje(data[i])
    }
}

function formatedKompetansemaalLinje(gridData){
    line = "";
    valgte_grid = document.getElementById("valgte_kompetansemaal");
    if(gridData == undefined){
        return ""
    }
    
    if(valgte_grid.showId == true){
        line = line + gridData['kompetansemaal_uuid'];
    }

    return line;
};

function retriveDataFromGrid(gridData)
{
     valgte_data = []
     for(i in gridData){
        data = gridData[i].data;
        valgte_data[i] = data;
    }
    return valgte_data
};

function toggleShowId(show)
{
    valgte_grid = document.getElementById("valgte_kompetansemaal");
    valgte_grid.showId = show;

    setSelectedKompetansemaal();
}



