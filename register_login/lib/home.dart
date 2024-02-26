import 'package:flutter/material.dart';
import 'package:register_login/api.dart';

class HomePage extends StatefulWidget { 
  const HomePage({super.key}); 
  @override 
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState(); 
} 
  
class _HomePageState extends State<HomePage> { 
  int pageIndex = 0; 
  late int userId;
  late String email = ''; // Declare email variable

@override
void initState() {
  super.initState();
  
  // Call getUserDetails function to fetch user details
  ApiService.getUserDetails(userId).then((userData) {
    // Extract email from the response
    email = userData['email'];
    // Update the state to rebuild the UI with the new email
    setState(() {});
  }).catchError((error) {
    // Handle any errors that occur during the API call
    print('Error fetching user details: $error');
  });
}

  @override 
  Widget build(BuildContext context) {
    final pages = [ 
    const Page1(), 
    const Page2(), 
    const Page3(), 
    Page4(email: email), 
  ]; 
    return Scaffold( 
      
      backgroundColor: Color.fromARGB(255, 255, 255, 255), 
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: Image.asset( 
        //   'images/logo.png',
        //   width: 30,
        //   height: 20,
        // ), 
        title: const Text( 
          "ByeLingual", 
          style: TextStyle( 
            color: Colors.white, 
            fontSize: 25, 
            fontWeight: FontWeight.w600, 
          ), 
        ), 
        centerTitle: true, 
        backgroundColor: Color.fromARGB(255, 224, 3, 102), 
      ), 
      body: 
      pages[pageIndex], 
      bottomNavigationBar: buildMyNavBar(context),
    ); 
  } 
  
  Container buildMyNavBar(BuildContext context) { 
    return Container( 
      height: 60, 
      decoration: const BoxDecoration( 
        color: Colors.pinkAccent, 
        borderRadius: BorderRadius.only( 
          topLeft: Radius.circular(20), 
          topRight: Radius.circular(20), 
        ), 
      ), 
      child: Row( 
        mainAxisAlignment: MainAxisAlignment.spaceAround, 
        children: [ 
          IconButton( 
            enableFeedback: false, 
            onPressed: () { 
              setState(() { 
                pageIndex = 0; 
              }); 
            }, 
            icon: pageIndex == 0 
                ? const Icon( 
                    Icons.home_filled, 
                    color: Colors.white, 
                    size: 35, 
                  ) 
                : const Icon( 
                    Icons.home_outlined, 
                    color: Colors.white, 
                    size: 35, 
                  ), 
          ), 
          IconButton( 
            enableFeedback: false, 
            onPressed: () { 
              setState(() { 
                pageIndex = 1; 
              }); 
            }, 
            icon: pageIndex == 1 
                ? const Icon( 
                    Icons.work_rounded, 
                    color: Colors.white, 
                    size: 35, 
                  ) 
                : const Icon( 
                    Icons.work_outline_outlined, 
                    color: Colors.white, 
                    size: 35, 
                  ), 
          ), 
          IconButton( 
            enableFeedback: false, 
            onPressed: () { 
              setState(() { 
                pageIndex = 2; 
              }); 
            }, 
            icon: pageIndex == 2 
                ? const Icon( 
                    Icons.widgets_rounded, 
                    color: Colors.white, 
                    size: 35, 
                  ) 
                : const Icon( 
                    Icons.widgets_outlined, 
                    color: Colors.white, 
                    size: 35, 
                  ), 
          ), 
          IconButton( 
            enableFeedback: false, 
            onPressed: () { 
              setState(() { 
                pageIndex = 3; 
              }); 
            }, 
            icon: pageIndex == 3 
                ? const Icon( 
                    Icons.person, 
                    color: Colors.white, 
                    size: 35, 
                  ) 
                : const Icon( 
                    Icons.person_outline, 
                    color: Colors.white, 
                    size: 35, 
                  ), 
          ), 
        ], 
      ), 
    ); 
  } 
} 
  
class Page1 extends StatelessWidget { 
  const Page1({Key? key}) : super(key: key); 
  
  @override 
  Widget build(BuildContext context) { 
    return Container( 
      color: const Color.fromARGB(255, 255, 255, 255), 
      child: const Center( 
        child: Text( 
          "Page Number 1", 
          style: TextStyle( 
            color: Colors.green, 
            fontSize: 45, 
            fontWeight: FontWeight.w500, 
          ), 
        ), 
      ), 
    ); 
  } 
} 
  
class Page2 extends StatelessWidget { 
  const Page2({Key? key}) : super(key: key); 
  
  @override 
  Widget build(BuildContext context) { 
    return Container( 
      color: const Color.fromARGB(255, 255, 255, 255), 
      child: Center( 
        child: Text( 
          "Page Number 2", 
          style: TextStyle( 
            color: Colors.red[900], 
            fontSize: 45, 
            fontWeight: FontWeight.w500, 
          ), 
        ), 
      ), 
    ); 
  } 
} 
  
class Page3 extends StatelessWidget { 
  const Page3({Key? key}) : super(key: key); 
  
  @override 
  Widget build(BuildContext context) { 
    return Container( 
      color: const Color.fromARGB(255, 255, 255, 255), 
      child: Center( 
        child: Text( 
          "Page Number 3", 
          style: TextStyle( 
            color: Colors.blue[900], 
            fontSize: 45, 
            fontWeight: FontWeight.w500, 
          ), 
        ), 
      ), 
    ); 
  } 
} 

class Page4 extends StatelessWidget {
  // final int userId;
  final String email;
  
  // const Page4({Key? key, required this.userId, required this.email});
  const Page4({Key? key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('User Details')),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text('User ID: $userId'),
            Text('Email: $email'),
          ],
        ),
      ),
    );
  }
}