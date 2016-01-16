#
# Vagrant Aliases
#

#
# Varying Vagrant Vagrants
#

# VVV (www folder)
vag() {
	cd $VAGRANT/www
}

# WordPress Default
vvvd() {
	vag
	cd wordpress-default
}

# WordPress Trunk
vvvt() {
	vag
	cd wordpress-trunk
}

# WordPress Dev
vvvv() {
	vag
	cd wordpress-develop
}

alias vu="vag && sudo vagrant up"
alias vh="vag && sudo vagrant halt"
alias vs="vag && vagrant status"