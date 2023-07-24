import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/states_services.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  hintText: "Search with country name",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statesServices.countriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(height: 10, width: 89, color: Colors.white,),
                                  subtitle: Container(height: 10, width: 89, color: Colors.white,),
                                  leading: Container(height: 50, width: 50, color: Colors.white,)
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];

                          if(searchController.text.isEmpty){
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                    ['countryInfo']['flag']),
                                  ),
                                ),
                              ],
                            );

                          }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                    ['countryInfo']['flag']),
                                  ),
                                ),
                              ],
                            );


                          }else{
                            return Container();

                          }
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
