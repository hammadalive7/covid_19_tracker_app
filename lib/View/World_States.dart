import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Covid-19"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .01,
              ),
              PieChart(
                dataMap: const {
                  "Total": 20,
                  "Recovered": 15,
                  "Deaths": 5,
                },
                animationDuration: Duration(milliseconds: 1200),
                chartType: ChartType.ring,
                colorList: const [
                  Color(0xff4285f4),
                  Color(0xff1aa260),
                  Color(0xffde5246),
                ],
                chartRadius: MediaQuery.sizeOf(context).width / 3.2,
                legendOptions: const LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.left,
                  showLegends: true,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.sizeOf(context).width * .06),
                child: Card(
                  child: Column(
                    children: [
                      ReuseableRow(
                        title: "Total Cases: ",
                        value: "20",
                      ),
                      ReuseableRow(
                        title: "Recovered: ",
                        value: "15",
                      ),
                      ReuseableRow(
                        title: "Deaths: ",
                        value: "5",
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepPurpleAccent,
                ),
                child: const Center(
                  child: Text(
                    "Track Countries",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )

              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;

  ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 5, left: 10.0, right: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .01,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
