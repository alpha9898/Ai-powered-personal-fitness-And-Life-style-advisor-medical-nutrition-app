import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/Set_Up/widgets/Weghit_page.dart';

class AgePage extends StatefulWidget {
  final String selectedGender;
  const AgePage({super.key, required this.selectedGender});

  @override
  State<AgePage> createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  int selectedAge = 28;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "How Old Are You?",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "اختر عمرك عن طريق السحب لليمين واليسار",
            style: TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            selectedAge.toString(),
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
                  selectedAge = index + 18; // العمر يبدأ من 18 سنة
                });
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  return Center(
                    child: Text(
                      (index + 18).toString(),
                      style: TextStyle(
                        color: selectedAge == index + 18
                            ? Colors.white
                            : Colors.white54,
                        fontSize: selectedAge == index + 18 ? 24 : 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                childCount: 100, // الأعمار من 18 إلى 117 سنة
              ),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WeightPage(
                    selectedGender: widget.selectedGender,
                    selectedAge: selectedAge,
                  ),
                ),
              );
              print("العمر المختار: $selectedAge");
              // هنا تقدر تبعت العمر للموديل الخاص بالـ AI
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
