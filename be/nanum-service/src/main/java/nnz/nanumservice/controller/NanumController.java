package nnz.nanumservice.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.dto.PageDTO;
import io.github.eello.nnz.common.jwt.DecodedToken;
import lombok.RequiredArgsConstructor;
import nnz.nanumservice.dto.FcmNotificationDTO;
import nnz.nanumservice.dto.NanumInfoDTO;
import nnz.nanumservice.dto.res.nanum.ResNanumDTO;
import nnz.nanumservice.dto.res.nanum.ResNanumDetailDTO;
import nnz.nanumservice.entity.NanumStock;
import nnz.nanumservice.service.CertificationService;
import nnz.nanumservice.service.NanumService;
import nnz.nanumservice.service.impl.FCMService;
import nnz.nanumservice.service.impl.NcpPushNotificationService;
import nnz.nanumservice.vo.NanumCertificationVO;
import nnz.nanumservice.vo.NanumVO;
import nnz.nanumservice.vo.NcpDeviceVO;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

@RestController
@RequestMapping("/nanum-service/nanums")
@RequiredArgsConstructor
public class NanumController {

    private final NanumService nanumService;
    private final CertificationService certificationService;
    private final FCMService fcmService;
    private final NcpPushNotificationService ncpPushNotificationService;

    @PostMapping
    public ResponseEntity<Void> createNanum(
            @RequestPart(name = "data") NanumVO data,
            @RequestPart(name = "images") List<MultipartFile> images
    ) {
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
            @RequestBody NanumInfoDTO nanumInfoDTO) {
        nanumService.createNanumInfo(nanumId, nanumInfoDTO);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @GetMapping("/{nanumId}/info")
    public ResponseEntity<NanumInfoDTO> createNanumInfo(@PathVariable(name = "nanumId") Long nanumId) {
        return new ResponseEntity<>(nanumService.readNanumInfo(nanumId), HttpStatus.OK);
    }

    @GetMapping("/{nanumId}")
    public ResponseEntity<ResNanumDetailDTO> readNanumDetail(
            @PathVariable(name = "nanumId") Long nanumId,
            DecodedToken userToken) {
        return new ResponseEntity<>(nanumService.readNanumDetail(nanumId, userToken.getId()), HttpStatus.OK);
    }

    @PostMapping("/{nanumId}/certification")
    public ResponseEntity<?> handleNanumCertification(@PathVariable("nanumId") Long nanumId,
                                                 @RequestBody NanumCertificationVO nanumCertificationVO){
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
            DecodedToken userToken) {
        if (userToken.getId() == null) {
//            todo : error handling
//            throw new Exception();
        }
        nanumService.createUserNanum(nanumId, userToken.getId());
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @GetMapping("/popular")
    public ResponseEntity<List<ResNanumDTO>> readPopularNanums() {
        return new ResponseEntity<>(nanumService.readPopularNaums(), HttpStatus.OK);
    }

    @GetMapping("/push")
    public ResponseEntity<?> testNotifictaion() throws IOException, NoSuchAlgorithmException, URISyntaxException, InvalidKeyException {
//        fcmService.sendMessage(fcmNotificationDTO);
//        fcmService.sendMessgeTo(fcmNotificationDTO);
//        fcmService.chatgpt(fcmNotificationDTO);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/ncp/push/sendMessage/{id}")
    public ResponseEntity<?> sendMessage(@PathVariable("id") Long id) throws UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException, InvalidKeyException, JsonProcessingException {
        ncpPushNotificationService.sendNcpPush(id);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/ncp/push/registDevice")
    public ResponseEntity<?> registDevice(@RequestBody NcpDeviceVO ncpDeviceVO) throws UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException, InvalidKeyException, JsonProcessingException {
        ncpPushNotificationService.registDevice(ncpDeviceVO);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/ncp/push/deleteDevice/{userId}")
    public ResponseEntity<?> deleteDevice(@PathVariable("userId") Long id) throws UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException, InvalidKeyException, JsonProcessingException {
        ncpPushNotificationService.deleteDevice(id);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/ncp/push/getDevice/{userId}")
    public ResponseEntity<?> getDevice(@PathVariable("userId") Long id) throws UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException, InvalidKeyException, JsonProcessingException {
        return ResponseEntity.ok(ncpPushNotificationService.getDevice(id));
    }

    @GetMapping("/ncp/push/sendMessage/{id}")
    public ResponseEntity<?> resultMessage(@PathVariable("id") String id) throws UnsupportedEncodingException, NoSuchAlgorithmException, URISyntaxException, InvalidKeyException, JsonProcessingException {
        return ResponseEntity.ok(ncpPushNotificationService.resultMessage(id));
    }
}
