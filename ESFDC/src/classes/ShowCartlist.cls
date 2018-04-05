public with sharing class ShowCartlist {
public Id buyserid{get; set;}
public List<Brand__c> lstBrandProducts {get;set;}
public List<Order__c> lstCartProducts {get;set;}
    
public ShowCartlist() {
  buyserid = ApexPages.currentPage().getParameters().get('id'); 
  Buyer__c buyer =new Buyer__c();
  buyer=[select id from  Buyer__c where id=:buyserid limit 1];
  lstCartProducts = [SELECT name , Buyer_Name__c, Brand__c, Quantity__c,Price__c, Date_of_Order__c, Name__c, Buyed__c FROM Order__c where Buyed__c = false and Buyer_Name__c =: buyer.id ORDER BY name DESC];
  if(lstCartProducts.size()> 0)
  {
     //
  }
  }
  
  public PageReference BuyCartProduct() {  
	      buyserid = ApexPages.currentPage().getParameters().get('id'); 
          List<Brand__c> bList = new List<Brand__c>();
          list<Buyer__c> buy2 =new list<Buyer__c>();
          buy2=[select id from  Buyer__c where id=:buyserid];
          //lstCartProducts = [SELECT  Buyed__c FROM Order__c where Buyed__c = false and Buyer_Name__c =: buy2[0].id];
          //lstBrandProducts = [Select Availablity__c from Brand__c where Material_Item__c= (SELECT Name__c FROM Order__c where Buyed__c = false and Buyer_Name__c = 'a017F00000LmtgWQAR' limit 1)                               and Name = (SELECT Brand__c FROM Order__c where Buyed__c = false and Buyer_Name__c ='a017F00000LmtgWQAR' limit 1];
      	  List<order__c> Ucart2buy = [SELECT Name__c,Brand__c, Buyed__c, Quantity__c FROM Order__c where Buyed__c = false and Buyer_Name__c =: buy2[0].id];// ='a017F00000LmtgWQAR']; and Brand__c='a0B7F000001JFnTUAW'];
          for(order__c inn : Ucart2buy)
          {
            inn.Buyed__c = true;
            System.debug(inn.Name__c);
            System.debug(inn.Brand__c);
            System.debug(inn.Quantity__c);
            Brand__c qryBrand = [SELECT Availablity__c FROM Brand__c WHERE Id =:inn.Brand__c LIMIT 1];
            qryBrand.Availablity__c = qryBrand.Availablity__c - inn.Quantity__c;
				update qryBrand;                    
            }
           Update Ucart2buy;
           PageReference retURL = new PageReference('/apex/OrderedList?id='+buyserid);
           retURL.setRedirect(true);  
           return retURL;
      	   //   update Order__c set Buyed__c = false , Date_of_Order__c = Getdatetime() where Buyed__c = true and Buyer_Name__c = 'a017F00000JmbvlQAB'
    }
    }