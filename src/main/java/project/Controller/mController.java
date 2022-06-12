package project.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import project.Dto.mDto;
import project.Service.mService;

import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
@RequestMapping("member")
public class mController  {
    @Autowired
    mService ms;
    @GetMapping("save")
    String saveform(){
        return "/member/save-form1";
    }
    @GetMapping("/findid")
    @ResponseBody String findid(@ModelAttribute mDto mem){
        if(ms.findid(mem)!=null){
            return "no";
        }return null;

    }
    @PostMapping("save")
    String save(@ModelAttribute mDto mem,HttpSession session) throws IOException {
        if(ms.save(mem)>0){
            session.setAttribute("logmem",mem);
            return "/member/main";
        }return null;

    }
    @PostMapping ("login")
    @ResponseBody mDto login(@ModelAttribute mDto mem, HttpSession session){
        mDto result=ms.findid(mem);
        if(result!=null){
            if(result.getMpw().equals(mem.getMpw())){
                session.setAttribute("logmem",result);
                return result;
            }
        }return null;
    }
    @GetMapping ("main")
    String main(){
        return "/member/main";
    }
    @GetMapping("search")
    @ResponseBody mDto search(@ModelAttribute mDto mem, Model model){
        System.out.println("mController.search");
        mDto result=ms.findid(mem);
        System.out.println(result);
        model.addAttribute("smem",result);

            return result;

    }
    @GetMapping("logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "index";
    }

}
