import 'package:flutter/material.dart';
import 'package:hangout_app/models/card.dart';

class ThisCard extends StatelessWidget {
  const ThisCard({
    super.key,
    required this.card,
    required this.onSelectCard,
  });

  final CardItem card;
  final void Function(CardItem card) onSelectCard;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
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
              card.title,
              style: const TextStyle(fontSize: 25),
            ),
            Text(card.detail),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    onSelectCard(card);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B3B3B),
                    foregroundColor: const Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: Text('View'),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFC9652),
                    foregroundColor: const Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: const Text('Register'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
