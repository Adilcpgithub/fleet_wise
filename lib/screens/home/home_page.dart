import 'package:fleet_wise/screens/home/widgets/home_widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                  homeWidgets.buildheaderAndBackgroundPhoneImage(context),
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
