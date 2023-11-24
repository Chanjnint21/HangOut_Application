import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hangout_app/models/card.dart';
import 'package:hangout_app/screens/card_details.dart';
import 'package:hangout_app/widgets/card_item.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    // required this.selectedCard,
  });

  // final void Function(String identifier) selectedCard;

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  List<CardItem> _cardLists = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    // Your function or code to run when the screen is entered
    _getCardData();
  }

  void _getCardData() async {
    final url =
        Uri.https('outdoor-traveler-default-rtdb.firebaseio.com', 'trips.json');
    try {
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch data. Please try again later.';
        });
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      final Map<String, dynamic> listData = json.decode(response.body);
      // print(listData);
      final List<CardItem> loadedItems = [];
      for (final item in listData.entries) {
        loadedItems.add(
          CardItem(
            id: item.key,
            author: item.value['author'],
            title: item.value['title'],
            category: item.value['category'],
            destination: item.value['destination'],
            expiry: item.value['expiry'],
            detail: item.value['detail'],
            postDate: item.value['postDate'],
            postTime: item.value['postTime'],
            start_date: item.value['start_date'],
            end_date: item.value['end_date'],
            requirement: item.value['requirement'],
            image: item.value['image'],
            departure: item.value['departure'],
          ),
        );
      }
      setState(() {
        _cardLists = loadedItems;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Something went wrong! Please try again later.';
      });
    }
  }

  void selectCard(BuildContext context, CardItem card) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => CardDetails(
          itemDetail: card,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No Event added yet.'));

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }

    if (_cardLists.isNotEmpty) {
      content = Container(
        height: MediaQuery.of(context).size.height - 150,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _cardLists.length,
          itemBuilder: (context, index) => ThisCard(
              card: _cardLists[index],
              onSelectCard: (card) {
                selectCard(context, card);
              }),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              suffixIcon: const Icon(Icons.search),
            ),
          ),
          content,
        ],
      ),
    );
  }
}
