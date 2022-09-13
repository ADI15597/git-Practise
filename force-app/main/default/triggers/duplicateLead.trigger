trigger duplicateLead on Lead (before insert) 
{
    set<string>emailSet = new set<string>();
    for(lead objectLead : trigger.new)
    {
        emailSet.add(objectLead.email);
    }
    
    map<string,lead> leadMap = new map<string,lead>();
    for(lead objLead : [select id,email from lead where email IN:emailSet])
    {
        leadMap.put(objLead.email,objLead);
    }
    
    if(!leadMap.isEmpty())
    {
        for(lead objectLead : trigger.new)
        {
            if(leadMap.containsKey(objectLead.email))
            {
                objectLead.Email.addError('lead with this email is already exists please try Another Email');
            }
        }
    }
}