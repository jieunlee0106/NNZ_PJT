package nnz.nanumservice.service;

import io.github.eello.nnz.common.dto.PageDTO;
import nnz.nanumservice.dto.NanumInfoDTO;
import nnz.nanumservice.dto.res.ResNanumStockDTO;
import nnz.nanumservice.dto.res.nanum.ResNanumDTO;
import nnz.nanumservice.dto.res.nanum.ResNanumDetailDTO;
import nnz.nanumservice.dto.res.nanum.ResSearchNanumDTO;
import nnz.nanumservice.dto.res.search.ResSearchDTO;
import nnz.nanumservice.vo.NanumVO;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface NanumService {

    void createNanum(NanumVO data, List<MultipartFile> images);

    PageDTO readNanumsByShowId(Long showId, PageRequest pageRequest);

    PageDTO readNanumsByNanumTag(String nanumTagName, PageRequest pageRequest);

    PageDTO readNanumsByLocation(Double lat, Double lng, PageRequest pageRequest);

    void createNanumInfo(Long nanumId, NanumInfoDTO nanumInfoDTO);

    NanumInfoDTO readNanumInfo(Long nanumId, Long userId);

    ResNanumDetailDTO readNanumDetail(Long nanumId, Long userId);

    void createUserNanum(Long nanumId, Long userId, MultipartFile file);

    List<ResNanumDTO> readPopularNaums();

    ResNanumStockDTO readNanumStock(Long nanumId);

    void updateNanum(Long id, Long writerId, NanumVO data, List<MultipartFile> images);
    ResSearchDTO searchNanum(String query, Pageable pageable);
}
