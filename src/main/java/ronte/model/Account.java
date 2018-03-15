package ronte.model;

import lombok.*;



@NoArgsConstructor
@ToString(exclude="id")
@EqualsAndHashCode(exclude="id")
public class Account {

    @Getter
    @Setter
    private Long id;
    @Getter
    @Setter
    private String accountDetails;

    public Account(long id, String accountDetails) {
        this.id = id;
        update(accountDetails);
    }

    public void update(String accountDetails) {
        this.accountDetails = accountDetails;
    }

    public void update(Account account){
        this.accountDetails = account.accountDetails;
    }

}
