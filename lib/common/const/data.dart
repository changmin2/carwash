import 'dart:io';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

//애뮬레이터 로컬
final emulatorIp = '10.0.2.2:8080';
//시뮬레이터 로컬
final simulatorIp = '127.0.0.1:8080';
//아이폰일 경우 시뮬레이터 아이피 아닐 경우 애뮬레이터 아이피
final ip = Platform.isIOS ? simulatorIp : emulatorIp;
//final ip = '43.200.42.112:8888';

final openWeatherApiKey = 'fe7b80f0025e7127919bfc3ee7e1d45f';
//http://api.openweathermap.org/data/2.5/forecast?lat=35&lon=125&appid=cf7abfeb9b7f2a359379cb8220ea4d02
final openWeatherApiBaseUrl = 'http://api.openweathermap.org/data/2.5/forecast';