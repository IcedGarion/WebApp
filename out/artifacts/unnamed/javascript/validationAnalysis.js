function blankField()
{
    var color = "#92fc71";
    document.getElementById("start").style.backgroundColor = color;
    document.getElementById("end").style.backgroundColor = color;
}

function validateDate(date, id)
{
    var pattern = /^([0-9]{2})-([0-9]{2})-([0-9]{4})$/ ;

    if(date == "")
        return false;

    if(! pattern.test(date))
    {
        blankField();
        document.getElementById(id).style.backgroundColor = "red";
        alert("Data non valida! ");
        return false;
    }
    else
        return true;
}


function validateAnalysisForm()
{
    var start = document.forms["form"]["start"].value;
    var end = document.forms["form"]["end"].value;
    ret = validateDate(start, "start");
    if(ret == true)
        ret = validateDate(end, "end");

    return ret;
}
