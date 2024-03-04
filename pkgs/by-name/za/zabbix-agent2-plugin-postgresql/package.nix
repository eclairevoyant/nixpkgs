{ lib, buildGoModule, fetchurl, pkg-config }:

buildGoModule rec {
  pname = "zabbix-agent2-plugin-postgresql";
  version = "6.0.25";

  src = fetchurl {
    url = "https://cdn.zabbix.com/zabbix-agent2-plugins/sources/postgresql/zabbix-agent2-plugin-postgresql-${version}.tar.gz";
    hash = "sha256-NFohopyUFO2C1k5moM4qkXX0Q9zc8W0Z+WrvZ5lgr1I=";
  };

  vendorHash = null;

  meta = with lib; {
    description = "Required tool for Zabbix agent integrated PostgreSQL monitoring";
    homepage = "https://www.zabbix.com/integrations/postgresql";
    license = licenses.asl20;
    maintainers = with maintainers; [ gador ];
    platforms = platforms.linux;
  };
}
