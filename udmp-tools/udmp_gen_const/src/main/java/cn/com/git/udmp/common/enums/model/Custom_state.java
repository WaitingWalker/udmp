
package cn.com.git.udmp.common.enums.model;

import java.util.Arrays;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import cn.com.git.udmp.common.enums.IType;

public enum Custom_state implements IType {
    ID_1("3","注销","30"),
    ID_2("1","注册","10"),
    ID_3("2","实名认证","20");


    String id;
    String value;
    String seq;

    Custom_state(String _id, String _value, String _seq) {
        id = _id;
        value = _value;
        seq = _seq;
    }
    
    private static Map<String, Custom_state> map = new LinkedHashMap<String, Custom_state>();
    private static Map<String, String> valMap = new LinkedHashMap<String, String>();
    
    static {
        List<Custom_state> typeList = Arrays.asList(Custom_state.values());
        typeList.sort(new Comparator<IType>() {

            @Override
            public int compare(IType x, IType y) {
                return  x.getSeq().compareTo(y.getSeq());
            }
        });
        for(IType x:typeList){
            map.put(x.name(),    (Custom_state) x);
            valMap.put(x.getId(), x.getValue());
        }
    }

    Custom_state(String... names) {
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

