function blankRecipeFields()
{
    var color = "#92fc71"
    document.getElementById("cfPaz").style.backgroundColor = color;
    document.getElementById("nomePaz").style.backgroundColor = color;
    document.getElementById("cognomePaz").style.backgroundColor = color;
    document.getElementById("dataNascitaPaz").style.backgroundColor = color;
    document.getElementById("codRegMed").style.backgroundColor = color;
}

function validateCf(cf, id)
{
    if (cf.length != 16)
    {
        blankRecipeFields();
        document.getElementById(id).style.backgroundColor = "red";
        alert("Codice fisale non valido!");

        return false;
    }
    else
        return true;
}

function validateName(name, id)
{
    var pattern = /^[A-Za-z\s]+$/;

    if(! pattern.test(name))
    {
        blankRecipeFields();
        document.getElementById(id).style.backgroundColor = "red";
        alert("Nome non valido!");

        return false;
    }
    else
        return true;
}

function validateDate(date, id)
{
    var pattern = /^([0-9]{2})-([0-9]{2})-([0-9]{4})$/;

    if (date == "")
        return true;

    if (!pattern.test(date))
    {
        blankRecipeFields();
        document.getElementById(id).style.backgroundColor = "red";
        alert("Data non valida! ");

        return false;
    }
    else
        return true;
}

function validatePrescriptionForm()
{
    var cf = document.forms["form"]["cfPaz"].value;
    var nome = document.forms["form"]["nomePaz"].value;
    var cognome = document.forms["form"]["cognomePaz"].value;
    var data = document.forms["form"]["dataNascitaPaz"].value;
    var ret;

    ret = validateCf(cf, "cfPaz");

    if(ret == true)
        ret = validateName(nome, "nomePaz");
    if(ret == true)
        ret = validateName(cognome, "cognomePaz");
    if(ret == true)
        ret = validateDate(data, "dataNascitaPaz");

    return ret;
}