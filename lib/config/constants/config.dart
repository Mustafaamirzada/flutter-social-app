// ignore_for_file: constant_identifier_names
const String localhost = '127.0.0.1';
const String remotehost = '192.168.0.103';

class Config {
  static const String BaseUrl = "http://$remotehost:8000/api";
  static const String Basev1Url = "http://$remotehost:8000/api/v1";
}