import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Model/worldstatemode.dart';
import '../Services/stateservices.dart';
import 'detailScreen.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  _CountriesListScreenState createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateServices newsListViewModel = StateServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintText: 'Search with country name',
                  suffixIcon: searchController.text.isEmpty
                      ? const Icon(Icons.search)
                      : GestureDetector(
                          onTap: () {
                            searchController.text = "";
                            setState(() {});
                          },
                          child: Icon(Icons.clear)),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: newsListViewModel.CountriesListAPI(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    print(snapshot);
                    if (!snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                  title: Container(
                                    width: 100,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    width: double.infinity,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]['country'];
                            if (searchController.text.isEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    name: snapshot.data![index]
                                                        ['country'],
                                                    totalCases: snapshot
                                                        .data![index]['cases'],
                                                    totalRecovered:
                                                        snapshot.data![index]
                                                            ['recovered'],
                                                    totalDeaths: snapshot
                                                        .data![index]['deaths'],
                                                    active: snapshot
                                                        .data![index]['active'],
                                                    test: snapshot.data![index]
                                                        ['tests'],
                                                    todayRecovered:
                                                        snapshot.data![index]
                                                            ['todayRecovered'],
                                                    critical:
                                                        snapshot.data![index]
                                                            ['critical'],
                                                  )));
                                    },
                                    child: ListTile(
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag']),
                                      ),
                                      title: Text(
                                          snapshot.data![index]['country']),
                                      subtitle: Text("Effected: " +
                                          snapshot.data![index]['cases']
                                              .toString()),
                                    ),
                                  ),
                                  Divider()
                                ],
                              );
                            } else if (name.toLowerCase().contains(
                                searchController.text.toLowerCase())) {
                              return Column(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                      image: snapshot
                                                                  .data![index]
                                                              ['countryInfo']
                                                          ['flag'],
                                                      name:
                                                          snapshot.data![index]
                                                              ['country'],
                                                      totalCases:
                                                          snapshot.data![index]
                                                              ['cases'],
                                                      totalRecovered:
                                                          snapshot.data![index]
                                                              ['recovered'],
                                                      totalDeaths:
                                                          snapshot.data![index]
                                                              ['deaths'],
                                                      active:
                                                          snapshot.data![index]
                                                              ['active'],
                                                      test:
                                                          snapshot.data![index]
                                                              ['tests'],
                                                      todayRecovered: snapshot
                                                              .data![index]
                                                          ['todayRecovered'],
                                                      critical:
                                                          snapshot.data![index]
                                                              ['critical'],
                                                    )));
                                      },
                                      child: ListTile(
                                        leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag']),
                                        ),
                                        title: Text(
                                            snapshot.data![index]['country']),
                                        subtitle: Text("Effected: " +
                                            snapshot.data![index]['cases']
                                                .toString()),
                                      )),
                                  Divider()
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// import '../Services/stateservices.dart';
//
// class CountriesListScreen extends StatefulWidget {
//   const CountriesListScreen({super.key});
//
//   @override
//   State<CountriesListScreen> createState() => _CountriesListScreenState();
// }
//
// class _CountriesListScreenState extends State<CountriesListScreen> {
//   TextEditingController searchcontroller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     StateServices stateServices = StateServices();
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       ),
//       body: SafeArea(
//           child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               onChanged: (value) {
//                 setState(() {});
//               },
//               controller: searchcontroller,
//               decoration: InputDecoration(
//                 hintText: "Search",
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//                 border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
//               ),
//             ),
//           ),
//           Expanded(
//               child: FutureBuilder(
//                   future: stateServices.CountriesListAPI(),
//                   builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
//                     if (!snapshot.hasData) {
//                       return ListView.builder(
//                           itemCount: 8,
//                           itemBuilder: (context, index) {
//                             return Shimmer.fromColors(
//                                 baseColor: Colors.grey.shade700,
//                                 highlightColor: Colors.grey.shade100,
//                                 child: Column(children: [
//                                   ListTile(
//                                     title: Container(
//                                       height: 10,
//                                       width: 89,
//                                       color: Colors.white,
//                                     ),
//                                     subtitle: Container(
//                                       height: 10,
//                                       width: 89,
//                                       color: Colors.white,
//                                     ),
//                                     leading: Container(
//                                       height: 50,
//                                       width: 50,
//                                       color: Colors.white,
//                                     ),
//                                   )
//                                 ]));
//                           });
//                     } else {
//                       return ListView.builder(
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (context, index) {
//                             String name = snapshot.data![index]['country'];
//                             if (searchcontroller.text.isEmpty) {
//                               return Column(children: [
//                                 ListTile(
//                                   title: Text(snapshot.data![index]['country']),
//                                   subtitle: Text(snapshot.data![index]['cases']
//                                       .toString()),
//                                   leading: Image(
//                                       height: 50,
//                                       width: 50,
//                                       image: NetworkImage(snapshot.data![index]
//                                           ['countryInfo']['flag'])),
//                                 )
//                               ]);
//                             } else if (name.toLowerCase().contains(
//                                 searchcontroller.text.toLowerCase())) {
//                               return Column(children: [
//                                 ListTile(
//                                   title: Text(snapshot.data![index]['country']),
//                                   subtitle: Text(snapshot.data![index]['cases']
//                                       .toString()),
//                                   leading: Image(
//                                       height: 50,
//                                       width: 50,
//                                       image: NetworkImage(snapshot.data![index]
//                                           ['countryInfo']['flag'])),
//                                 )
//                               ]);
//                             } else {
//                               return Container();
//                             }
//                             return Column(children: [
//                               ListTile(
//                                 title: Text(snapshot.data![index]['country']),
//                                 subtitle: Text(
//                                     snapshot.data![index]['cases'].toString()),
//                                 leading: Image(
//                                     height: 50,
//                                     width: 50,
//                                     image: NetworkImage(snapshot.data![index]
//                                         ['countryInfo']['flag'])),
//                               )
//                             ]);
//                           });
//                     }
//                   })),
//         ],
//       )),
//     );
//   }
// }
