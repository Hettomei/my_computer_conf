openrc https://www.ovh.com/fr/publiccloud/guides/g1852.charger_les_variables_denvironnement_openstack

swift https://www.ovh.com/fr/publiccloud/guides/g1916.debuter_avec_lapi_swift

source /Users/tim/programmes/my_computer_conf/swift/openrc.sh
cd desktop
swift list
swift post angie # creer conteneur
swift upload angie Angie --changed
swift upload google-6p-fevrier-aout-2017 . --changed --segment-size 104857600