package uz.pdp.demo13.entity;


import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity

public class UserBook extends BaseEntity{

    @ManyToOne
    private Book book;

    @ManyToOne
    private User user;
}
