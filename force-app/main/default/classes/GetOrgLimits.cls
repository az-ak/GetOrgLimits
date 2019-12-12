public without sharing class GetOrgLimits {

    class Data implements Comparable {
        @AuraEnabled
        public String name{get; set;}
        @AuraEnabled
        public Integer max{get; set;}
        @AuraEnabled
        public Integer usage{get; set;}
        @AuraEnabled
        public Integer usageRate{get; set;}

        public Data(String name, Integer max, Integer usage){
            this.name = name;
            this.max = max;
            this.usage = usage;
            if (this.max == 0) {
                this.usageRate = 0;
            } else {
                this.usageRate =  Math.round((Double)this.usage / (Double)this.max *100);
            }
        }

        public Integer compareTo(Object compareTo) {
            Data compareToData = (Data)compareTo;
            if (usageRate > compareToData.usageRate) {
                return -1;
            } else if (usageRate < compareToData.usageRate) {
                return 1;
            } else if (name < compareToData.name) {
                return -1;
            } else {
                return 1;
            }
        }

    }

    @AuraEnabled(cacheable=true)
    public static List<Data> getAll() {
        List<Data> resList = new List<Data>();

        Map<String,OrgLimit> lmap = System.OrgLimits.getMap();
        System.debug('Array size is: ' + lmap.size());
        for(String s : lmap.keySet()){
            Data res = new Data(lmap.get(s).getName(), lmap.get(s).getLimit(), lmap.get(s).getValue() );
            resList.add(res);
        }

        resList.sort();
        return resList;
    }
}