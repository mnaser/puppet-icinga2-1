# == Defined type: icinga2::object::user
#
#  This is a defined type for Icinga 2 user objects.
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/configuring-icinga2#objecttype-user
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::user (
  $object_username = $name,
  $display_name = $name,
  $email = undef,
  $pager = undef,
  $vars = {},
  $groups = [],
  $enable_notifications = undef,
  $period = undef,
  $types = [],
  $states = [],
  $target_dir = '/etc/icinga2/conf.d',
  $target_file_name = "${name}.conf",
  $target_file_owner = 'root',
  $target_file_group = 'root',
  $target_file_mode = '644'
) {

  #Do some validation of the class' parameters:
  validate_string($object_username)
  validate_string($display_name)
  validate_string($host_name)
  validate_array($groups)
  validate_hash($vars)
  validate_array($types)
  validate_array($states)
  validate_string($target_dir)
  validate_string($target_file_name)
  validate_string($target_file_owner)
  validate_string($target_file_group)
  validate_string($target_file_mode)

  file {"${target_dir}/${target_file_name}":
    ensure => file,
    owner   => $target_file_owner,
    group   => $target_file_group,
    mode    => $target_file_mode,
    content => template('icinga2/object_user.conf.erb'),
    notify => Service['icinga2'],
  }

}
