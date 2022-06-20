package project.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import project.Dto.fDto;
import project.Dto.mDto;
import project.Dto.pDto;
import project.Repository.fRepository;

import java.util.List;

@Service
public class fService {
    @Autowired
    fRepository fr;
    public int yesf(String pid,String pfname,String yid,String yfname) {
        fDto friend= new fDto();
        fDto friend1= new fDto();
        friend.setMid(yid);
        friend.setFid(pid);
        friend.setFfname(pfname);
        int a=fr.yesf(friend);
        friend1.setMid(pid);
        friend1.setFid(yid);
        friend1.setFfname(yfname);
        int b=fr.yesf(friend1);
        if(a>0 && b>0){
            return 1;
    }return 0;

    }

    public List<fDto> findall(fDto mem) {
        return fr.findall(mem);
    }

    public void logoutc(String mid) {
        fr.logoutc(mid);
    }

    public void logc(mDto mem) {
        fr.logc(mem);
    }

    public Integer logcount(String mid) {
        return fr.logcount(mid);
    }

    public int delfr(fDto mem) {
        return fr.delfr(mem);
    }
}
