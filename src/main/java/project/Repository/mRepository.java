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
        mDto result=sql.selectOne("mem.findid",mid);
               return result;
    }

    public int save(mDto mem) {
        return sql.insert("mem.save",mem);
    }
}
