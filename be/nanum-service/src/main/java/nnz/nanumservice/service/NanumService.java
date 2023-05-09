package nnz.nanumservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.dto.PageDTO;
import nnz.nanumservice.vo.NanumVO;
import org.springframework.data.domain.PageRequest;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface NanumService {

    void createNanum(NanumVO data, List<MultipartFile> images) throws JsonProcessingException;

    PageDTO readNanumsByShowId(Long showId, PageRequest pageRequest);

    PageDTO readNanumsByNanumTag(String nanumTagName, PageRequest pageRequest);

    PageDTO readNanumsByLocation(Double lat, Double lng, PageRequest pageRequest);
}
