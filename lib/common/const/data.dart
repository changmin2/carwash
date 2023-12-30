import 'dart:io';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

//애뮬레이터 로컬
final emulatorIp = '10.0.2.2:8080';
//시뮬레이터 로컬
final simulatorIp = '127.0.0.1:8080';
//아이폰일 경우 시뮬레이터 아이피 아닐 경우 애뮬레이터 아이피
final ip = Platform.isIOS ? simulatorIp : emulatorIp;
//final ip = '49.50.165.212:8080';

final openWeatherApiKey = 'fe7b80f0025e7127919bfc3ee7e1d45f';

final openWeatherApiBaseUrl = 'http://api.openweathermap.org/data/2.5/forecast';