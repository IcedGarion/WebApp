function blankPharmacyFields()
{
    var color = "#92fc71";
    blankPersonnelFields();
    document.getElementById("nomeF").style.backgroundColor = color;
    document.getElementById("indirizzo").style.backgroundColor = color;
    document.getElementById("telefono").style.backgroundColor = color;
}

function blankPersonnelFields()
{
    var color = "#92fc71";
    document.getElementById("cf").style.backgroundColor = color;
    document.getElementById("nome").style.backgroundColor = color;
    document.getElementById("cognome").style.backgroundColor = color;
    document.getElementById("username").style.backgroundColor = color;
    document.getElementById("password").style.backgroundColor = color;
    document.getElementById("passwordConfirm").style.backgroundColor = color;
    document.getElementById("dataNascita").style.backgroundColor = color;
}

function validateCf(cf, user)
{
    if (cf.length != 16)
    {
        //"azzera" il colore di tutti gli altri campi e mette rosso solo quello sbagliato.
        //distinzione reg-pers per sapere quali campi sbiancare (il form è uno solo)
        if(user == "reg")
            blankPharmacyFields();
        else
            blankPersonnelFields();

        document.getElementById("cf").style.backgroundColor = "red";
        alert("Codice Fiscale non valido!");
        return false;
    }
    else
        return true;
}

function validateName(name, id, user)
{
    var pattern = /^[A-Za-z\s]+$/;

    if(! pattern.test(name))
    {
        if(user == "reg")
            blankPharmacyFields();
        else
            blankPersonnelFields();

        document.getElementById(id).style.backgroundColor = "red";
        alert("Nome non valido!");
        return false;
    }
    else
        return true;
}

function validatePassword(pass1, pass2, user)
{
    if(pass1 != pass2)
    {
        if(user == "reg")
            blankPharmacyFields();
        else
            blankPersonnelFields();

        document.getElementById("password").style.backgroundColor = "red";
        document.getElementById("passwordConfirm").style.backgroundColor = "red";
        alert("Le password non corrispondono");

        return false;
    }
    else
        return true;
}

function validateDate(date, user)
{
    var pattern = /^([0-9]{2})-([0-9]{2})-([0-9]{4})$/ ;

    if(date == "")
        return true;

    if(! pattern.test(date))
    {
        if(user == "reg")
            blankPharmacyFields();
        else
            blankPersonnelFields();

        document.getElementById("dataNascita").style.backgroundColor = "red";
        alert("Data non valida! ");
        return false;
    }
    else
        return true;
}

function validateNumber(number, user)
{
    var pattern = /^([0-9]{10})$/ ;

    if(number == "")
        return true;

    if(! pattern.test(number))
    {
        if(user == "reg")
            blankPharmacyFields();
        else
            blankPersonnelFields();

        document.getElementById("telefono").style.backgroundColor = "red";
        alert("Numero di telefono non valido!");

        return false;
    }
    else
        return true;
}

function validatePersonnelForm()
{
    var nome = document.forms["form"]["nome"].value;
    var cognome = document.forms["form"]["cognome"].value;
    var cf = document.forms["form"]["cf"].value;
    var pass1 = document.forms["form"]["password"].value;
    var pass2 = document.forms["form"]["passwordConfirm"].value;
    var data = document.forms["form"]["dataNascita"].value;
    var ret = true;
    ret = validateName(nome, "nome", "pers");
    if(ret == true)
        ret = validateName(cognome, "cognome", "pers");
    if(ret == true)
        ret = validateCf(cf, "pers");
    if(ret == true)
        ret = validatePassword(pass1, pass2, "pers");
    if(ret == true)
        ret = validateDate(data, "pers");
    return ret;
}

function validatePharmacyForm()
{
    var nome = document.forms["form"]["nome"].value;
    var cognome = document.forms["form"]["cognome"].value;
    var cf = document.forms["form"]["cf"].value;
    var pass1 = document.forms["form"]["password"].value;
    var pass2 = document.forms["form"]["passwordConfirm"].value;
    var data = document.forms["form"]["dataNascita"].value;
    var tel = document.forms["form"]["telefono"].value;
    var ret = true;

    ret = validateName(nome, "nome", "reg");
    if(ret == true)
        ret = validateName(cognome, "cognome", "reg");
    if(ret == true)
        ret = validateCf(cf, "reg");
    if(ret == true)
        ret = validatePassword(pass1, pass2, "reg");
    if(ret == true)
        ret = validateDate(data, "reg");
    if(ret == true)
        ret = validateNumber(tel, "reg");

    return ret;
}