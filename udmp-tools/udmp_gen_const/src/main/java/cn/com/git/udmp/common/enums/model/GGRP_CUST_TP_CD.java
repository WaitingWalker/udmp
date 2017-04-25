
package cn.com.git.udmp.common.enums.model;

import java.util.Arrays;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import cn.com.git.udmp.common.enums.IType;

public enum GGRP_CUST_TP_CD implements IType {
    ID_1("01","行内借款人","1"),
    ID_2("02","行内借款人的保证人","2"),
    ID_3("03","其它","3");


    String id;
    String value;
    String seq;

    GGRP_CUST_TP_CD(String _id, String _value, String _seq) {
        id = _id;
        value = _value;
        seq = _seq;
    }
    
    private static Map<String, GGRP_CUST_TP_CD> map = new LinkedHashMap<String, GGRP_CUST_TP_CD>();
    private static Map<String, String> valMap = new LinkedHashMap<String, String>();
    
    static {
        List<GGRP_CUST_TP_CD> typeList = Arrays.asList(GGRP_CUST_TP_CD.values());
        typeList.sort(new Comparator<IType>() {

            @Override
            public int compare(IType x, IType y) {
                return  x.getSeq().compareTo(y.getSeq());
            }
        });
        for(IType x:typeList){
            map.put(x.name(),    (GGRP_CUST_TP_CD) x);
            valMap.put(x.getId(), x.getValue());
        }
    }

    GGRP_CUST_TP_CD(String... names) {
        id = names[0];
        value = names[1];
        seq = names[2];
    }

    @Override
    public Map<String, String> getType() {
        return valMap;
    }
    
    @Override
    public String getValueById(String id) {
        return valMap.get(id);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getSeq() {
        return seq;
    }

    public void setSeq(String seq) {
        this.seq = seq;
    }

    @Override
    public String getIdByValue(String value) {
        for(String key:valMap.keySet()){
            if(value.equals(valMap.get(key))){
                return key;
            }
        }
        return null;
    }

}

