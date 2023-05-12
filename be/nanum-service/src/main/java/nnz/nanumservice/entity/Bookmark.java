package nnz.nanumservice.entity;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.nanumservice.dto.BookmarkDTO;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "bookmarks")
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Bookmark {

    @Id
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "nanum_id")
    private Nanum nanum;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime updatedAt;

    private boolean isDelete;

    public static Bookmark of(BookmarkDTO bookmarkDTO, Nanum nanum, User user) {
        return Bookmark.builder()
                .id(bookmarkDTO.getId())
                .nanum(nanum)
                .user(user)
                .updatedAt(bookmarkDTO.getUpdatedAt())
                .build();
    }

    public void updateBookmark(BookmarkDTO bookmarkDTO, Nanum nanum, User user) {
        this.id = bookmarkDTO.getId();
        this.nanum = nanum;
        this.user = user;
        this.updatedAt = bookmarkDTO.getUpdatedAt();
    }

    public void deleteBookmark() {
        this.isDelete = true;
    }
}
