package nnz.tagservice;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;

public class DevConfigEncrypter {

    public static void main(String[] args) {
        String url = "jdbc:mysql://k8b207.p.ssafy.io:3306/nnz_tag_dev_db?serverTimezone=Asia/Seoul&characterEncoding=UTF-8";
        String username = "nnzyu";
        String password = "sksjwnk8";
        String mmWebhookUrl = "https://meeting.ssafy.com/hooks/6feaskm9iprxdng6zm3bg5uwwa";
        String redisUrl = "redis";
        String kafkaBootstrapServers = "http://k8b207.p.ssafy.io:29092";
        String kafkaGroupId = "user-service-1";
        String kafkaTopic = "dev-user";
        String ncpAccessKey = "zevlDW0VbgfN2AFku2TE";
        String ncpSecretKey = "OmEY1QZxxbIZ2x5ggmuRw5w9QBUe2oi0yt2VJikQ";
        String ncpServiceId = "ncp:sms:kr:283247622877:nnz";
        String ncpFrom = "01063401270";
        String jwtSecret = "HM2J6xiSrB9LENGUcuArr5Ktn8F98HXuWOwIu0u15leIFYvAaTieLhgIbri0218mTh5uUCReeRklVgqzqBDLZqh3Km24KqE5oKc0UMcDmLZJ2m8JQwozL9QSDnLrXGiKzoA0OaEXHSbI3WABRoD7suk1FSuXdrAqHtU9nXE1fOdWiCcvUtnREZc9YvkA3OrYn6mDPJSbdSbzRcfqpmJtcHPK40QPUT5Jwi3rMHRTdg0d5tLcxFAAQktYMGexUrsg";
        String eureka = "http://dev-discovery-service:8761/eureka";

        String encryptUrl = jasyptEncrypt(url);
        String encryptUsername = jasyptEncrypt(username);
        String encryptPassword = jasyptEncrypt(password);
        String encryptMmWebhookUrl = jasyptEncrypt(mmWebhookUrl);
        String encryptRedisUrl = jasyptEncrypt(redisUrl);
        String encryptKafkaBootstrapServers = jasyptEncrypt(kafkaBootstrapServers);
        String encryptKafkaGroupId = jasyptEncrypt(kafkaGroupId);
        String encryptKafkaTopic = jasyptEncrypt(kafkaTopic);
        String encryptNcpAccessKey = jasyptEncrypt(ncpAccessKey);
        String encryptSecretKey = jasyptEncrypt(ncpSecretKey);
        String encryptServiceId = jasyptEncrypt(ncpServiceId);
        String encryptNcpFrom = jasyptEncrypt(ncpFrom);
        String encryptJwtSecret = jasyptEncrypt(jwtSecret);
        String encryptEureka = jasyptEncrypt(eureka);

        System.out.println("====================================");
        System.out.println(url.equals(jasyptDecryt(jasyptEncrypt(url))));
        System.out.println("====================================");

        System.out.println("encryptUrl : " + encryptUrl);
        System.out.println("encryptUsername : " + encryptUsername);
        System.out.println("encryptPassword: " + encryptPassword);
        System.out.println("encryptMmWebhookUrl = " + encryptMmWebhookUrl);
        System.out.println("encryptRedisUrl = " + encryptRedisUrl);
        System.out.println("encryptKafkaBootstrapServers = " + encryptKafkaBootstrapServers);
        System.out.println("encryptKafkaGroupId = " + encryptKafkaGroupId);
        System.out.println("encryptKafkaTopic = " + encryptKafkaTopic);
        System.out.println("encryptNcpAccessKey = " + encryptNcpAccessKey);
        System.out.println("encryptSecretKey = " + encryptSecretKey);
        System.out.println("encryptServiceId = " + encryptServiceId);
        System.out.println("encryptNcpFrom = " + encryptNcpFrom);
        System.out.println("encryptJwtSecret = " + encryptJwtSecret);
        System.out.println("encryptEureka = " + encryptEureka);
    }

    private static String jasyptEncrypt(String input) {
        String key = "sksjwnb207";
        StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
        encryptor.setAlgorithm("PBEWithMD5AndDES");
        encryptor.setPassword(key);
        return encryptor.encrypt(input);
    }

    private static String jasyptDecryt(String input){
        String key = "sksjwnb207";
        StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
        encryptor.setAlgorithm("PBEWithMD5AndDES");
        encryptor.setPassword(key);
        return encryptor.decrypt(input);
    }
}