package ronte.dao;

import org.springframework.stereotype.Component;
import ronte.model.Account;

import java.util.ArrayList;
import java.util.List;


@Component
public class AccountDAO {

    private static List<Account> accountList;
    {
        accountList = new ArrayList();
        accountList.add(new Account(101, "AccountDetails1"));
        accountList.add(new Account(201, "AccountDetails2"));
        accountList.add(new Account(301, "AccountDetails3"));
        accountList.add(new Account(System.currentTimeMillis(), "AccountDetails4"));
    }

    /**
     * возвращает список счёт
     *
     * @return список всех счёт
     */
    public List<Account> getAccountList() {
        return accountList;
    }

    /**
     * выдает Account по идентификатору или null.
     *
     * @param id идентификатор счёта
     * @return выдает Account по идентификатору
     */
    public Account get(Long id) {
        return getAccountList().stream().filter((x) -> x.getId().equals(id) ).findFirst().orElseGet(null);
    }

    /**
     * создание счёта и возврат его обновленного, по сути присвоение id значения и запись в список
     *
     * @param account объекта Account
     * @return объект Account с обновленным id
     */
    public Account create(Account account) {
        account.setId(System.currentTimeMillis());
        getAccountList().add(account);
        return account;
    }

    /**
     * Удаление счёта по его идентификатору, если не найдёт то возвратит null
     *
     * @param id счёт объекта Account
     * @return счёт объекта Account
     */
    public Account delete(Long id) {

        Account accountDelete = getAccountList().stream().filter((x) -> x.getId().equals(id) ).findFirst().orElseGet(null);

        if (accountDelete != null) {
            getAccountList().remove(accountDelete);
            return accountDelete;
        } else {
            return null;
        }
    }

    /**
     * обновление данных счёта по идентификатору, если не найдёт, то возвращает null
     *
     * @param accountUpdate объект Account
     * @return счёт объект Account
     */
    public Account update(Account accountUpdate) {

        if (accountUpdate == null || accountUpdate.getId() == null ){
            return null;
        }

        Account account = getAccountList().stream().filter((x) -> x.getId().equals(accountUpdate.getId()) ).findFirst().orElseGet(null);
        account.update(accountUpdate);
        return account;
    }

}