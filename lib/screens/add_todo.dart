import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  String? date = '';

  bool addPlan() {
    TodoModel data = TodoModel.autoId(
        title: titleController.text,
        description: descriptionController.text,
        date: date.toString());

    objectBox.insertTodoModel(data);
    Navigator.of(context).pop();

    return true;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 64, 42, 26),
        icon: Icon(
          CupertinoIcons.plus_circle_fill,
          color: Color.fromARGB(255, 203, 194, 177),
        ),
        label: Text(
          "Add",
          style: TextStyle(
              color: Color.fromARGB(255, 203, 194, 177),
              fontFamily: "Ubuntu",
              fontStyle: FontStyle.italic),
        ),
        onPressed: () {
          addPlan();
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                content: Text(
                  'Added',
                  style: TextStyle(
                      color: Color.fromARGB(255, 203, 194, 177),
                      fontFamily: "Ubuntu",
                      fontStyle: FontStyle.italic),
                ),
                backgroundColor: Color.fromARGB(255, 64, 42, 26),
              ),
            );
          }
        },
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: Color.fromARGB(255, 64, 42, 26),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromARGB(255, 203, 194, 177),
        title: Text(
          "Plan",
          style: TextStyle(
              fontFamily: "Ubuntu",
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Color.fromARGB(255, 64, 42, 26)),
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
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: height * 0.02,
                    right: width * 0.04,
                    left: width * 0.04),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Something in Title";
                      }
                    },
                    maxLength: 50,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      fontFamily: "Ubuntu",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 64, 42, 26),
                    ),
                    textCapitalization: TextCapitalization.words,
                    cursorColor: Colors.white,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Title",
                      hintStyle: TextStyle(
                        fontFamily: "Ubuntu",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 64, 42, 26),
                      ),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color.fromARGB(255, 203, 194, 177),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 64, 42, 26),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 64, 42, 26),
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 64, 42, 26),
                          width: 2.0,
                        ),
                      ),
                    ),
                    controller: titleController,
                  ),
                ),
              ),
              Container(
                  height: height * 0.3,
                  width: width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 64, 42, 26),
                        width: 2,
                      ),
                      color: Color.fromARGB(255, 203, 194, 177),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  margin: EdgeInsets.only(
                      top: height * 0.02,
                      right: width * 0.04,
                      left: width * 0.04),
                  child: TextFormField(
                    cursorColor: Colors.white,
                    maxLength: 400,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: width * 0.01),
                      hintText: "Description",
                      hintStyle: TextStyle(
                        fontFamily: "Ubuntu",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 64, 42, 26),
                      ),
                      border: InputBorder.none,
                    ),
                  )),
              // Container(
              //   alignment: Alignment.center,
              //   width: width * 0.3,
              //   decoration:
              //       BoxDecoration(color: Color.fromARGB(255, 203, 194, 177)),
              //   child: TextFormField(
              //     controller: dateController,
              //   ),
              // ),
              //
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor:
                                    Color.fromARGB(255, 203, 194, 177),
                                content: Container(
                                    height: height * 0.5,
                                    child: SfDateRangePicker(
                                      navigationMode:
                                          DateRangePickerNavigationMode.snap,
                                      onCancel: () {
                                        Navigator.pop(context);
                                      },
                                      todayHighlightColor:
                                          Color.fromARGB(255, 64, 42, 26),
                                      selectionColor:
                                          Color.fromARGB(255, 64, 42, 26),
                                      selectionShape:
                                          DateRangePickerSelectionShape
                                              .rectangle,
                                      showTodayButton: true,
                                      onSelectionChanged:
                                          (DateRangePickerSelectionChangedArgs
                                              args) {
                                        setState(() {
                                          date = args.value
                                              .toString()
                                              .substring(0, 10);
                                        });
                                        Navigator.pop(context);
                                      },
                                    )),
                              );
                            });
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: width * 0.03, top: height * 0.02),
                        child: Text(
                          "Add Date:",
                          style: TextStyle(
                              fontFamily: "Ubuntu",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 64, 42, 26)),
                        ),
                      )),
                  Container(
                    alignment: Alignment.center,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(255, 64, 42, 26),
                    ),
                    margin: EdgeInsets.only(top: height * 0.02),
                    child: Text(date.toString(),
                        style: TextStyle(
                            fontFamily: "Ubuntu",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 203, 194, 177))),
                  )
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
