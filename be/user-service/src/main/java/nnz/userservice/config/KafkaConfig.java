package nnz.userservice.config;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.userservice.kafka.consumer.KafkaMessageHandler;
import nnz.userservice.kafka.consumer.KafkaConsumer;
import nnz.userservice.kafka.consumer.KafkaDevConsumer;
import nnz.userservice.kafka.consumer.KafkaLocalConsumer;
import nnz.userservice.kafka.consumer.KafkaProdConsumer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Slf4j
@Configuration
@RequiredArgsConstructor
public class KafkaConfig {

    @Value("${spring.profiles.active}")
    private String activeProfile;

    private final KafkaMessageHandler handler;

    @Bean
    public KafkaConsumer kafkaConsumer() {
        log.info("active profile: {}", activeProfile);
        if ("local".equals(activeProfile)) {
            log.info("-> create KafkaConsumer: {}", KafkaLocalConsumer.class);
            return new KafkaLocalConsumer(handler);
        } else if ("dev".equals(activeProfile)) {
            log.info("-> create KafkaConsumer: {}", KafkaDevConsumer.class);
            return new KafkaDevConsumer(handler);
        } else {
            log.info("-> create KafkaConsumer: {}", KafkaProdConsumer.class);
            return new KafkaProdConsumer(handler);
        }
    }
}
