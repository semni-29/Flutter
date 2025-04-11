import 'package:flutter/material.dart';
import '../animalItem.dart';

class SecondApp extends StatefulWidget {
  final List<Animal> list;
  const SecondApp({Key? key, required this.list}) : super(key: key);

  @override
  State<SecondApp> createState() => _SecondAppState();
}

class _SecondAppState extends State<SecondApp> {
  String timePeriod = "AM";

  @override
  Widget build(BuildContext context) {
    final filteredAnimals = widget.list.where((animal) {
      if (animal.timeRange == null) return false;
      final hour = int.parse(animal.timeRange!.split(":")[0]);
      return timePeriod == "AM" ? hour < 12 : hour >= 12;
    }).toList();

    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio<String>(
              value: "AM",
              groupValue: timePeriod,
              onChanged: (value) {
                setState(() {
                  timePeriod = value!;
                });
              },
            ),
            const Text('오전'),
            Radio<String>(
              value: "PM",
              groupValue: timePeriod,
              onChanged: (value) {
                setState(() {
                  timePeriod = value!;
                });
              },
            ),
            const Text('오후'),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredAnimals.length,
            itemBuilder: (context, index) {
              final animal = filteredAnimals[index];
              return Card(
                child: ListTile(
                  leading: Image.asset(animal.imagePath!, height: 60, width: 60),
                  title: Text(animal.animalName!),
                  subtitle: Text('${animal.kind} - ${animal.timeRange}'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(animal.animalName!),
                        content: Text('이 동물은 ${animal.kind}이며, 활동 시간은 ${animal.timeRange}입니다.'),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
