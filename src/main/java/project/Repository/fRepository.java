package project.Repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import project.Dto.fDto;
import project.Dto.mDto;

import java.util.List;

@Repository
public class fRepository {
    @Autowired
    SqlSessionTemplate sql;
    public int yesf(fDto fr) {
        int result=sql.insert("fr.save",fr);
        sql.update("fr.logc2",fr);
        sql.update("fr.logc1",fr);
        return result;

    }

    public List<fDto> findall(fDto mem) {
        return sql.selectList("fr.findall",mem);
    }

    public void logc(mDto mem) {
        sql.update("fr.logc",mem);
    }

    public void logoutc(String mid) {
        sql.update("fr.logoutc",mid);

    }

    public int logcount(String mid) {
        return sql.selectOne("fr.lcount",mid);
    }
}
