package nnz.nanumservice.controller;

import com.google.firebase.messaging.FirebaseMessagingException;

import io.github.eello.nnz.common.dto.PageDTO;
import io.github.eello.nnz.common.jwt.DecodedToken;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.nanumservice.dto.CertificationDTO;
import nnz.nanumservice.dto.NanumInfoDTO;
import nnz.nanumservice.dto.res.ResNanumStockDTO;
import nnz.nanumservice.dto.res.nanum.ResNanumDTO;
import nnz.nanumservice.dto.res.nanum.ResNanumDetailDTO;
import nnz.nanumservice.dto.res.search.ResSearchDTO;
import nnz.nanumservice.dto.res.tag.ResTagDTO;
import nnz.nanumservice.entity.NanumStock;
import nnz.nanumservice.service.CertificationService;
import nnz.nanumservice.service.NanumService;
import nnz.nanumservice.service.TagService;
import nnz.nanumservice.service.impl.FCMService;
import nnz.nanumservice.vo.NanumCertificationVO;
import nnz.nanumservice.vo.NanumVO;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/nanum-service/nanums")
@RequiredArgsConstructor
public class NanumController {

    private final NanumService nanumService;
    private final CertificationService certificationService;
    private final TagService tagService;
    private final FCMService fcmService;

    @PostMapping
    public ResponseEntity<Void> createNanum(
            @RequestPart(name = "data") NanumVO data,
            @RequestPart(name = "images") List<MultipartFile> images
    ) throws FirebaseMessagingException {
        data.decode();
        nanumService.createNanum(data, images);
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

    @GetMapping("/tag")
    public ResponseEntity<PageDTO> readNanumsByNanumTag(
            @RequestParam(name = "tag") String nanumTagName,
            @RequestParam(name = "page", defaultValue = "0") Integer page,
            @RequestParam(name = "size", defaultValue = "20") Integer size) {
        PageRequest pageRequest = PageRequest.of(page, size);
        return new ResponseEntity<>(nanumService.readNanumsByNanumTag(nanumTagName, pageRequest), HttpStatus.OK);
    }

    @GetMapping("/location")
    public ResponseEntity<PageDTO> readNanumsByLocation(
            @RequestParam(name = "lat") Double lat,
            @RequestParam(name = "lng") Double lng,
            @RequestParam(name = "page", defaultValue = "0") Integer page,
            @RequestParam(name = "size", defaultValue = "20") Integer size) {
        PageRequest pageRequest = PageRequest.of(page, size);
        return new ResponseEntity<>(nanumService.readNanumsByLocation(lat, lng, pageRequest), HttpStatus.OK);
    }

    @PostMapping("/{nanumId}/info")
    public ResponseEntity<Void> createNanumInfo(
            @PathVariable(name = "nanumId") Long nanumId,
            @RequestBody NanumInfoDTO nanumInfoDTO) throws FirebaseMessagingException {
        nanumService.createNanumInfo(nanumId, nanumInfoDTO);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @GetMapping("/{nanumId}/info")
    public ResponseEntity<NanumInfoDTO> createNanumInfo(
            @PathVariable(name = "nanumId") Long nanumId,
            DecodedToken userToken) {
        return new ResponseEntity<>(nanumService.readNanumInfo(nanumId, userToken.getId()), HttpStatus.OK);
    }

    @GetMapping("/{nanumId}")
    public ResponseEntity<ResNanumDetailDTO> readNanumDetail(
            @PathVariable(name = "nanumId") Long nanumId,
            DecodedToken userToken) {
        return new ResponseEntity<>(nanumService.readNanumDetail(nanumId, userToken.getId()), HttpStatus.OK);
    }

    @PostMapping("/{nanumId}/certification")
    public ResponseEntity<?> handleNanumCertification(@PathVariable("nanumId") Long nanumId,
                                                 @RequestBody NanumCertificationVO nanumCertificationVO) throws FirebaseMessagingException {
        certificationService.handleNanumCertification(nanumId, nanumCertificationVO);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/{nanumId}/qr/{receiveId}")
    public ResponseEntity<?> certifyQRCode(@PathVariable("nanumId") Long nanumId,
                                           @PathVariable("receiveId") Long receiveId){
        NanumStock nanumStock = certificationService.certifyQRCode(nanumId, receiveId);
        return ResponseEntity.ok(nanumStock);
    }

    @PostMapping("/{nanumId}")
    public ResponseEntity<Void> createUserNanum(
            @PathVariable(name = "nanumId") Long nanumId,
            @RequestPart(value = "image", required = false) MultipartFile file,
            DecodedToken userToken) {
        nanumService.createUserNanum(nanumId, userToken.getId(), file);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @GetMapping("/popular")
    public ResponseEntity<List<ResNanumDTO>> readPopularNanums() {
        return new ResponseEntity<>(nanumService.readPopularNaums(), HttpStatus.OK);
    }

    @GetMapping("/{nanumId}/certification")
    public ResponseEntity<?> findCertificationList(@PathVariable("nanumId") Long nanumId){
        List<CertificationDTO> certList = certificationService.findCertificationList(nanumId);
        return ResponseEntity.ok(certList);
    }

    @GetMapping("/{nanumId}/quantity")
    public ResponseEntity<ResNanumStockDTO> readNanumStock(@PathVariable(name = "nanumId") Long nanumId) {
        return new ResponseEntity<>(nanumService.readNanumStock(nanumId), HttpStatus.OK);
    }

    @PatchMapping("/{nanumId}")
    public ResponseEntity<Void> updateNanum(
            @PathVariable(name = "nanumId") Long id,
            DecodedToken userToken,
            @RequestPart(name = "data") NanumVO data,
            @RequestPart(name = "images", required = false) List<MultipartFile> images) {
        nanumService.updateNanum(id, userToken.getId(), data, images);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @GetMapping("/search")
    public ResponseEntity<ResSearchDTO> searchNanum(@RequestParam("q") String q, Pageable pageable) {
        return new ResponseEntity<>(nanumService.searchNanum(q, pageable), HttpStatus.OK);
    }

    @GetMapping("/tag/related")
    public ResponseEntity<List<ResTagDTO>> readNanumTagByNanum(
            @RequestParam("showIds") List<Long> showIds,
            @RequestParam("count") Integer count) {
        return new ResponseEntity<>(tagService.readPopularRelatedNanumTagByShow(showIds, count), HttpStatus.OK);
    }

    @GetMapping("/push/open")
    public ResponseEntity<?> sendBookmarkNanumOpenPush() throws IOException, NoSuchAlgorithmException, URISyntaxException, InvalidKeyException, FirebaseMessagingException {
        fcmService.sendBookmarkNanumOpenPush();
        return ResponseEntity.ok().build();
    }

    @GetMapping("/push/receive")
    public ResponseEntity<?> sendReceiveNanumPush() throws IOException, NoSuchAlgorithmException, URISyntaxException, InvalidKeyException, FirebaseMessagingException {
        fcmService.sendReceiveNanumPush();
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{nanumId}")
    public ResponseEntity<Void> deleteNanum(@PathVariable(name = "nanumId") Long id, DecodedToken userToken){
        nanumService.deleteNanum(id, userToken.getId());
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
