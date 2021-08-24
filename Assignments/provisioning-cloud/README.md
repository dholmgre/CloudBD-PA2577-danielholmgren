1. Remember to set ENV variable for mysql password when using local virtualbox provider. Otherwise a default password will be assigned
bash:  export FACTER_PW=yourpassword
win:   set FACTER_PW=yourpassword

2. Specify provider in command line argument:
vagrant up --provider virtualbox
vagrant up --provider digital_ocean
