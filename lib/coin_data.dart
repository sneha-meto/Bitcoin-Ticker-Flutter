import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey =
    '365c178c080f70c4860c28927f02226e550d9154af9e8d5178013eb2c521d90f';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

int getLength() {
  return currenciesList.length;
}

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<dynamic> getCoinData(String selectedItem) async {
    var url =
        'https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,LTC&tsyms=$selectedItem&api_key=$apiKey';
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      // print(jsonDecode(response.body)['BTC']['USD']);
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
