import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:swe444/Services/auth.dart';
import 'package:path/path.dart' as Path;
import 'package:swe444/Services/database.dart';
import 'package:swe444/models/profile.dart';
import 'package:swe444/models/user.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';

class AddPage extends StatefulWidget {
  final double weidth, height;
  final User user;

  AddPage(this.weidth, this.height, this.user);

  @override
  State<StatefulWidget> createState() {
    return addPage(weidth, height, user);
  }
}

class addPage extends State<AddPage> {
  Duration _duration = Duration(hours: 0, minutes: 0);
  final AuthServices _auth = AuthServices();
  final User user;
  static final _formKey2 = GlobalKey<FormState>();
  File _image;
  final _picker = ImagePicker();
  static String uploadedFileURL;
  static int category;
  static String title;
  static String description;
  static String ingredients;
  static String step;
  static int duration;
  static String email;
  List<Widget> list_ing = [];
  List<String> list_ing_info = [];
  List<Widget> list_step = [];
  List<String> list_step_info = [];
  double size_ing = 120.0;
  double size_step = 120.0;
  int list_ing_index = 2;
  int list_step_index = 2;

//asd
  //a
  //as
  //asd
  initState() {
    category = 0;
    list_ing.add(
      TextFormField(
        onChanged: (value) => ingredients = "1-  " + value,
        validator: (value) => value.isEmpty ? "fill the ingredient" : null,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) => FocusScope.of(context).focusedChild,
        keyboardType: TextInputType.text,
        minLines: 1,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: "1 Ingredient:",
          border: InputBorder.none,
        ),
      ),
    );
    list_step.add(
      TextFormField(
        onChanged: (value) => step = "1-  " + value,
        validator: (value) => value.isEmpty ? "fill the step" : null,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) => FocusScope.of(context).focusedChild,
        keyboardType: TextInputType.text,
        minLines: 1,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: "1 step:",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Future chooseFile() async {
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);
    });
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('recipes/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    //
    //print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        uploadedFileURL = fileURL;
        final user = Provider.of<User>(context);
        Stream<List<profile1>> users = DatabaseService(uid: user.uid).users;
        // String email;
        users.listen((event) {
          // print("length of data: ${event.length}");
          event.forEach((element) {
            if (element.uid == user.uid) {
              email = element.email;
              //print("email: ${element.email}");
              DatabaseService(uid: user.uid).insertMeals(
                  category,
                  title,
                  description,
                  ingredients,
                  step,
                  _duration.inMinutes,
                  element.email,
                  fileURL);
              Navigator.of(context).pop();
              // print("email email : $email");
            }
          });
        });

        // return fileURL;
        //print(uploadedFileURL);
      });
    });
  }

  final double weidth, height;
  static int index = 0;

  addPage(this.weidth, this.height, this.user);

  @override
  Widget build(BuildContext context) {
    List cat = [
      "Juice",
      "Appetizers",
      "Main Dishes",
      "Salads",
      "Soup",
      "Sweets"
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(242, 171, 39, 1),
        title: Text(
          'Add Recipe',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Form(
              key: _formKey2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Img
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffE1E1E1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: sizeW(weidth, 0.875),
                    height: height * 0.25,
                    child: InkWell(
                      onTap: chooseFile,
                      child: Image(
                        //image Path
                        image: _image != null
                            ? FileImage(_image)
                            : AssetImage('assets/Upload_pic.png'),
                      ),
                    ),
                  ),
                  // name
                  Container(
                    width: sizeW(weidth, 0.875),
                    padding:
                        EdgeInsets.only(top: 10, left: 7, right: 7, bottom: 5),
                    margin: EdgeInsets.symmetric(
                        horizontal: weidth * 0.03, vertical: 2.5),
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color(0xffC4C4C4),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextFormField(
                      onChanged: (value) => title = value,
                      validator: (value) =>
                          value.isEmpty ? "fill the Name of Recipe" : null,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).focusedChild,
                      decoration: InputDecoration(
                        hintText: "Name:",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  //Duration
                  Text("Est. cooking time:"),
                  Container(
                      width: sizeW(weidth, 0.875),
                      padding: EdgeInsets.only(
                          top: 15, left: 7, right: 7, bottom: 5),
                      margin: EdgeInsets.symmetric(
                          horizontal: weidth * 0.03, vertical: 2.5),
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: DurationPicker(
                        duration: _duration,
                        onChange: (val) {
                          this.setState(() => _duration = val);
                        },
                        snapToMins: 1.0,
                      )),
                  //Description
                  Container(
                    width: sizeW(weidth, 0.875),
                    padding:
                        EdgeInsets.only(top: 10, left: 7, right: 7, bottom: 5),
                    margin: EdgeInsets.symmetric(
                        horizontal: weidth * 0.03, vertical: 2.5),
                    height: 200,
                    decoration: BoxDecoration(
                      color: Color(0xffE0E0E0),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextFormField(
                      onChanged: (value) => description = value,
                      validator: (value) =>
                          value.isEmpty ? "fill the description" : null,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).focusedChild,
                      decoration: InputDecoration(
                        hintText: "Description:",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  //Ingredients
                  Container(
                      width: sizeW(weidth, 0.875),
                      padding: EdgeInsets.only(
                          top: 10, left: 7, right: 7, bottom: 5),
                      margin: EdgeInsets.symmetric(
                          horizontal: weidth * 0.03, vertical: 2.5),
                      height: size_ing + 12,
                      decoration: BoxDecoration(
                        color: Color(0xffE0E0E0),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: list_ing,
                          ),
                          RaisedButton(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.red)),
                            color: Color(0xffDD7804),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Add',
                                style: TextStyle(
                                    fontFamily: 'OleoScript', fontSize: 20),
                              ),
                            ),
                            onPressed: () {
                              list_ing_info.add(ingredients);
                              ingredients = "";
                              addIng();
                            },
                          )
                        ],
                      )

                      // TextFormField(
                      //   onChanged: (value) => ingredients = value,
                      //   validator: (value) =>
                      //       value.isEmpty ? "fill the ingredients" : null,
                      //   textInputAction: TextInputAction.newline,
                      //   onFieldSubmitted: (_) =>
                      //       FocusScope.of(context).nextFocus(),
                      //   keyboardType: TextInputType.multiline,
                      //   minLines: 1,
                      //   maxLines: 100,
                      //   decoration: InputDecoration(
                      //     hintText: "Ingredients:",
                      //     border: InputBorder.none,
                      //   ),
                      // ),
                      ),
                  //Steps
                  Container(
                      width: sizeW(weidth, 0.875),
                      padding: EdgeInsets.only(
                          top: 10, left: 7, right: 7, bottom: 5),
                      margin: EdgeInsets.only(
                          right: weidth * 0.03,
                          left: weidth * 0.03,
                          top: 2.5,
                          bottom: 15),
                      height: size_step + 15,
                      decoration: BoxDecoration(
                        color: Color(0xffE0E0E0),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: list_step,
                          ),
                          RaisedButton(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.red)),
                            color: Color(0xffDD7804),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Add',
                                style: TextStyle(
                                    fontFamily: 'OleoScript', fontSize: 20),
                              ),
                            ),
                            onPressed: () {
                              list_step_info.add(step);
                              step = "";
                              addstep();
                            },
                          )
                        ],
                      )),
                  //Choose category divider
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      Text(
                        '     Choose category     ',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //Category selection
                  Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.all(3),
                        child: chip(cat[0], "assets/Juice_icon@3x.png", 0),
                      ),
                      Container(
                        margin: EdgeInsets.all(3),
                        child: chip(cat[1], "assets/Appetizers_icon@3x.png", 1),
                      ),
                      Container(
                        margin: EdgeInsets.all(3),
                        child:
                            chip(cat[2], "assets/Main Dishes_icon@3x.png", 2),
                      ),
                      Container(
                        margin: EdgeInsets.all(3),
                        child: chip(cat[3], "assets/Salads_icon@3x.png", 3),
                      ),
                      Container(
                        margin: EdgeInsets.all(3),
                        child: chip(cat[4], "assets/Soup_icon@3x.png", 4),
                      ),
                      Container(
                        margin: EdgeInsets.all(3),
                        child: chip(cat[5], "assets/Sweets_icon@3x.png", 5),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //Save button
                  RaisedButton(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.red)),
                    color: Color(0xffDD7804),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, left: 20, right: 20),
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontFamily: 'OleoScript',
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey2.currentState.validate() && _image != null) {
                        String ss = ingredients;
                        for (int i = 0; i < list_ing_info.length; i++) {
                          if (i != 0)
                            ingredients =
                                (ingredients + list_ing_info[i] + "\n");
                          else
                            ingredients = (list_ing_info[i] + "\n");
                        }
                        if (list_ing_index != 2) ingredients += ss;
                        print(list_step_info);
                        String ff = step;
                        for (int i = 0; i < list_step_info.length; i++) {
                          if (i != 0)
                            step = (step + list_step_info[i] + "\n");
                          else
                            step = (list_step_info[i] + "\n");
                        }
                        if (list_step_index != 2) step += ff;
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.success,
                          confirmBtnColor: Color(0xfff2780c),
                          confirmBtnText: "Done",
                          text: "Your recipe is added",
                          barrierDismissible: false,
                          onConfirmBtnTap: () {
                            Navigator.of(context).pop();
                            uploadFile();
                          },
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chip(String label, String path, int selectedIndex) {
    bool selected = false;
    return ChoiceChip(
      labelPadding: EdgeInsets.all(5.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.white,
        child: Image(image: AssetImage(path)),
      ),
      label: Text(
        label,
        style: TextStyle(color: Colors.black, fontSize: 15),
      ),
      backgroundColor: Colors.grey.shade300,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(6.0),
      selected: index == selectedIndex,
      onSelected: (bool IsSelected) {
        setState(() {
          index = IsSelected ? selectedIndex : null;
          category = index;
          //print(category);
        });
      },
      selectedColor: Color.fromRGBO(242, 201, 54, 1),
    );
  }

  double sizeW(double weidth, double ratio) {
    if (weidth <= 375) {
      return 354 * ratio;
    } else if (weidth > 375 && weidth <= 480) {
      return 436 * ratio;
    } else if (weidth > 480 && weidth < 800) {
      return 784 * ratio;
    } else
      return 900 * ratio;
  }

  double sizeh(double height) {
    if (height <= 569) {
      return 582 * 0.18;
    } else if (height > 569 && height <= 812) {
      return 740 * 0.18;
    } else if (height > 812 && height < 896) {
      return 882 * 0.19;
    } else if (height > 896 && height <= 1024) {
      return 992 * 0.19;
    } else
      return 1100 * 0.19;
  }

  void addIng() {
    setState(() {
      list_ing.add(
        TextFormField(
          onChanged: (value) =>
              ingredients = (list_ing_index - 1).toString() + "-  " + value,
          validator: (value) => value.isEmpty ? "fill the ingredient" : null,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => FocusScope.of(context).focusedChild,
          keyboardType: TextInputType.text,
          minLines: 1,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: list_ing_index.toString() + " Ingredient:",
            border: InputBorder.none,
          ),
        ),
      );
      size_ing += 50;
      list_ing_index++;
    });
  }

  void addstep() {
    setState(() {
      list_step.add(
        TextFormField(
          onChanged: (value) =>
              step = (list_step_index - 1).toString() + "-  " + value,
          validator: (value) => value.isEmpty ? "fill the step" : null,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => FocusScope.of(context).focusedChild,
          keyboardType: TextInputType.text,
          minLines: 1,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: list_step_index.toString() + " Step:",
            border: InputBorder.none,
          ),
        ),
      );
      size_step += 50;
      list_step_index++;
    });
  }
}
