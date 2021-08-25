### Remember to set ENV variable for mysql password when using local virtualbox provider. Otherwise a default password will be assigned<br />
bash:  export FACTER_PW=yourpassword<br />
win:   set FACTER_PW=yourpassword<br />

### Specify provider in command line argument: <br />
vagrant up --provider virtualbox<br />
vagrant up --provider digital_ocean
