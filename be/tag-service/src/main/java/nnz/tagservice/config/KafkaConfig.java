package nnz.tagservice.config;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.tagservice.repository.TagRepository;
import nnz.tagservice.service.KafkaConsumer;
import nnz.tagservice.service.KafkaDevConsumer;
import nnz.tagservice.service.KafkaProdConsumer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Slf4j
@Configuration
@RequiredArgsConstructor
public class KafkaConfig {

    @Value("${spring.profiles.active}")
    private String activeProfile;

    private final TagRepository tagRepository;

    @Bean
    public KafkaConsumer kafkaConsumer() {
        log.info("active profile: {}", activeProfile);
        if ("local".equals(activeProfile) || "dev".equals(activeProfile)) {
            log.info("-> create KafkaConsumer: {}", KafkaDevConsumer.class);
            return new KafkaDevConsumer(tagRepository);
        } else {
            log.info("-> create KafkaConsumer: {}", KafkaProdConsumer.class);
            return new KafkaProdConsumer(tagRepository);
        }
    }
}
