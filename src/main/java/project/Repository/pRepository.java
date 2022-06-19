package project.Repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import project.Dto.pDto;

import java.util.List;

@Repository
public class pRepository {
    @Autowired
    SqlSessionTemplate sql;

    public int save(pDto mem) {
        return sql.insert("pfr.save",mem);
    }

    public pDto pfrc(pDto mem) {
        pDto result=sql.selectOne("pfr.pfrc",mem);
        System.out.println("pRepository.pfrc");
        System.out.println("result: "+result);
        return result;
    }

    public List<pDto> plz(pDto mem) {
        return sql.selectList("pfr.plz",mem);
    }

    public List<pDto> yes(pDto mem) {
        return sql.selectList("pfr.yes",mem);
    }

    public int pcount(pDto mem) {
        int result=sql.selectOne("pfr.pcount",mem);
        return result;
    }

    public int yesf(pDto mem) {
        return sql.update("pfr.yesf",mem);
    }
    public int nof(pDto mem) {
        return sql.delete("pfr.nof",mem);
    }

    public int ycount(pDto mem) {
        return sql.selectOne("pfr.ycount",mem);
    }
}
