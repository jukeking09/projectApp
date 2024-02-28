import 'package:flutter/material.dart';
import 'package:register_login/api.dart';
import 'package:register_login/userid.dart';
// import 'package:page_transition/page_transition.dart';
int? userId; // Declare userId variable to store the retrieved user ID
class HomePage extends StatefulWidget { 
  const HomePage({super.key}); 
  @override 
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState(); 
} 
  
class _HomePageState extends State<HomePage> { 
  int pageIndex = 0; 

   @override
  void initState() {
    super.initState();
    // Call getUserId method to retrieve user ID when the widget initializes
    getUserId();
  }
   
  Future<void> getUserId() async {
    // Retrieve the user ID from shared preferences
    userId = await UserIdStorage.getUserId();

    // Set the state to trigger a rebuild and display the user ID
    setState(() {});
  }

  @override 
  Widget build(BuildContext context) {
    final pages = [ 
    const Page1(), 
    const Page2(), 
    const Page3(), 
    Page4(), 
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
      ),
      body: FutureBuilder<UserDetail>(
        future: ApiService.getUserDetail(userId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ID: ${snapshot.data!.id}'),
                  Text('Email: ${snapshot.data!.email}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
