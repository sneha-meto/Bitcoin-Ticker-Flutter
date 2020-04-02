import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedItem = 'USD';

  CoinData coinData = CoinData();

  //double
//  String pickedCurrencyRate0 = '?';
//  String pickedCurrencyRate1 = '?';
//  String pickedCurrencyRate2 = '?';
  String pickedCurrencyRate1, pickedCurrencyRate2, pickedCurrencyRate0;

  void getRate() async {
    var allCoinData;
    try {
      pickedCurrencyRate0 = '?';
      pickedCurrencyRate1 = '?';
      pickedCurrencyRate2 = '?';
      allCoinData = await coinData.getCoinData(selectedItem);
      setState(() {
        pickedCurrencyRate0 = allCoinData['BTC'][selectedItem].toString();
        pickedCurrencyRate1 = allCoinData['ETH'][selectedItem].toString();
        pickedCurrencyRate2 = allCoinData['LTC'][selectedItem].toString();

        // print(pickedCurrencyRate);
      });
    } catch (e) {
      print(e);
    }
  }

  //var usd= getRate();

  DropdownButton getDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedItem,
        items: dropDownItems,
        //DropdownMenuItem(child: Text('USD'), value: 'USD'),
        onChanged: (value) {
          setState(() {
            selectedItem = value;
            getRate();
          });
        });
  }

  CupertinoPicker getPicker() {
    List<Text> pickerList = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);

      pickerList.add(newItem);
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      backgroundColor: Colors.lightGreen,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          //print(selectedIndex);

          selectedItem = currenciesList[selectedIndex];
          getRate();
        });
      },
      children: pickerList,
    );
  }

  @override
  void initState() {
    getRate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('💰 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ReusableCard(
              n: 0,
              pickedCurrencyRate: pickedCurrencyRate0,
              selectedItem: selectedItem),
          ReusableCard(
              n: 1,
              pickedCurrencyRate: pickedCurrencyRate1,
              selectedItem: selectedItem),
          ReusableCard(
              n: 2,
              pickedCurrencyRate: pickedCurrencyRate2,
              selectedItem: selectedItem),
          SizedBox(
            height: 200.0,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.teal,
            child: Platform.isIOS ? getPicker() : getDropDownButton(),
          ),
        ],
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  const ReusableCard({
    Key key,
    @required this.pickedCurrencyRate,
    @required this.selectedItem,
    @required this.n,
  }) : super(key: key);

  final String pickedCurrencyRate;
  final String selectedItem;
  final int n;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.teal,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 ${cryptoList[n]} = $pickedCurrencyRate $selectedItem',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
