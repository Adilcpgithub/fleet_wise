import 'package:fleet_wise/screens/home/widgets/home_widgets.dart';
import 'package:fleet_wise/services/local_storage_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  updateUserName() async {
    final LocalStorageService localStorageService = LocalStorageService();
    name = await localStorageService.getUserName();

    setState(() {});
  }

  String name = '';
  @override
  void initState() {
    updateUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeWidgets homeWidgets = HomeWidgets();
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // !Top section with gradient background
                  homeWidgets.buildheaderAndBackgroundPhoneImage(context, name),
                  //!SizedBox
                  homeWidgets.sizedBoxHeight(20),
                  // ! What you get On Wleetwise
                  homeWidgets.buildWhatYouGet(),
                  //!SizedBox
                  homeWidgets.sizedBoxHeight(60),
                ],
              ),
            ),
            //! Bottom navigation bar
            Positioned(
              bottom: 0,
              child: homeWidgets.buildBottomNavigationBar(context),
            ),
          ],
        ),
      ),
    );
  }
}
