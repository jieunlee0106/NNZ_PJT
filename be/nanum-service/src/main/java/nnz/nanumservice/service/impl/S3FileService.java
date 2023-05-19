package nnz.nanumservice.service.impl;

import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.ObjectMetadata;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class S3FileService {

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    private final AmazonS3Client amazonS3Client;

    public String getS3Url(MultipartFile image) {
        try {
            String fileName = image.getOriginalFilename();
            String savedName = UUID.randomUUID() + "-" + fileName;

            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentLength(image.getSize());
            metadata.setContentType(image.getContentType());

            amazonS3Client.putObject(bucket, savedName, image.getInputStream(), metadata);

            return amazonS3Client.getUrl(bucket, savedName).toString();
        } catch (IOException e) {
            // todo : error handling
        }
        return null;
    }
}
