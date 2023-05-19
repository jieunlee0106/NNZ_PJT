package nnz.userservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import nnz.userservice.dto.MessageDTO;
import nnz.userservice.dto.SmsResponseDTO;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

public interface SmsSender {

    SmsResponseDTO sendMessage(MessageDTO messageDTO) throws UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException, JsonProcessingException, URISyntaxException;
}
