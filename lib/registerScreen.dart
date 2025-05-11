import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:worker_task_management_system/my_config.dart';
import 'package:worker_task_management_system/loginScreen.dart';



class registerScreen extends StatefulWidget {           // contain ui things
  const registerScreen({super.key});
  

  @override
  State<registerScreen> createState() => _registerScreenState();
}


class _registerScreenState extends State<registerScreen> {      //state class for any logic or something is not ui
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  File? profileimage;
  Uint8List? webImageBytes;
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
                    GestureDetector(
                      onTap: (){
                        showSelectionDialog();    //create show dialog : we want user to choose upload from camera or gallery 
                      },
                      child: Container(
                        height: 200,
                        width: 400,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                          image: profileimage == null
                          ? const AssetImage('assets/images/profile_placeholder.png')
                          :_buildProfileImage(),
                          ),
                        ),
                      ),  
                    ),  


                    SizedBox(height: 20,),
                    ElevatedButton.icon(
                      onPressed: getImage,
                      icon: Icon(Icons.image),
                      label: Text('choose image'),
                    ),

                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                 
                      label: Text ('Email'),
                      ),
                
                    ),
                    TextField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                        label: Text ('Name'),
                    ),
                    ),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        label: Text ('Phone number'),
                      ),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  label: Text ('Password'),
                ),
              ),
              TextField(
                controller: addressController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  label: Text ('Address'),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: 400,
                child: ElevatedButton(
                  onPressed:registerUserDialog, 
                  child: const Text('register'),
                )
              )
               
            ],
              
               ),
           ),
          ),
        ),
      ),

      ),
      
    );

    
  }

  // THIS IS FOR REGISTER USER METHOD. 

  void registerUserDialog() {  
    String name = nameController.text;
    String email = emailController.text;
    String phone = phoneController.text;
    String password = passwordController.text;
    String address = addressController.text;

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty || address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields"),
      ));
      return;
    }

    // show dialog. Want to pop up the alert dialog confirmation to register account
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("Register this account?"),
          content: Text("Are you sure?"),
          actions: [
            TextButton(
              child:const Text ("OK"), 
              onPressed: (){
                Navigator.of(context).pop();
                registerUser();
              }
            
            )
          ],
        );
      });

    
    
  }

    //we want to register the user into database
    void registerUser() {
      // TODO: implement registerUser
      String name = nameController.text;
      String email = emailController.text;
      String phone = phoneController.text;
      String password = passwordController.text;
      String address = addressController.text;

      http.post(Uri.parse("${MyConfig.myurl}/php/register_user.php"),
        body: {
          "name": name,
          "email": email,
          "password": password,
          "phone": phone,
          "address": address,
        }).then((response)  {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Success!"),
          ));
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Failed to register"),
          ));
        }
      }
      });
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
     void showSelectionDialog() {          
          showDialog(
            context: context, 
            builder: (BuildContext context){                 
              return AlertDialog(
                title: const Text (
                  "Select from",
                  style: TextStyle(),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _selectFromCamera();                          //camera option
                    },
                    child: const Text("From Camera")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _selectfromGallery();                        //gallery option: build this both method
                    },
                    child: const Text("From Gallery"))
                  ],
                ),
    
              );
            });                     
        }

    Future<void> _selectFromCamera() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: kIsWeb ? ImageSource.gallery : ImageSource.camera,
        maxHeight: 800,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        profileimage = File(pickedFile.path);
        if (kIsWeb) {
          // Read image bytes for web.
          webImageBytes = await pickedFile.readAsBytes();
        }
        setState(() {});
      } else {
        print('No image selected.');
      }
  }

  Future<void> _selectfromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      profileimage = File(pickedFile.path);
      setState(() {});
    }
  }

  ImageProvider _buildProfileImage() {
    if (profileimage != null) {
      if (kIsWeb) {
        // For web, use MemoryImage.
        return MemoryImage(webImageBytes!);
      } else {
        // For mobile, convert XFile to File.
        return FileImage(File(profileimage!.path));
      }
    }
    return const AssetImage('assets/images/profile_placeholder.png');
  }
}