import 'package:flutter/material.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
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
}