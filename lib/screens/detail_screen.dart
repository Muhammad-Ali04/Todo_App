import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo_app/models/todo_model.dart';

import '../main.dart';

class DetailScreen extends StatefulWidget {
  final TodoModel data;
  const DetailScreen({super.key, required this.data});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  String? editdate;
  bool _date = false;
  var status;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.data.title;
    descriptionController.text = widget.data.description;
    editdate = widget.data.date;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 64, 42, 26),
        icon: Icon(
          CupertinoIcons.upload_circle,
          color: Color.fromARGB(255, 203, 194, 177),
        ),
        label: Text(
          "Update",
          style: TextStyle(
              color: Color.fromARGB(255, 203, 194, 177),
              fontFamily: "Ubuntu",
              fontStyle: FontStyle.italic),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            TodoModel editData = TodoModel.autoId(
              title: titleController.text,
              description: descriptionController.text,
              date: editdate.toString(),
            );
            status = objectBox.editPlan(editData, widget.data.id as int);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                content: Text(
                  'Updated',
                  style: TextStyle(
                      color: Color.fromARGB(255, 203, 194, 177),
                      fontFamily: "Ubuntu",
                      fontStyle: FontStyle.italic),
                ),
                backgroundColor: Color.fromARGB(255, 64, 42, 26),
              ),
            );
            Navigator.pop(context);
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
          "Edit a Plan",
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
                    controller: titleController,
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
                      hintStyle: TextStyle(
                        fontFamily: "Ubuntu",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 64, 42, 26),
                      ),
                      border: InputBorder.none,
                    ),
                  )),
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
                                        if (args.value is DateTime) {
                                          setState(() {
                                            editdate = args.value
                                                .toString()
                                                .substring(0, 10);
                                            _date = true;
                                            print(editdate);
                                          });
                                        }
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
                    child: Text(editdate.toString(),
                        style: TextStyle(
                            fontFamily: "Ubuntu",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 203, 194, 177))),
                  )
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }
}
