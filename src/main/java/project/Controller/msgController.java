package project.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
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
        if(msgs.save(mem)>0){
            return "ok";
        }return null;
    }


}
