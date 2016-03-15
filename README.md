# [Samfundet.no](http://samfundet.no)
![](http://i.imgur.com/8n5hDoC.png)

## Contributing

### Bug Reports and Feature Requests

Use the [issue tracker](https://github.com/Samfundet/Samfundet/issues) to report any bugs or request features.

### Developing

PRs are welcome. Follow these steps to set the website up locally:

1. Install Ruby on Rails.
2. Run ```make copy-config-files``` and choose a password for the samfdb_dev database in ```config/database.yml```.
3. Install Postgres. Ubuntu example: ```sudo apt-get install libpq-dev```.
4. Switch to the Postgres user: ```sudo su postgres``` and run ```psql```.
5. Run ```create user samf with password 'the_password_you_chose_in_step_2';``` and then ```ALTER USER samf CREATEDB;```.
6. Exit postgres by ```\q``` and CTRL-D.
6. Seed the database: ```rake db:seed```.
7. To start the rails server, run the following command: ```rails server```. The website will be running on port 3000. For automatic reloading on filechange, run the following command in a separate terminal: ```rails guard```.

## License

MIT © [Studentersamfundet i Trondhjem](https://www.samfundet.no/)
