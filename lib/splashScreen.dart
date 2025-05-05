import 'package:flutter/material.dart';
import 'package:worker_task_management_system/signIn.dart';
import 'package:lottie/lottie.dart';


class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 7),(){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => signIn()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 130, 52, 213),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'asset/animations/splash.json',width:250,height:250,
           
          ),
          const SizedBox(height: 50,),
          const CircularProgressIndicator(
                  
            ),
          ],
          ),
        ),
      ),
    );
      
      
  }
}