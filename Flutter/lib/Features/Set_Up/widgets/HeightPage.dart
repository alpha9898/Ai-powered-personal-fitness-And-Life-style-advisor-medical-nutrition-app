import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project_ui/Features/Set_Up/widgets/SummaryPage%20.dart';
import 'package:graduation_project_ui/core/Models/BodyConditionModel.dart';
import 'package:graduation_project_ui/core/Services/Bodyconditionservice.dart';

class HeightPage extends StatefulWidget {
  final String Gender;
  final int age;
  final int weight;

  HeightPage(
      {super.key,
      required this.Gender,
      required this.weight,
      required this.age});

  @override
  _HeightPageState createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  int selectedHeight = 165;
  late BodyConditionModel ressult;
  Bodyconditionservice bodyconditionservice = Bodyconditionservice();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "What Is Your Height?",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "وزنك الذي اخترته: ${widget.weight} كجم",
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 20),
          Text(
            "$selectedHeight Cm",
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
                  selectedHeight = index + 140; // الطول يبدأ من 140 سم
                });
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  return Center(
                    child: Text(
                      "${index + 140}",
                      style: TextStyle(
                        color: selectedHeight == index + 140
                            ? Colors.white
                            : Colors.white54,
                        fontSize: selectedHeight == index + 140 ? 24 : 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                childCount: 100, // الأطوال من 140 إلى 240 سم
              ),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              // هنا هنستعمل ال flask
              ressult = await bodyconditionservice.getBodyConditionData(
                weight: widget.weight,
                height: selectedHeight / 100,
                age: widget.age,
                gender: widget.Gender,
              ); //هنااااااااا ال flas;
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SummaryPage(
                          gender: widget.Gender,
                          age: widget.age,
                          weight: widget.weight,
                          height: selectedHeight / 100,
                          bodyConditionModel: ressult,
                        )),
              );

              print(
                  "تم اختيار الطول: $selectedHeight سم والوزن: ${widget.weight} كجم");
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
