package project.Repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import project.Dto.mDto;

@Repository
public class mRepository {
    @Autowired
    SqlSessionTemplate sql;
    public mDto findid(mDto mem) {
        String mid=mem.getMid();
        return sql.selectOne("mem.findid",mid);
    }

    public int save(mDto mem) {
        return sql.insert("mem.save",mem);
    }


    public void logc(mDto mem) {
        sql.update("mem.logc",mem);
    }

    public void logoutc(String mid) {
        sql.update("mem.logoutc",mid);
    }
}
