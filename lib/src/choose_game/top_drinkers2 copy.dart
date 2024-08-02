import 'package:flutter/material.dart';

class TopCreatorsWidget extends StatelessWidget {
  final List<Creator> creators;

  const TopCreatorsWidget({super.key, required this.creators});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0),
          child: Text(
            'Top Drinkers',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: creators.length,
          itemBuilder: (context, index) {
            return ListTile(
              minTileHeight: 50,
              contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: _getMedalColor(index),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                      radius: 13,
                      backgroundColor: Colors.grey.shade100,
                      child: const Text(
                        "as",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
              title: Text(
                creators[index].name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              subtitle: const Text(
                'Male',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              trailing: Text(
                creators[index].amount,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ],
    );
  }

  Color _getMedalColor(int index) {
    switch (index) {
      case 0:
        return Colors.yellow;
      case 1:
        return Colors.grey;
      case 2:
        return Colors.orange;
      default:
        return Colors.black;
    }
  }
}

class Creator {
  final String name;
  final int followers;
  final int posts;
  final String amount;

  Creator({
    required this.name,
    required this.followers,
    required this.posts,
    required this.amount,
  });
}
