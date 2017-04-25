
package cn.com.git.udmp.common.enums.model;

import java.util.Arrays;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import cn.com.git.udmp.common.enums.IType;

public enum Repayment_mode implements IType {
    ID_1("1","不准提前还款","1"),
    ID_2("4","逾期还款","4"),
    ID_3("3","正常还款","3"),
    ID_4("2","提前还款","2");


    String id;
    String value;
    String seq;

    Repayment_mode(String _id, String _value, String _seq) {
        id = _id;
        value = _value;
        seq = _seq;
    }
    
    private static Map<String, Repayment_mode> map = new LinkedHashMap<String, Repayment_mode>();
    private static Map<String, String> valMap = new LinkedHashMap<String, String>();
    
    static {
        List<Repayment_mode> typeList = Arrays.asList(Repayment_mode.values());
        typeList.sort(new Comparator<IType>() {

            @Override
            public int compare(IType x, IType y) {
                return  x.getSeq().compareTo(y.getSeq());
            }
        });
        for(IType x:typeList){
            map.put(x.name(),    (Repayment_mode) x);
            valMap.put(x.getId(), x.getValue());
        }
    }

    Repayment_mode(String... names) {
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

