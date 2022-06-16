package project.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import project.Dto.msgDto;
import project.Repository.msgRepository;

import java.util.List;

@Service
public class msgService {
    @Autowired
    msgRepository msgr;
    public int save(msgDto mem) {
        return msgr.save(mem);
    }

    public List<msgDto> findmsg(msgDto mem) {
        return msgr.findmsg(mem);
    }

    public int seeint(msgDto mem) {
        return msgr.seeint(mem);
    }

    public int mgscount(msgDto msg) {
        return msgr.msgcount(msg);
    }

    public int mcount(msgDto mem,String type) {
        return msgr.mcount(mem,type);
    }

    public msgDto findclist(msgDto mem) {
        return msgr.findclist(mem);
    }
}
