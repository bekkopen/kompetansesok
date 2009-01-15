function ValgteKompetansemaal(){
    this.showId = true;
    this.showKode = false;
    this.showPsi = false;

    this.tekst_id = "valgte_tekst";
    this.data = [];

    

    this.displayValgteKompetansemaal = function()
    {
        valgte_window = document.getElementById(this.tekst_id);
        
        valgte_window.innerHTML = "";
        for(i in this.data){
            valgte_window.innerHTML = valgte_window.innerHTML + "\n" + this.formatedKompetansemaalLinje(this.data[i]);
        }
    };

    this.retriveDataFromExtGrid = function(gridData)
    {
        valgte_data = []
        for(i in gridData){
            data = gridData[i].data;
            valgte_data[i] = data;
        }
        this.data = valgte_data;
    };

    this.formatedKompetansemaalLinje = function(gridData){
        line = "";

        if(gridData == undefined)
            return line;

        if(valgte_kontroller.showId == true){
            line = this.prependComma(line, gridData['kompetansemaal_uuid']);
        }

        if(valgte_kontroller.showKode == true){
            line = this.prependComma(line, gridData['kompetansemaal_kode']);
        }

        if(valgte_kontroller.showPsi == true){
            line = this.prependComma(line, gridData['kompetansemaal_psi']);
        }

        return line;
    };

    this.prependComma = function(line, nextElement){
        if(line.length > 0){
            return line + "," + nextElement;
        }
        return nextElement;
    };

    this.toggleShowId=function(show)
    {
        this.showId = show;

        importAndDisplaySelectedKompetansemaal();
    }
    

};

function importAndDisplaySelectedKompetansemaal()
{
    valgte_kompetansemaal = getSelectedKompetansemaal();
    valgte_grid = document.getElementById("valgte_kompetansemaal");
    valgte_grid.valgte_kompetansemaal.retriveDataFromExtGrid(valgte_kompetansemaal);
    

    valgte_grid.valgte_kompetansemaal.displayValgteKompetansemaal();

};










