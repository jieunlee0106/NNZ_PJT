package nnz.userservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.userservice.entity.Bookmark;

import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class BookmarkSyncDTO {

    private Long id;
    private Long userId;
    private Long nanumId;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private Boolean isDelete;

    public static BookmarkSyncDTO of(Bookmark bookmark) {
        return BookmarkSyncDTO.builder()
                .id(bookmark.getId())
                .userId(bookmark.getUser().getId())
                .nanumId(bookmark.getNanum().getId())
                .createdAt(bookmark.getCreatedAt())
                .updatedAt(bookmark.getUpdatedAt())
                .build();
    }
}
