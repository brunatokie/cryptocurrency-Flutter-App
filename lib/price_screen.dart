import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: pickerItems,
    );
  }

  Map<String, String> value = {};

  void getData() async {
    try {
      value = await CoinData().getCoinData(selectedCurrency);
      print('value $value');
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF06492),
          title: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFF06492),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'images/decentralized.png',
                  ),
                ),
              ),
              Text(
                'Coin Ticker',
                style: TextStyle(fontFamily: 'Raleway'),
              ),
            ],
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 60,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Color(0xFF414D6F),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      selectedCurrency,
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w900,
                          fontSize: 25.0),
                    ),
                  ),
                ),
              ),
              CryptoCard(value, selectedCurrency),
              Container(
                height: 120.0,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 10.0),
                color: Color(0xFF343F61),
                child: Platform.isIOS ? iOSPicker() : androidDropdown(),
              ),
            ]));
  }
}

class CryptoCard extends StatelessWidget {
  final Map<String, String> value;
  final String selectedCurrency;
  final Map<String, int> _simb = {'BTC': 1, 'ETH': 2, 'LTC': 3};

  CryptoCard(this.value, this.selectedCurrency);

  List<Padding> cryptoCards() {
    List<Padding> paddings = [];

    for (String a in cryptoList) {
      paddings.add(Padding(
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 1.0),
        child: Card(
          color: Color(0xFF6269F1),
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding:
                EdgeInsets.only(top: 18.0, bottom: 18, left: 100.0, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFF06492),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'images/icons${_simb[a]}.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$a',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 20,
                              height: 20,
                              child: Image.asset(
                                'images/sss.png',
                              ),
                            ),
                            Text(
                              ' ${value['$a'] ?? '?'}',
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
    }
    return paddings;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: cryptoCards(),
    );
  }
}
