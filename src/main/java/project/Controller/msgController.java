package project.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import project.Dto.msgDto;
import project.Service.msgService;

import java.util.List;

@Controller
@RequestMapping("msg")
public class msgController {
    @Autowired
    msgService msgs;
    @GetMapping("findmsg")
    @ResponseBody List<msgDto> findmsg(@ModelAttribute msgDto mem){
        msgs.seeint(mem);
        return msgs.findmsg(mem);
    }

    @GetMapping("save")
    @ResponseBody String save(@ModelAttribute msgDto mem){
        System.out.println("msgController.save");
        System.out.println("mem = " + mem);
        if(msgs.save(mem)>0){
            return "ok";
        }return null;
    }
    @GetMapping("count")
    @ResponseBody int count(@ModelAttribute msgDto mem){
        return msgs.mgscount(mem);
    }
    @GetMapping("mcount")
    @ResponseBody int mcount(@RequestParam("mget")String mget,@RequestParam("type")String type){
        msgDto mem = new msgDto();
        mem.setMget(mget);
        System.out.println("mget = " + mget + ", type = " + type);
        return msgs.mcount(mem,type);
    }
    @GetMapping("chat")
    String chat(@ModelAttribute msgDto mem, Model model){
        model.addAttribute("clist",msgs.finfclist(mem));
        return "/msg/chat";
    }

}
