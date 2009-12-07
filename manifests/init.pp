# modules/skeleton/manifests/init.pp - manage dovecot stuff
# Copyright (C) 2009 admin@immerda.ch
#

# we take rpms from fedora
class dovecot {
  include dovecot::base

  if $use_shorewall {
    include shorewall::rules::pop3
    include shorewall::rules::imap
  }

  if $use_munin {
    include dovecot::munin
  }
}
