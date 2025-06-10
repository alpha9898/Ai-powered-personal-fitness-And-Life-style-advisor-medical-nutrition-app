import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project_ui/Features/Set_Up/widgets/HeightPage.dart';

class WeightPage extends StatefulWidget {
  final String selectedGender;
  final int selectedAge;
  const WeightPage(
      {super.key, required this.selectedGender, required this.selectedAge});
  @override
  _WeightPageState createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  int selectedWeight = 75;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "What Is Your Weight?",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "اختر وزنك عن طريق السحب لليمين واليسار",
            style: TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            "$selectedWeight Kg",
            style: const TextStyle(
                color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Icon(Icons.arrow_drop_up, color: Colors.yellow, size: 60),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: ListWheelScrollView.useDelegate(
              itemExtent: 50,
              physics: const FixedExtentScrollPhysics(),
              diameterRatio: 2,
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedWeight = index + 30; // الوزن يبدأ من 30 كجم
                });
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  return Center(
                    child: Text(
                      "${index + 30}",
                      style: TextStyle(
                        color: selectedWeight == index + 30
                            ? Colors.white
                            : Colors.white54,
                        fontSize: selectedWeight == index + 30 ? 24 : 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                childCount: 200, // الأوزان من 30 إلى 230 كجم
              ),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HeightPage(
                    weight: selectedWeight,
                    Gender: widget.selectedGender,
                    age: widget.selectedAge,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white10,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text("Continue",
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
