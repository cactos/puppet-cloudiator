# Class: cactos_cloudiator
# ===========================
#
# Installs cloudiator
#
# Parameters
# ----------
#
# * `mysql_col_name`
# Username for the colosseum database
#
# * `mysql_col_pw`
# Password for the $mysql_col_name databse user
#
# * `mysql_root_pw`
# Password for the mysql root user
#
# * `mysql_root_pw`
# Database prefix for the colosseum database
#
# * `col_secret`
# Secure hash for colosseum
#
# Examples
# --------
#
# @example
#    class { 'cactos_cloudiator':
#      mysql_col_name  = "colosseum"
#      mysql_col_pw    = "changeme"
#      mysql_root_pw   = "changeme"
#      col_secret      = "change_me_sandlandnpoj33qkpsajfdpjd30jd"
#      col_prefix      = "cts"
#    }
#
# Authors
# -------
#
# Simon Volpert <simon.volpert@uni-ulm.de>
#

class cactos_cloudiator(
  String $mysql_col_name = $cactos_cloudiator::params::mysql_col_name,
  String $mysql_col_pw   = $cactos_cloudiator::params::mysql_col_pw,
  String $mysql_root_pw  = $cactos_cloudiator::params::mysql_root_pw,
  String $col_secret     = $cactos_cloudiator::params::col_secret,
  String $col_prefix     = $cactos_cloudiator::params::col_prefix
)inherits cactos_cloudiator::params {


  contain cactos_cloudiator::install
  contain cactos_cloudiator::config
  contain cactos_cloudiator::service
  Class['::cactos_cloudiator::install']->
  Class['::cactos_cloudiator::config']->
  Class['::cactos_cloudiator::service']






} 

