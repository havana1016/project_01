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
}
