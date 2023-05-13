package nnz.userservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.*;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.Where;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.time.LocalDateTime;

@Entity
@Table(name = "shows")
@Where(clause = "is_delete = false")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@DynamicUpdate
@AllArgsConstructor
@Builder
@Getter
@ToString(of = {"id", "title"})
public class Show {

    @Id
    private Long id;

    private String title;
    private String location;
    private String startDate;
    private String endDate;
    private String ageLimit;

    @Column(length = 1000)
    private String posterImage;
    private boolean isDelete;
    private LocalDateTime updatedAt;

    public Show updateTitle(String title) {
        this.title = title;
        return this;
    }

    public Show updateLocation(String location) {
        this.location = location;
        return this;
    }

    public Show updateStartDate(String startDate) {
        this.startDate = startDate;
        return this;
    }

    public Show updateEndDate(String endDate) {
        this.endDate = endDate;
        return this;
    }

    public Show updateAgeLimit(String ageLimit) {
        this.ageLimit = ageLimit;
        return this;
    }

    public Show updatePosterImage(String posterImage) {
        this.posterImage = posterImage;
        return this;
    }

    public void update(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public void delete() {
        this.isDelete = true;
    }
}

