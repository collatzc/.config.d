#! /bin/sed -nf
/^server\s*{/, /^}/ {
  /^.*listen/ {
    s/^.*listen\s*\(.*\);/ * port - \1/
    H
  }
  /~ \\\.php\$/ {
    s/.*~ \\\.php\$.*/ * php support/
    H
  }
  /proxy_pass.*/ {
    s/.*proxy_pass\s*\(.*\);/ * proxy - \1/
    H
  }
  s/.*server_name\s*\([^;]*\);.*/\n\[\1\]/p
  /^\}$/ {
    z;x;p
  }
}
