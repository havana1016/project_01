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
        sql.update("fr.logc",fr);
        mDto mem=sql.selectOne("mem.findid",fr.getFid());
        if(mem.getLogc()==1){
        sql.update("fr.logc",fr);}
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

    public Integer logcount(String mid) {
        return sql.selectOne("fr.lcount",mid);
    }

    public int delfr(fDto mem) {
        int result=sql.delete("fr.delfr",mem);
        System.out.println("fRepository.delfr");
        System.out.println("result= " + result);
        return result;
    }
}
