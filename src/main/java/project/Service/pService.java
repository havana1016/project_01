package project.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import project.Dto.pDto;
import project.Repository.pRepository;

import java.util.List;

@Service
public class pService {
    @Autowired
    pRepository pr;
    public int save(pDto mem) {
        return pr.save(mem);
    }

    public pDto pfrc(pDto mem) {
        return pr.pfrc(mem);
    }

    public List<pDto> plz(pDto mem) {
        return pr.plz(mem);
    }

    public List<pDto> yes(pDto mem) {
        return pr.yes(mem);
        }

    public int pcount(pDto mem) {
        return pr.pcount(mem);
    }

    public int yesf(pDto mem) {
        return pr.yesf(mem);
    }
    public int nof(pDto mem) {
        return pr.nof(mem);
    }

    public int ycount(pDto mem) {
        return pr.ycount(mem);
    }
}
