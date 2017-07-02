function blankQtyField()
{
    var color = "#92fc71";
    document.getElementById("qty").style.backgroundColor = color;
}

function validatePurchase()
{
    var qty = document.forms["form"]["qty"].value;
    var pattern = /^([0-9]{10})$/ ;

    if(qty == "")
        return false;

    if(! pattern.test(qty))
    {
        blankQtyField();

        document.getElementById("qty").style.backgroundColor = "red";
        alert("Quantita' non valida!");

        return false;
    }

    return true;
}