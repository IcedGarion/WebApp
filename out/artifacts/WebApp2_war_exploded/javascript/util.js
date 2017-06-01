function blankFields()
{
    document.getElementById("cf").style.backgroundColor = "white";
    document.getElementById("nome").style.backgroundColor = "white";
    document.getElementById("cognome").style.backgroundColor = "white";
    document.getElementById("username").style.backgroundColor = "white";
    document.getElementById("password").style.backgroundColor = "white";
    document.getElementById("passwordConfirm").style.backgroundColor = "white";
    document.getElementById("dataNascita").style.backgroundColor = "white";
    document.getElementById("codRegionale").style.backgroundColor = "white";
    document.getElementById("dataNascita").style.backgroundColor = "white";
    document.getElementById("nomeF").style.backgroundColor = "white";
    document.getElementById("indirizzo").style.backgroundColor = "white";
    document.getElementById("telefono").style.backgroundColor = "white";
}

function validatePharmacyForm()
{
    var cf = document.forms["form"]["cf"].value;
    var pass1 = document.forms["form"]["password"].value;
    var pass2 = document.forms["form"]["passwordConfirm"].value;
    var data = document.forms["form"]["dataNascita"].value;
    var tel = document.forms["form"]["telefono"].value;

    if (cf.length != 16)
    {
        blankFields();
        alert("Codice Fiscale non valido!");
        document.getElementById("cf").style.backgroundColor = "red";
        return false;
    }
    if(! (pass1 == pass2))
    {
        blankFields();
        alert("Le password non corrispondono");
        document.getElementById("password").style.backgroundColor = "red";
        document.getElementById("passwordConfirm").style.backgroundColor = "red";
        return false;
    }

    return true;
}