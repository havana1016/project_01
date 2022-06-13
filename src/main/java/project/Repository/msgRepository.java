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
        return sql.insert("msg.save",mem);
    }

    public List<msgDto> findmsg(msgDto mem) {

        return sql.selectList("msg.findmsg",mem);
    }
}
