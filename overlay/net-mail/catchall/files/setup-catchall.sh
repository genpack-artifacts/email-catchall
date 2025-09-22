#!/bin/sh
set -e

# postfix
echo '/.*@.*/ mail' > /etc/postfix/virtual
echo "virtual_alias_maps = pcre:/etc/postfix/virtual" >> /etc/postfix/main.cf
postmap /etc/postfix/virtual
echo '// .' > /etc/postfix/any_destination
echo "mydestination = pcre:/etc/postfix/any_destination" >> /etc/postfix/main.cf
postmap /etc/postfix/any_destination
sed -i 's/^inet_protocols = .*/inet_protocols = all/' /etc/postfix/main.cf
sed -i 's/^mail:\(.*\)/#mail:\1/' /etc/mail/aliases
newaliases

# dovecot
sed -i 's/^#first_valid_uid =.*/first_valid_uid = 0/' /etc/dovecot/conf.d/10-mail.conf
sed -i 's/^#disable_plaintext_auth = .*/disable_plaintext_auth = no/' /etc/dovecot/conf.d/10-auth.conf
sed -i 's/^!include auth-/#!include auth-/' /etc/dovecot/conf.d/10-auth.conf
echo '!include auth-catchall.conf.ext' >> /etc/dovecot/conf.d/10-auth.conf
cat << 'EOS' > /etc/dovecot/conf.d/auth-catchall.conf.ext
passdb {
  driver = static
  args = nopassword=y
}

userdb {
  driver = static
  args = uid=mail gid=mail home=/var/spool/mail
}
EOS
rm /etc/dovecot/conf.d/10-ssl.conf

systemctl enable postfix dovecot