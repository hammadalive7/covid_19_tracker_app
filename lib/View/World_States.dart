import 'package:covid_19_tracker_app/Model/WorldStatesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Services/states_services.dart';
import 'countries_list.dart';

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
    StatesServices statesServices = StatesServices();
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Covid-19"),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 50.0, left: 10.0, right: 10.0, bottom: 20.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .01,
              ),
              FutureBuilder(
                future: statesServices.fetchWorldStatesRecord(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.blue,
                          size: 50.0,
                          controller: _controller,
                        ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Deaths":
                                double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            // showChartValueBackground: false,
                            // showChartValues: true,
                            showChartValuesInPercentage: true,
                            // showChartValuesOutside: false,
                            decimalPlaces: 1,
                          ),
                          animationDuration: const Duration(milliseconds: 1200),
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
                                  value: snapshot.data!.cases.toString(),
                                ),
                                const Divider(
                                  indent: 10,
                                  endIndent: 10,
                                  thickness: 1,
                                ),
                                ReuseableRow(
                                  title: "Total Recovered: ",
                                  value: snapshot.data!.recovered.toString(),
                                ),
                                const Divider(
                                  indent: 10,
                                  endIndent: 10,
                                  thickness: 1,
                                ),
                                ReuseableRow(
                                  title: "Total Deaths: ",
                                  value: snapshot.data!.deaths.toString(),
                                ),
                                const Divider(
                                  color: Colors.red,
                                  indent: 10,
                                  endIndent: 10,
                                  thickness: 2,
                                ),
                                ReuseableRow(
                                  title: "Active Cases: ",
                                  value: snapshot.data!.active.toString(),
                                ),
                                const Divider(
                                  indent: 10,
                                  endIndent: 10,
                                  thickness: 1,
                                ),
                                ReuseableRow(
                                  title: "Critical Patients: ",
                                  value: snapshot.data!.critical.toString(),
                                ),
                                const Divider(
                                  color: Colors.red,
                                  indent: 10,
                                  endIndent: 10,
                                  thickness: 2,
                                ),
                                ReuseableRow(
                                  title: "Today Deaths: ",
                                  value: snapshot.data!.todayDeaths.toString(),
                                ),
                                const Divider(
                                  indent: 10,
                                  endIndent: 10,
                                  thickness: 1,
                                ),
                                ReuseableRow(
                                  title: "Today Cases: ",
                                  value: snapshot.data!.todayCases.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CountriesListScreen()),
                            );
                          },
                          child: Container(
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
                              )),
                        ),
                      ],
                    );
                  }
                },
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
      padding:
          const EdgeInsets.only(top: 10.0, bottom: 5, left: 10.0, right: 10.0),
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
        ],
      ),
    );
  }
}
