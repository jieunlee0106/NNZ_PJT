package nnz.tagservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@SpringBootApplication
@EnableEurekaClient
public class TagServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(TagServiceApplication.class, args);
    }

}
