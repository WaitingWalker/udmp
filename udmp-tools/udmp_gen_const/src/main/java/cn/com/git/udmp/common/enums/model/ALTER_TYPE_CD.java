
package cn.com.git.udmp.common.enums.model;

import java.util.Arrays;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import cn.com.git.udmp.common.enums.IType;

public enum ALTER_TYPE_CD implements IType {
    ID_1("06","名称变更","6"),
    ID_2("01","高管变更","1"),
    ID_3("02","经营范围变更","2"),
    ID_4("03","行业变更","3"),
    ID_5("04","地址变更","4"),
    ID_6("05","股东变更","5");


    String id;
    String value;
    String seq;

    ALTER_TYPE_CD(String _id, String _value, String _seq) {
        id = _id;
        value = _value;
        seq = _seq;
    }
    
    private static Map<String, ALTER_TYPE_CD> map = new LinkedHashMap<String, ALTER_TYPE_CD>();
    private static Map<String, String> valMap = new LinkedHashMap<String, String>();
    
    static {
        List<ALTER_TYPE_CD> typeList = Arrays.asList(ALTER_TYPE_CD.values());
//        typeList.stream().sorted((x, y) -> x.seq.compareTo(y.seq)).forEach(x -> {
//            map.put(x.name(), x);
//            valMap.put(x.getId(), x.getValue());
//        });
        typeList.sort(new Comparator<IType>() {

            @Override
            public int compare(IType x, IType y) {
                return  x.getSeq().compareTo(y.getSeq());
            }
        });
        for(IType x:typeList){
            map.put(x.name(), (ALTER_TYPE_CD) x);
            valMap.put(x.getId(), x.getValue());
        }
    }

    ALTER_TYPE_CD(String... names) {
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

