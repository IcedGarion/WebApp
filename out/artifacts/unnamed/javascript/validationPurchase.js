
function validatePurchaseRole(role)
{
    if(role.toLowerCase() == "ob")
    {
        alert("Non puo' vendere farmaco con ricetta");
        return false;
    }

    return true;
}