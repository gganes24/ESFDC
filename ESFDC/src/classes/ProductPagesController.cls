public with sharing class ProductPagesController {
public List<Product__c> tvsList {set;get;}
public List<Product__c> laptopsList {set;get;}
public List<Product__c> mobilesList {set;get;}
public List<Product__c> monitorsList {set;get;}
public List<Product__c> productsList {set;get;}
public List<Product__c> shoppingCart {set;get;}
public String cartContents;
private String currentPage = ApexPages.currentPage().getParameters().get('Id');
private boolean choosenProduct;

public ProductPagesController(){
    productsList = new List<Product__c>();
    choosenProduct = false;
    productsList.addAll(tvsList);
    productsList.addAll(laptopsList);
    productsList.addAll(mobilesList);
    productsList.addAll(monitorsList);
}

public PageReference addProductToShoppingCart(){
    if(currentPage == null){
        //PageReference pageRef = new PageReference('/apex/ShoppingCart');
        PageReference pageRef = new PageReference('/apex/Welcome_Page');
        return pageRef;
    }else{
        for(Product__c product : productsList) {
            if (product.Quantity__c > 0) {
                shoppingCart.add(product);
            }
        }
        return null;
    }
}
}