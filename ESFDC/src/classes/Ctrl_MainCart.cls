public with sharing class Ctrl_MainCart {
  public List<Contact> contacts { get; set; }
    public String name { get; set; }
    public String Pname { get; set; }
    public String scyState { get; set; }
    public List<Product__c> lstProducts {get;set;}
    //public List<Brand__c> lstBProducts {get;set;}
    public Integer selQty {get;set;}
    public integer identifier = 0;
    public Id buyserid{get; set;}
  //  global String cnameg {get;set;}
    public Ctrl_MainCart() {
        //lstProducts = [Select Id, Name, Price__c, Quantity__c,Brands_Page_URL__c from Brand__c];  
        lstProducts = [Select Id, Name ,Brands_Page_URL__c from Product__c];   
        buyserid = ApexPages.currentPage().getParameters().get('id'); 
        //cnameg.se = buyserid;
        //Session['CustomerN'] = buyserid;
        //lstBProducts = [Select Id, Material_Item__c from Brand__c];
        
    }
    
    public void searchProducts() {
        String srchQuery = scyState + '%';
        lstProducts = [Select Id, Name, Brands_Page_URL__c from Product__c where Name like :srchQuery];
       // lstBProducts =[Select Id, Material_Item__c from Brand__c where Name like :srchQuery];
    }
    public void reduceQuantity() {
        // Formula logic - Quantity__c = Quantity__c - selQty;
        // update products - DML
    }
}