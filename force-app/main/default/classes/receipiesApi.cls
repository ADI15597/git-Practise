public class receipiesApi {
    private static final string spoonacularApi = 'https://api.spoonacular.com';
    private static final string apiKey = 'apiKey=231e15fc7b59478db7654b0da0c0c8c1';

        
    
    public static void getRandomReceipies()
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(spoonacularApi+'/recipes/random?'+apiKey);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        system.debug(response.getStatusCode());
        if(response.getStatusCode() == 200) 
        {
            
        }
    }
     public static void getReceipie(string resID)
    {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(spoonacularApi+'/recipes/'+resID+'/information?'+apiKey);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        system.debug(response.getStatusCode());
        if(response.getStatusCode() == 200) 
        {
            
        }
    }
     public static void getReceipiesWithIndgridients(string indgridients)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(spoonacularApi+'/recipes/findByIngredients?'+apiKey+'&ingredients'+indgridients);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        system.debug(response.getStatusCode());
        if(response.getStatusCode() == 200) 
        {
            
        }
    }
}