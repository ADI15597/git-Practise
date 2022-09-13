public class ExchangeRatesApi 
{

       public static Decimal usdToInr(Decimal dollar) {
        Decimal INR = 0.0;
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.exchangeratesapi.io');
        req.setMethod('GET');
        
       HttpResponse res = http.send(req);
       system.debug(res.getStatusCode());
       if(res.getStatusCode()==200){
       
            
            // Deserialize the JSON string into collections of primitive data types.
            Map<String,Object> results = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
            Map<String,Object> value = (Map<String,Object>)results.get('rates');
            Decimal usdRate = (Decimal)value.get('USD');
            Decimal inrRate = (Decimal)value.get('INR');
            INR = (dollar/usdRate) * inrRate;
            System.debug('Rates of INR: '+INR);
            return INR;
        }
        return res.getStatusCode();
        
    }

}