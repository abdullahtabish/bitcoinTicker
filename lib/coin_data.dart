import 'dart:convert';
import 'package:http/http.dart' as http;

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

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey =
    'DDD2654C-07C1-43CB-AB85-D20DDE8E5E31'; //'1F97F687-AA08-44AD-9A25-3896A12AA14D';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrice = {};

    for (String cryptoCoin in cryptoList) {
      String requestURL =
          '$coinAPIURL/$cryptoCoin/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(Uri.parse(requestURL));

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        cryptoPrice[cryptoCoin] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Error with the get request';
      }
    }

    return cryptoPrice;
  }
}
