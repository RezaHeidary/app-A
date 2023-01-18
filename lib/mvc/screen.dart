import 'package:appb/mvc/controller.dart';
import 'package:appb/mvc/model.dart';
import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  Model model = Model();
  Controller controller = Controller();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Phonebook")),
          titleTextStyle: const TextStyle(
            fontSize: 35,
          ),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: model.name.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(20),
              child: Material(
                elevation: 15,
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey[200]),
                  child: SizedBox(
                    width: size.width / 1.2,
                    height: size.height / 8,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Name And Phone Text
                           nameAndPhoneText(index),
                          //Update And Delete
                           updateAndDelet(index)
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          width: 150,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  showDialogInser();
                });
              },
              child: const Icon(
                Icons.add,
              ),
            ),
          ),
        ));
  }

//Void Update And Delete
  updateAndDelet(index) {
    return Row(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              model.name.removeAt(index);
            });
          },
          child: const Icon(
            Icons.delete,
            size: 70,
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.textEditingControllerName.text = model.name[index];
            controller.textEditingControllerPhone.text = model.phone[index];
            showDialogUpdate(index);
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 20, left: 20),
            child: Icon(
              Icons.edit,
              size: 70,
            ),
          ),
        )
      ],
    );
  }

  //Void Name and phone Text
  nameAndPhoneText(index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: Text(
            model.name[index],
            style: const TextStyle(fontSize: 45),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text(
            model.phone[index],
            style: const TextStyle(fontSize: 35),
          ),
        )
      ],
    );
  }

  //ShowDialogForInsert
  showDialogInser() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Insert'),
          content: SizedBox(
            height: 200,
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                TextField(
                    controller: controller.textEditingControllerName,
                    maxLines: 1,
                    decoration: const InputDecoration(hintText: "Name"),
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                        // ignore: prefer_const_constructors
                        fontSize: 30,
                        color: Colors.black)),
                TextField(
                    controller: controller.textEditingControllerPhone,
                    maxLength: 11,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      hintText: "Phone",
                    ),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 30, color: Colors.black)),
              ],
            ),
          ),
          actions: <Widget>[
            //Update and insert
            TextButton(
              style: ButtonStyle(
                  textStyle:
                      MaterialStateProperty.all(const TextStyle(fontSize: 25))),
              child: const Text('Add'),
              onPressed: () {
                setState(() {
                  if (controller.textEditingControllerName.text.isNotEmpty &&
                      controller.textEditingControllerName.text.isNotEmpty) {
                    model.name.add(controller.textEditingControllerName.text);
                    model.phone.add(controller.textEditingControllerPhone.text);
                  }
                });
                controller.textEditingControllerName.text =
                    controller.textEditingControllerPhone.text = "";
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //ShowDialogForUpdate
  showDialogUpdate(index) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Insert'),
          content: SizedBox(
            height: 200,
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                TextField(
                    controller: controller.textEditingControllerName,
                    maxLines: 1,
                    decoration: const InputDecoration(hintText: "Name"),
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                        // ignore: prefer_const_constructors
                        fontSize: 30,
                        color: Colors.black)),
                TextField(
                    controller: controller.textEditingControllerPhone,
                    maxLength: 11,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      hintText: "Phone",
                    ),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 30, color: Colors.black)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                  textStyle:
                      MaterialStateProperty.all(const TextStyle(fontSize: 25))),
              child: const Text('Update'),
              onPressed: () {
                setState(() {
                  if (controller.textEditingControllerName.text.isNotEmpty &&
                      controller.textEditingControllerName.text.isNotEmpty) {
                    model.name[index] =
                        controller.textEditingControllerName.text;
                    model.phone[index] =
                        controller.textEditingControllerPhone.text;
                  }
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
