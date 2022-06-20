package project.Dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class mDto {
    Integer id;
    String mid;
    String mpw;
    MultipartFile mf;
    String mfname;
    int logc;

}
