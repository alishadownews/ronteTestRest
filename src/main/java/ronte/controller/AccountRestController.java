package ronte.controller;

import ronte.dao.AccountDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ronte.model.Account;

import java.util.List;


@RestController
public class AccountRestController {
    final String NO_ACCOUNT_WITH_THIS_ID = "Нет счёта с таким идентификатором ";


	@Autowired
	private AccountDAO accountDAO;




    /**
     * возвращает список счетов
     *
     * @return список всех счетов
     */
	@CrossOrigin()
	@GetMapping("/accounts")
	public List<Account> getAccounts() {
		return accountDAO.getAccountList();
	}

    /**
     * выдает Account по идентификатору или null.
     *
     * @param id идентификатор счёта
     * @return выдает Account по идентификатору
     */
	@CrossOrigin()
	@GetMapping("/account/{id}")
	public ResponseEntity getAccount(@PathVariable("id") Long id) {

		Account account = accountDAO.get(id);
		if (account == null) {
			return new ResponseEntity(NO_ACCOUNT_WITH_THIS_ID + id, HttpStatus.NOT_FOUND);
		}

		return new ResponseEntity(account, HttpStatus.OK);
	}

    /**
     * создание счёта и возврат его обновленного, по сути присвоение id значения и запись в список
     *
     * @param account счёт объекта Account
     * @return объект Account с обновленным id
     */
	@CrossOrigin()
    @PostMapping(value = "/account")
	public ResponseEntity createAccount(@RequestBody Account account) {

		accountDAO.create(account);

		return new ResponseEntity(account, HttpStatus.OK);
	}

    /**
     * Удаление счёта по его идентификатору, если не найдёт то возвратит null
     *
     * @param id счёт объекта Account
     * @return счёт объекта Account
     */
	@CrossOrigin()
	@DeleteMapping("/accounts/{id}")
	public ResponseEntity deleteCustomer(@PathVariable Long id) {

		if (null == accountDAO.delete(id)) {
			return new ResponseEntity(NO_ACCOUNT_WITH_THIS_ID + id, HttpStatus.NOT_FOUND);
		}

		return new ResponseEntity(id, HttpStatus.OK);

	}


    /**
     * обновление данных счёта по идентификатору, если не найдёт, то возвращает null
     *
     * @param account объект Account
     * @return account объект Account
     */
	@CrossOrigin()
    @PutMapping("/accounts")
	public ResponseEntity updateAccount(@RequestBody Account account) {

		Account accountUpdate = accountDAO.update(account);

		if (null == accountUpdate) {
			return new ResponseEntity(NO_ACCOUNT_WITH_THIS_ID + account.getId().toString(), HttpStatus.NOT_FOUND);
		}

		return new ResponseEntity(accountUpdate, HttpStatus.OK);
	}

}