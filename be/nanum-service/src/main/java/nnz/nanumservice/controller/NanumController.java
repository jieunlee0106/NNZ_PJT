package nnz.nanumservice.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.dto.PageDTO;
import lombok.RequiredArgsConstructor;
import nnz.nanumservice.service.NanumService;
import nnz.nanumservice.vo.NanumVO;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/nanum-service/nanums")
@RequiredArgsConstructor
public class NanumController {

    private final NanumService nanumService;

    @PostMapping
    public ResponseEntity<Void> createNanum(
            @RequestPart(name = "data") NanumVO data,
            @RequestPart(name = "images") List<MultipartFile> images
    ) {
        try {
            nanumService.createNanum(data, images);
        } catch (JsonProcessingException e) {
            // todo: error handling
        }
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<PageDTO> readNanumsByShowId(
            @RequestParam(name = "showId") Long showId,
            @RequestParam(name = "page", defaultValue = "0") Integer page,
            @RequestParam(name = "size", defaultValue = "20") Integer size) {
        PageRequest pageRequest = PageRequest.of(page, size);
        return new ResponseEntity<>(nanumService.readNanumsByShowId(showId, pageRequest), HttpStatus.OK);
    }

    // todo: url 매핑 다시 해야하고, DTO shows, nanums 두 개로 따로 만들어야 함

//    @GetMapping
//    public ResponseEntity<PageDTO> readNanumsByNanumTag(
//            @RequestParam(name = "tag") String nanumTagName,
//            @RequestParam(name = "page", defaultValue = "0") Integer page,
//            @RequestParam(name = "size", defaultValue = "20") Integer size) {
//        PageRequest pageRequest = PageRequest.of(page, size);
//        return new ResponseEntity<>(nanumService.readNanumsByNanumTag(nanumTagName, pageRequest), HttpStatus.OK);
//    }

    @GetMapping("/location")
    public ResponseEntity<PageDTO> readNanumsByLocation(
            @RequestParam(name = "lat") Double lat,
            @RequestParam(name = "lng") Double lng,
            @RequestParam(name = "page", defaultValue = "0") Integer page,
            @RequestParam(name = "size", defaultValue = "20") Integer size) {
        PageRequest pageRequest = PageRequest.of(page, size);
        return new ResponseEntity<>(nanumService.readNanumsByLocation(lat, lng, pageRequest), HttpStatus.OK);
    }

//    @PostMapping("/{nanumId}/info")
//    public ResponseEntity<>
}
