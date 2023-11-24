import 'package:flutter/material.dart';
import 'package:hangout_app/models/card.dart';

class CardDetails extends StatelessWidget {
  const CardDetails({super.key, required this.itemDetail});

  final CardItem itemDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itemDetail.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/hangout.png'),
              const SizedBox(
                height: 15,
              ),
              Text(
                itemDetail.title,
                style: const TextStyle(fontSize: 25),
              ),
              Text(itemDetail.detail),
              const SizedBox(height: 15),
              const Text(
                'About Trip',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    leading: const Icon(Icons.map),
                    title: Text(
                      'Start Date: ${itemDetail.start_date}',
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: Text(
                      'Start Date: ${itemDetail.start_date}',
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: Text(
                      'End Date: ${itemDetail.end_date}',
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.people),
                    title: Text(
                      'Price: ${itemDetail.expiry}',
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.category),
                    title: Text(
                      'Price: ${itemDetail.expiry}',
                    ),
                  ),
                ],
              ),
              const Text(
                'Departure',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    leading: const Icon(Icons.map),
                    title: Text(
                      'Start Date: ${itemDetail.destination}',
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.watch_later_outlined),
                    title: Text(
                      'Start Date: ${itemDetail.start_date}',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
