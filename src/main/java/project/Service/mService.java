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
        // return mr.save(mem);
        System.out.println("start : "+mem);
        String mfname = mem.getMf().getOriginalFilename();//2
        mfname =System.currentTimeMillis()+"-"+mfname;//2.1
        mem.setMfname(mfname);//3
        String savePath ="D:\\spring_img\\"+mfname;//4

        if(!mem.getMf().isEmpty()){
            mem.getMf().transferTo(new File(savePath));
            //파일이 비어있지 않다면 그 파일을 세이브 패스 경로에 옮겨라(저장해라)
            //나를 호출한 대로 이 익셉션을 던지겠다(예외처리)
        }//5
        System.out.println("end : "+mem);
        return mr.save(mem);//6}
    }
}
