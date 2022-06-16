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
            System.out.println("msgRepository.save");
            System.out.println("date = " + date);
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
        int result=0;

        if(type.equals("flist")){
        result=sql.selectOne("msg.mcount",mem);}
        else if(type.equals("msglist")){
            result=sql.selectOne("msg.mcount1",mem);}

        return result;
    }

    public msgDto findclist(msgDto mem) {
        msgDto result=sql.selectOne("msg.findclist",mem);

        return result;
    }
}
