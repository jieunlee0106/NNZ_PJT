package nnz.userservice.service;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class S3Service {

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    private final AmazonS3 amazonS3;

    public String uploadFile(MultipartFile file) throws IOException {
        if (file.isEmpty()) return null;

        String originalName = file.getOriginalFilename();
        String savedName = UUID.randomUUID() + "-" + originalName;

        ObjectMetadata objectMetadata = new ObjectMetadata();
        objectMetadata.setContentLength(file.getSize());
        objectMetadata.setContentType(file.getContentType());

        amazonS3.putObject(bucket, savedName, file.getInputStream(), objectMetadata);
        return amazonS3.getUrl(bucket, savedName).toString();
    }

    public void deleteFile(String s3FilePath) throws FileNotFoundException {
        boolean isExist = amazonS3.doesObjectExist(bucket, s3FilePath);
        if (isExist) {
            amazonS3.deleteObject(bucket, s3FilePath);
        } else {
            throw new FileNotFoundException("S3 Bucket에 해당 파일이 존재하지 않습니다.");
        }
    }
}
