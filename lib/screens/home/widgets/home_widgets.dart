import 'dart:ui';

import 'package:fleet_wise/core/navigation/navigation_service.dart';
import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/screens/account/account_page.dart';
import 'package:fleet_wise/screens/home/profit_loss_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeWidgets {
  // !Top section with gradient background
  Widget buildheaderAndBackgroundPhoneImage(BuildContext context, String name) {
    return Container(
      width: double.infinity,
      height: 700,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3F5BD9), Color(0xFF101010)],
          stops: [0.0, 0.4],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,

            child: SizedBox(
              height: 430,

              width: 430,
              child: Image.asset('assets/row_column.png', fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 37),
            child: SizedBox(
              height: 355,
              width: 417,
              child: Image.asset(
                'assets/background_dots.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status bar time and indicators
                const SizedBox(height: 60),
                // App name
                const Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Fleet',
                          style: TextStyle(
                            fontSize: 22,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'Wise',
                          style: TextStyle(
                            fontSize: 22,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // ! User greeting with avatar
                Row(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,

                      child: Image.asset('assets/Avaronn.png'),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Namaste 🙏",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        Text(
                          "$name Ji",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Profit tracking card
                      GestureDetector(
                        onTap: () {
                          //! Goto profit and loss page
                          CustomNavigation.push(context, ProfitLossPage());
                        },
                        child: Container(
                          height: 398,
                          width: 398,
                          margin: const EdgeInsets.only(top: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: const Color.fromARGB(
                                97,
                                171,
                                181,
                                189,
                              ), // Ensure AppColors.lightGrey is defined
                            ),
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              // Background image with padding
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ), // Top/bottom padding
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 10.0,
                                      sigmaY: 10.0,
                                    ), // Blur effect
                                    child: Container(
                                      width: double.infinity,
                                      height:
                                          326, // 398 - 16 (top padding) - 16 (bottom padding) - 20 (vertical top) - 20 (vertical bottom)
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/iPhone15.png',
                                          ),
                                          fit:
                                              BoxFit
                                                  .contain, // Scale image to fit within bounds
                                          alignment:
                                              Alignment
                                                  .center, // Center the image
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Existing child (Column with Text widgets)
                              Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .center, // Center vertically
                                  children: [
                                    const Text(
                                      "Track Your Profit & Loss in",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Text(
                                      "Real-Time!",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Expanded(child: SizedBox(height: 12)),
                                    ClipRRect(
                                      child: const Text(
                                        "See your profit and loss grow",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      "as your vehicle runs!",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Action buttons
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(
                            width: 180,
                            height: 54,
                            child: Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.add, size: 18),
                                label: const Text("Add First Vehicle"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    side: const BorderSide(
                                      color: Colors.black12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 180,
                            height: 54,
                            child: Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.add, size: 18),
                                label: const Text("Add First Driver"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    side: const BorderSide(
                                      color: Colors.black12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      //   What you get section
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ! What you get On Wleetwise
  Widget buildWhatYouGet() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              "What You Get On FleetWise:",
              style: TextStyle(
                fontSize: 18,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget sizedBoxHeight(double height) {
    return SizedBox(height: height);
  }

  // ! Bottom navigation bar
  buildBottomNavigationBar(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem('assets/Home.svg'),
            _buildNavItem('assets/Vehicles.svg'),
            _buildNavItem('assets/Drivers.svg'),
            GestureDetector(
              onTap: () => CustomNavigation.push(context, AccountPage()),
              child: _buildNavItem('assets/Account.svg'),
            ),
          ],
        ),
      ),
    );
  }

  //! NaveItem Builder
  Widget _buildNavItem(String image) {
    return SizedBox(width: 100, child: SvgPicture.asset(image));
  }
}
