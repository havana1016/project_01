package project.Repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import project.Dto.fDto;

import java.util.List;

@Repository
public class fRepository {
    @Autowired
    SqlSessionTemplate sql;
    public int yesf(fDto fr) {
        return sql.insert("fr.save",fr);

    }

    public List<fDto> findall(fDto mem) {
        return sql.selectList("fr.findall",mem);
    }
}
