package project.Dto;

import lombok.Data;

@Data
public class msgDto {
    String mset;
    String mget;
    String msg;
    String mtime;
    int setint;
    int getint;
}
