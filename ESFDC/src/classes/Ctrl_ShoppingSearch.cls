public with sharing class Ctrl_ShoppingSearch
{

    public List<Contact> contacts { get; set; }
    public String name { get; set; }
    public String searchstate { get; set; }
    public String BsrchQuery {get; set;}
    public List<Brand__c> lstWProducts {get;set;}
    public List<Order__c> lstOrderedProducts {get;set;}
    public Integer selQty {get;set;}
    public integer identifier =0;
    public Id buyserid{get; set;}
    public Integer Errorcount;
    
    public Ctrl_ShoppingSearch() {
        BsrchQuery = ApexPages.currentPage().getParameters().get('id'); 
        buyserid = ApexPages.currentPage().getParameters().get('cname'); 
        String BQuery = BsrchQuery +'%';
        lstWProducts = [Select Id,Name,Cost__c ,Availablity__c ,Selected_Quantity__c from Brand__c where Material_Item__c =: BsrchQuery]; 
    }
    
      public PageReference Add2Cart() {
        Errorcount = 0;
        Brand__c myAcct;
        Order__c myorderlist;
        Set<String> nameSet = new Set<String>();
        List<Order__c> oderList1 = new List<Order__c>();
        for(Brand__c b:lstWProducts)
        {     
          if(b.Selected_Quantity__c!='0') {
          if(b.Availablity__c > Integer.valueOf(b.Selected_Quantity__c)){       
              nameSet.add(b.name);
              Order__c order = new Order__c();
              order .Brand__c= b.id;
              list<Buyer__c> buy2 =new list<Buyer__c> ();
              buy2=[select id from  Buyer__c where id=:buyserid];
              list<Product__c> Product2 =new list<Product__c> ();
              Product2=[select id from  Product__c where Name =:BsrchQuery];
              order.Name__c = Product2[0].id; 
              order.Buyer_Name__c=buy2[0].id;
              order.Quantity__c= Integer.valueOf(b.Selected_Quantity__c);
              order.Price__c =  b.Cost__c * Decimal.valueOf(b.Selected_Quantity__c);
              order.Date_of_Order__c = Datetime.now();
              order.Buyed__c = false;
              oderList1.add(order);
              b.Selected_Quantity__c = '0';
              Errorcount=0;
              }
                else{
                     ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Invalid Quantity')); 
                    Errorcount = Errorcount + 1;
                }
            }
               else{
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'please select quantity')); 
                   Errorcount = Errorcount + 1;
               }
              }
        
       update lstWProducts;
       insert oderList1; 
      
       PageReference retURL = new PageReference('/apex/AddToCart?id='+buyserid);
       PageReference pageRef = ApexPages.currentPage();
      if(Errorcount == 0){
        retURL.setRedirect(true);
             return retURL;
         }
        else{             
            return null;
       }
    }
    
    
    public void searchProducts() {
        String srchQuery = searchstate + '%';
        lstWProducts = [Select Id, Name,Cost__c ,Availablity__c ,Selected_Quantity__c from Brand__c where Material_Item__c =: BsrchQuery and  Name like :srchQuery];
    }
    
    public PageReference reduceQuantity() {
        Errorcount = 0;
        System.debug(Errorcount);
        Brand__c myAcct;
        Order__c myorderlist;
        Set<String> nameSet = new Set<String>();
        List<Order__c> oderList = new List<Order__c>();
        for(Brand__c b:lstWProducts)
        {            
                  
            if(b.Selected_Quantity__c!='0') {
              if(b.Availablity__c > Integer.valueOf(b.Selected_Quantity__c)){
                  
              b.Availablity__c = b.Availablity__c-Decimal.valueOf(b.Selected_Quantity__c);
              nameSet.add(b.name);
              // b.Material_Item__c = BsrchQuery;
              Order__c order = new Order__c();
              order .Brand__c= b.id;
              list<Buyer__c> buy =new list<Buyer__c> ();
              buy=[select id from  Buyer__c where id=:buyserid];
              list<Product__c> Product1 =new list<Product__c> ();
              Product1=[select id from  Product__c where Name =:BsrchQuery];
              order.Name__c = Product1[0].id; 
              order.Buyer_Name__c=buy[0].id;
              system.debug(order.Name__c);
              //order .Quantity__c= Decimal.valueOf(b.Selected_Quantity__c);
              order.Quantity__c= Integer.valueOf(b.Selected_Quantity__c);
              order.Buyed__c = true;
              order.Price__c =  b.Cost__c * Decimal.valueOf(b.Selected_Quantity__c);
              order.Date_of_Order__c = Datetime.now();
              oderList .add(order);
              b.Selected_Quantity__c = '0';
              Errorcount=0;
              }
                else{
                     ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Invalid Quantity')); 
                    Errorcount = Errorcount + 1;
                }
            }
               else{
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'please select quantity')); 
                   Errorcount = Errorcount + 1;
               }
        }  
        
       
       update lstWProducts;
       insert oderList; 
        
       // Insert myorderlist;
        PageReference retURL1 = new PageReference('/apex/OrderedList?id='+buyserid);
        if(Errorcount == 0){
        retURL1.setRedirect(true);
             return retURL1;
         }
        else{             
             return null;
       }
  
    }
}