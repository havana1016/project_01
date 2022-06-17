package project.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import project.Dto.mDto;
import project.Dto.pDto;
import project.Service.fService;
import project.Service.mService;
import project.Service.pService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("pfr")
public class pController {
    @Autowired
    pService ps;
    @Autowired
    mService ms;
    @Autowired
    fService fs;

    @GetMapping("save")
    @ResponseBody String save(@ModelAttribute pDto mem, HttpSession session){
        mDto mem1=new mDto();
//        mDto mem2=new mDto();

        mem1.setMid(mem.getYid());
        mDto result=ms.findid(mem1);

        mem1.setMid(mem.getPid());
        mDto result1=ms.findid(mem1);

        mem.setYfname(result.getMfname());
        mem.setPfname(result1.getMfname());
        if(ps.save(mem)>0){
            return "kkk";
        }return null;
    }
    @GetMapping("pfrc")
    @ResponseBody pDto pfrc(@ModelAttribute pDto mem){
        pDto result=ps.pfrc(mem);
        System.out.println("pController.pfrc");
        System.out.println(result.getFbool());
        return result;
    }
    @GetMapping("myfr")
    String myfr(){
        return "/friend/myfr";
    }
    @GetMapping("plz")
    @ResponseBody
    List<pDto> plz(@ModelAttribute pDto mem){
        return ps.plz(mem);
    }
    @GetMapping("yes")
    @ResponseBody
    List<pDto> yes(@ModelAttribute pDto mem){
        return ps.yes(mem);
    }
    @GetMapping("pcount")
    @ResponseBody
    int pcount(@ModelAttribute pDto mem){
        return ps.pcount(mem);
    }

    @GetMapping("yesf")
    @ResponseBody String yesf(@ModelAttribute pDto mem){

        if(fs.yesf(mem.getPid(),mem.getPfname(),mem.getYid(),mem.getYfname())>0){
            if(ps.yesf(mem)>0){
            return "ok";}
        }
        return null;

    }

    @GetMapping("myfr1")
    String myfr1(){
        return "/friend/myfr1";
    }


}
