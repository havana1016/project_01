package project.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import project.Dto.fDto;
import project.Service.fService;

import java.util.List;

@Controller
@RequestMapping("fr")
public class fController {
    @Autowired
    fService fs;
    @GetMapping("findall")
    @ResponseBody List<fDto> findall(@ModelAttribute fDto mem){
        return fs.findall(mem);
    }
}
