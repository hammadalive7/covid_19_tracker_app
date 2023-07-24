import 'package:flutter/material.dart';

class CountryDetailScreen extends StatefulWidget {
  String name, image;
  int totalCases,
      totalRecovered,
      totalDeaths,
      activeCases,
      critical,
      test,
      todayCases,
      todayDeaths;

  CountryDetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalRecovered,
    required this.totalDeaths,
    required this.activeCases,
    required this.critical,
    required this.test,
    required this.todayCases,
    required this.todayDeaths,
  });

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * .06,
                      ),
                      ReuseableRow(title: "Total Cases: ", value: widget.totalCases.toString()),
                      ReuseableRow(title: "Total Recovered: ", value: widget.totalRecovered.toString()),
                      ReuseableRow(title: "Total Deaths: ", value: widget.totalDeaths.toString()),
                      ReuseableRow(title: "Active Cases: ", value: widget.activeCases.toString()),
                      ReuseableRow(title: "Critical: ", value: widget.critical.toString()),
                      ReuseableRow(title: "Test: ", value: widget.test.toString()),
                      ReuseableRow(title: "Today Cases: ", value: widget.todayCases.toString()),
                      ReuseableRow(title: "Today Deaths: ", value: widget.todayDeaths.toString()),


                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
            ],
          )
        ],
      )
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
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              Text(value, style: const TextStyle( fontSize: 18, color: Colors.white),),
            ],
          ),
          SizedBox(
            height: MediaQuery
                .sizeOf(context)
                .height * .01,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
