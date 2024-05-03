import 'package:flutter/material.dart';
import 'package:flutterwebapi/add_user.dart';
import 'package:flutterwebapi/api_handler.dart';
import 'package:flutterwebapi/edit_page.dart';
import 'package:flutterwebapi/model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ApiHandler apiHandler = ApiHandler();
  late List<User> data = [];

  void getData() async {
    data = await apiHandler.getUserData();
    setState(() {});
  }

  void deleteData(int Id) async {
    final response = await apiHandler.deleteUser(Id: Id);
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FlutterApi"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: MaterialButton(
        onPressed: getData,
        color: Colors.teal,
        textColor: Colors.white,
        padding: const EdgeInsets.all(20),
        child: const Text('Refresh'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddUser()));
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditPage(user: data[index])));
                  },
                  leading: Text("${data[index].Id}"),
                  title: Text(data[index].user),
                  subtitle: Text(data[index].address),
                  trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: deleteData(data[index].Id)));
            },
          )
        ],
      ),
    );
  }
}
