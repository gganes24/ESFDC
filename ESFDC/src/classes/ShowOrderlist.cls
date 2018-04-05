public with sharing class ShowOrderlist {
public List<Order__c> lstOrderedProducts {get;set;}
public ShowOrderlist() {
     
        lstOrderedProducts = [SELECT name , Buyer_Name__c, Brand__c, Quantity__c,Price__c, Date_of_Order__c, Name__c ,Buyed__c FROM Order__c ORDER BY name DESC]; 
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Product Booked successfully ')); 
    }
}