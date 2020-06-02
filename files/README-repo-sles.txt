Thu May 28 15:38:12 PDT 2020
eric.griswold

Because of SLES' inability to deal with multiple keys, we've broken puppet*-repo.txt files
into "repo" and "sles" versions. They are identical except for the sles versions only permitted
one GPG key at a time.

This is annoying when keys need to be updated but isolating the SLES problem seemed fitting.

