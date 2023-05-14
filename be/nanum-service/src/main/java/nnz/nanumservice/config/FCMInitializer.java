package nnz.nanumservice.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import io.github.eello.nnz.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Slf4j
//@Component
public class FCMInitializer {

    @PostConstruct
    public void initialize(){
        ClassPathResource resource = new ClassPathResource("naneozoo-firebase-adminsdk-5cna1-e73447ff78.json");

        try(InputStream stream = resource.getInputStream()){
            FirebaseOptions options = FirebaseOptions.builder()
                    .setCredentials(GoogleCredentials.fromStream(stream))
                    .build();

            if(FirebaseApp.getApps().isEmpty()){
                FirebaseApp.initializeApp(options);
                log.info("Firebase App Initialization SUCCESS");
            }
        }catch (Exception e){
            throw new RuntimeException(HttpStatus.INTERNAL_SERVER_ERROR.toString());
        }
    }

    private String getAccessToken() throws IOException {
        ClassPathResource resource = new ClassPathResource("naneozoo-firebase-adminsdk-5cna1-e73447ff78.json");

        GoogleCredentials googleCredentials = GoogleCredentials.fromStream(resource.getInputStream())
                .createScoped(List.of("https://www.googleapis.com/auth/cloud-platform"));

        googleCredentials.refreshIfExpired();
        return googleCredentials.getAccessToken().getTokenValue();
    }
}
