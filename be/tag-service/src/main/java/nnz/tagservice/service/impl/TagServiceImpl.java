package nnz.tagservice.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.eello.nnz.common.kafka.KafkaMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import nnz.tagservice.dto.NanumTagDTO;
import nnz.tagservice.dto.ShowTagDTO;
import nnz.tagservice.dto.TagDTO;
import nnz.tagservice.entity.*;
import nnz.tagservice.repository.*;
import nnz.tagservice.service.KafkaProducer;
import nnz.tagservice.service.TagService;
import nnz.tagservice.vo.TagVO;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class TagServiceImpl implements TagService {

    private final TagRepository tagRepository;
    private final NanumRepository nanumRepository;
    private final NanumTagRepository nanumTagRepository;
    private final ShowRepository showRepository;
    private final ShowTagRepository showTagRepository;
    private final KafkaProducer producer;

    @Override
    public void createTag(List<TagVO> tags) throws JsonProcessingException {

        for (TagVO tagVO : tags) {

            Optional<Tag> tag = tagRepository.findByTag(tagVO.getTag());

            if (!tag.isPresent()) {
                Tag newTag = Tag.builder()
                        .tag(tagVO.getTag())
                        .views(0)
                        .build();

                tag = Optional.of(tagRepository.save(newTag));
                log.info("tag = {}", tag.get());

                TagDTO tagDTO = TagDTO.of(tag.get());

                KafkaMessage<TagDTO> kafkaMessage = KafkaMessage.create().body(tagDTO);
                producer.sendMessage(kafkaMessage, "test-tag");
            }

            if (tagVO.getType().equals("nanum")) {
                createNanumTag(tagVO, tag);
            } //
            else {
                createShowTag(tagVO, tag);
            }
        }
    }

    private void createNanumTag(TagVO tagVO, Optional<Tag> tag) throws JsonProcessingException {
        List<Nanum> nanums = nanumRepository.findByTitleContaining(tagVO.getTitle());

        for (Nanum nanum : nanums) {
            // 공연 데이터를 받아오면 공연 태그 테이블에 값이 있는지 show 값과 tag 값으로 검색해본다.
            Optional<NanumTag> nanumTag = nanumTagRepository.findByNanumAndTag(nanum, tag.get());

            // 없으면 생성하고 있으면 그대로 둔다.
            if (!nanumTag.isPresent()) {
                NanumTag newNanumTag = NanumTag.builder()
                        .nanum(nanum)
                        .tag(tag.get())
                        .build();
                nanumTagRepository.save(newNanumTag);

                NanumTagDTO nanumTagDTO = NanumTagDTO.of(newNanumTag);

                KafkaMessage<NanumTagDTO> kafkaMessage = KafkaMessage.create().body(nanumTagDTO);
                producer.sendMessage(kafkaMessage, "test-nanum-tag");
            }
        }
    }

    private void createShowTag(TagVO tagVO, Optional<Tag> tag) throws JsonProcessingException {
        List<Show> shows = showRepository.findByTitleContaining(tagVO.getTitle());

        for (Show show : shows) {
            // 공연 데이터를 받아오면 공연 태그 테이블에 값이 있는지 show 값과 tag 값으로 검색해본다.
            Optional<ShowTag> showTag = showTagRepository.findByShowAndTag(show, tag.get());

            // 없으면 생성하고 있으면 그대로 둔다.
            if (!showTag.isPresent()) {
                ShowTag newShowTag = ShowTag.builder()
                        .show(show)
                        .tag(tag.get())
                        .build();
                showTagRepository.save(newShowTag);

                ShowTagDTO showTagDTO = ShowTagDTO.of(newShowTag);

                KafkaMessage<ShowTagDTO> kafkaMessage = KafkaMessage.create().body(showTagDTO);
                log.info("body : {}", kafkaMessage.getBody());
                producer.sendMessage(kafkaMessage, "test-show-tag");
            }
        }
    }
}
