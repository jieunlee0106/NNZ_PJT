package nnz.nanumservice.service.impl;

import lombok.RequiredArgsConstructor;
import nnz.nanumservice.dto.NanumDTO;
import nnz.nanumservice.dto.NanumImageDTO;
import nnz.nanumservice.entity.Nanum;
import nnz.nanumservice.entity.NanumImage;
import nnz.nanumservice.repository.NanumImageRepository;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Component
@RequiredArgsConstructor
public class NanumImageService {

    private final S3FileService s3FileService;
    private final NanumImageRepository nanumImageRepository;

    public void createNanumImage(Nanum nanum, List<NanumImageDTO> nanumImageDTOs, NanumDTO nanumDTO, List<MultipartFile> images) {
        Boolean isThumbnail = true;
        for (MultipartFile image : images) {
            String path = s3FileService.getS3Url(image);
            String originalName = image.getOriginalFilename();

            NanumImage nanumImage = NanumImage.builder()
                    .path(path)
                    .originalName(originalName)
                    .isThumbnail(isThumbnail)
                    .nanum(nanum)
                    .build();
            nanumImageRepository.save(nanumImage);

            nanumImageDTOs.add(NanumImageDTO.of(nanumImage));

            if (isThumbnail) {
                nanum.updateThumbnail(path);
                nanumDTO.setThumbnail(path);
            }
            isThumbnail = false;
        }
    }
}
