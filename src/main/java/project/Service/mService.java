package project.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import project.Dto.mDto;
import project.Repository.mRepository;

import java.io.File;
import java.io.IOException;

@Service
public class mService {
    @Autowired
    mRepository mr;
    public mDto findid(mDto mem) {
        return mr.findid(mem);
    }

    public int save(mDto mem) throws IOException {
        String mfname = mem.getMf().getOriginalFilename();//2
        mfname =System.currentTimeMillis()+"-"+mfname;//2.1
        mem.setMfname(mfname);//3
        String savePath ="c:\\spring_img\\"+mfname;//4

        if(!mem.getMf().isEmpty()){
            mem.getMf().transferTo(new File(savePath));

        }//5
        return mr.save(mem);//6}
    }


    public void logc(mDto mem) {
        mr.logc(mem);
    }

    public void logoutc(String mid) {
        mr.logoutc(mid);
    }
}
