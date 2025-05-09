import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class registerScreen extends StatefulWidget {           // contain ui things
  const registerScreen({super.key});
  

  @override
  State<registerScreen> createState() => _registerScreenState();
}


class _registerScreenState extends State<registerScreen> {      //state class for any logic or something is not ui

  File? profileimage;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        color: const Color.fromARGB(255, 193, 193, 193),
        padding: EdgeInsets.all(30.0),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 8,
            child: Padding(
              padding: const  EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,


                          
                  children: [

                    CircleAvatar(
                      radius: 60,
                      backgroundImage: profileimage == null
                          ? AssetImage('assets/profile_placeholder.png')  //if no image is selected, show default image
                          : FileImage(profileimage!) as ImageProvider,    //if image is selected, show selected image
                    ),

                    SizedBox(height: 20,),
                    ElevatedButton.icon(
                      onPressed: getImage,
                      icon: Icon(Icons.image),
                      label: Text('choose image'),
                    ),

                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                 
                      label: Text ('Email'),
                      ),
                
                    ),
                    TextField(
                      keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                        label: Text ('Name'),
                    ),
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        label: Text ('Phone number'),
                      ),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  label: Text ('Password'),
                ),
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  label: Text ('Address'),
                ),
              ),
               
            ],
              
               ),
           ),
          ),
        ),
      ),

      ),
      
    );

    
  }
      Future getImage() async {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          profileimage = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }
}