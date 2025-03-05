# README

Spin up the project:

The project has been containerized, so just need docker on your machine and then run:

```
make start
make setup-db
make seed-db
```

If you want to play with the API, please refer to the Postman collection sent by email.

Some design considerations:

- The return fee is just 1.
- Negative balance is a possible scenario. This could be improved if we tried to compute at run time or using counter_cache the  number of books a user needs to return when its trying to borrow another book and compare that to remaining balance.

````
(account.balance - ((borrowed_books * RETURN_FEE) + RETURN_FEE) > 0
````


Things that need to be improved:

- Add more unit tests
- Add simplecov for code coverage analysis.
- Add rubocop as a code analyzer  and code formatter.
- Add swagger docs for api documentation
- Add rails-erd to generate a diagram.
