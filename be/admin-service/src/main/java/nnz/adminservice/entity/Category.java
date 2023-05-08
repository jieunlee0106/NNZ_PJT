package nnz.adminservice.entity;

import io.github.eello.nnz.common.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "categories")
@Where(clause = "is_delete  = 0")
public class Category extends BaseEntity {

    @Id
    String code;

    String name;

    String parentCode;
}

