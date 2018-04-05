public with sharing class dynamicpicklist {
    public dynamicpicklist()
    {
     
    }
 
    public List<SelectOption> getdynamiclist() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('INDIA','INDIA'));
        options.add(new SelectOption('US','US'));
        options.add(new SelectOption('BRAZIL','BRAZIL'));
        return options;
    }

}