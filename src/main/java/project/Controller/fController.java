package project.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import project.Dto.fDto;
import project.Dto.msgDto;
import project.Service.fService;
import project.Service.msgService;

import java.util.List;

@Controller
@RequestMapping("fr")
public class fController {
    @Autowired
    fService fs;
    @Autowired
    msgService msgs;
    @GetMapping("findall")
    @ResponseBody List<fDto> findall(@ModelAttribute fDto mem, Model model){
        String mset= mem.getMid();
        String mget= mem.getFid();
        msgDto msg=new msgDto();
        msg.setMset(mset);
        msg.setMget(mget);
        model.addAttribute("mcount",msgs.mgscount(msg));

        return fs.findall(mem);
    }
    @GetMapping("logc")
    @ResponseBody int logcount(@RequestParam("mid")String mid){
        return fs.logcount(mid);
    }
}
