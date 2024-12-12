package uz.pdp.demo13.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "users")

public class User extends BaseEntity{
        @NotBlank(message = "firstName bo'sh")
        private String firstName;

        @NotBlank(message = "lastName bo'sh")
        private String lastName;

        @NotBlank( message = "email bo'sh bo'lmasin")
        @Column(unique = true, nullable = false)
        @Email(message = "email formatini to'g'ri kiriting")
        private String email;

        @Column(nullable = false)
        @Size(min = 8, max = 16, message = "parol 8 dan 16 gacha oraliqda bo'lsin")
        private String password;

        private String tempCode;

        private String status = "out";

        private String role = "USER";

        public User(String email, String password) {
            this.email = email;
            this.password = password;
        }

        public User(String firstName, String lastName, String email, String password) {
                this.firstName = firstName;
                this.lastName = lastName;
                this.email = email;
                this.password = password;
        }

        public User(String firstName, String lastName, String email, String password, String tempCode) {
                this.firstName = firstName;
                this.lastName = lastName;
                this.email = email;
                this.password = password;
                this.tempCode = tempCode;
        }

        public User(String firstName, String lastName, String email, String password, String tempCode, String status) {
                this.firstName = firstName;
                this.lastName = lastName;
                this.email = email;
                this.password = password;
                this.tempCode = tempCode;
                this.status = status;
        }
}
