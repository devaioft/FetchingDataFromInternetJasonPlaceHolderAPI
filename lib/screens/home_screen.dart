import 'package:flutter/material.dart';
import 'package:network_app/models/album_model.dart';
import 'package:network_app/networking/netwok.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Apps'),
        actions: const [Icon(Icons.search)],
      ),
      body: Column(
        children: [
          FutureBuilder<List<Album>>(
            future: fetchAlbum(),
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshots.data!.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data![index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 170,
                              width: 170,
                              decoration: BoxDecoration(
                                color: index.isOdd ? Colors.pink : Colors.blue,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: ClipRRect(
                                clipBehavior: Clip.antiAlias,
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.network(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRc95sKK5m3zocU5EXL4xYa239jk3dnyG4v6hGd3yuGDvjw6HLZYAup2bnGEwTGEfb4J2w&usqp=CAU',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${data.userId}',
                                        style: const TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                                      Text(
                                        '${data.id} ${data.title} ',
                                        style: TextStyle(
                                          color: index.isOdd
                                              ? Colors.deepPurple
                                              : Colors.green,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshots.hasError) {
                Center(
                  child: Text(snapshots.error.toString()),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
