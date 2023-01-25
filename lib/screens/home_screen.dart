import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:clay_containers/clay_containers.dart';
import 'add_todo.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCBC2B1),
        title: Text(
          "Todo's",
          style: TextStyle(
              fontFamily: "Ubuntu",
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Color(0xFF402A1A)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            height: height,
            width: width,
            child: Image.asset(
              "assets/images/splash.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: height * 0.02),
                alignment: Alignment.center,
                child: Text(
                  "Tap to Edit a Plan",
                  style: TextStyle(
                      fontFamily: "Ubuntu",
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 64, 42, 26)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height * 0.01),
                alignment: Alignment.center,
                child: Text(
                  "LongPress to delete a Plan",
                  style: TextStyle(
                      fontFamily: "Ubuntu",
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 64, 42, 26)),
                ),
              ),
              StreamBuilder(
                stream: objectBox.getAllTodoModel(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text(""),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, index) {
                          TodoModel fetch = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: ((context) {
                                return DetailScreen(
                                  data: fetch,
                                );
                              })));
                            },
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        backgroundColor:
                                            Color.fromARGB(255, 64, 42, 26),
                                        title: Text(
                                          "Do you want to delete",
                                          style: TextStyle(
                                              fontFamily: "Ubuntu",
                                              fontStyle: FontStyle.italic,
                                              color: Color.fromARGB(
                                                  255, 203, 194, 177)),
                                        ),
                                        actions: [
                                          Container(
                                            height: height * 0.05,
                                            width: width * 0.2,
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 203, 194, 177),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      fontFamily: "Ubuntu",
                                                      color: Colors.black54),
                                                )),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                objectBox.deletePostById(
                                                    fetch.id as int);
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(
                                                CupertinoIcons.delete,
                                                color: Color.fromARGB(
                                                    255, 231, 16, 1),
                                              ))
                                        ]);
                                  }));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: height * 0.03,
                                  right: width * 0.03,
                                  left: width * 0.03),
                              child: ClayContainer(
                                curveType: CurveType.convex,
                                borderRadius: 10,
                                emboss: true,
                                spread: 5,
                                depth: 4,
                                parentColor: Color.fromARGB(255, 228, 220, 220),
                                color: Color.fromARGB(255, 203, 194, 177),
                                width: width,
                                child: ListTile(
                                  title: Text(
                                    snapshot.data![index].title,
                                    style: TextStyle(
                                        fontFamily: "Ubuntu",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 64, 42, 26)),
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index].description,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: "Ubuntu",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 92, 91, 91)),
                                  ),
                                  trailing: Text(
                                    snapshot.data![index].date,
                                    style: TextStyle(
                                        fontFamily: "Ubuntu",
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 92, 91, 91)),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text("Error Occur");
                  }
                  return Center(
                    child: Text("Nothing to show"),
                  );
                },
              ),
            ],
          )),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 64, 42, 26),
        icon: Icon(
          CupertinoIcons.pencil_outline,
          color: Color.fromARGB(255, 203, 194, 177),
        ),
        label: Text(
          "Make Plan",
          style: TextStyle(
              color: Color.fromARGB(255, 203, 194, 177),
              fontFamily: "Ubuntu",
              fontStyle: FontStyle.italic),
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => AddTodoScreen())));
        },
      ),
    );
  }
}
