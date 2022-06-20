package project.Repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import project.Dto.msgDto;

import java.util.List;

@Repository
public class msgRepository {
    @Autowired
    SqlSessionTemplate sql;
    public int save(msgDto mem) {
        int result=sql.insert("msg.save",mem);
        if(result>0){
            String date=sql.selectOne("msg.mtime",mem);

            mem.setMtime(date);
            sql.update("fr.mtime",mem);
        }
        return result;
    }

    public List<msgDto> findmsg(msgDto mem) {

        return sql.selectList("msg.findmsg",mem);
    }

    public int seeint(msgDto mem) {
        return sql.update("msg.seeint",mem);
    }

    public int msgcount(msgDto msg) {
        return sql.selectOne("msg.count",msg);
    }

    public int mcount(msgDto mem,String type) {
        Integer result=0;

        if(type.equals("flist")){

        result=sql.selectOne("msg.mcount",mem);
        if(result==null){
            result=0;
        }
        }
        else if(type.equals("msglist")){
            result=sql.selectOne("msg.mcount1",mem);
            if(result==null){
                result=0;
            }
        }

        return result;
    }

    public msgDto findclist(msgDto mem) {
        msgDto result=sql.selectOne("msg.findclist",mem);
        return result;
    }
}
