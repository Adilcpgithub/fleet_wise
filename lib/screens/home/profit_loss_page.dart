import 'package:animate_do/animate_do.dart';
import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/providers/pnl_providers/today_pnl/today_pnl_bloc.dart';
import 'package:fleet_wise/providers/pnl_providers/today_pnl/today_pnl_event.dart';
import 'package:fleet_wise/providers/pnl_providers/today_pnl/today_pnl_state.dart';
import 'package:fleet_wise/services/profi_loss_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfitLossPage extends StatefulWidget {
  const ProfitLossPage({super.key});

  @override
  State<ProfitLossPage> createState() => _ProfitLossPageState();
}

class _ProfitLossPageState extends State<ProfitLossPage> {
  String selectedFilter = "Today"; // Default selected filter
  @override
  void initState() {
    context.read<TodayPnLBloc>().add(FetchTodayPnLEvent(useCache: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF94716B), Color(0xFF101010)],
            stops: [
              30 / (MediaQuery.of(context).size.height - 180), // top 50px
              90 /
                  (MediaQuery.of(context).size.height -
                      180), // sharp cut to next color
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        height: MediaQuery.of(context).size.height - 180,
        child: Column(
          children: [
            // Top section with gradient background and profit display
            Container(
              //! changed color
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),

                      // ! Header section
                      // ! remove this geture only for testin purpose
                      GestureDetector(
                        onTap: () async {
                          ProfilLossService profiLossService =
                              ProfilLossService();
                          await profiLossService.getTodayPnL();
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: const CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Icon(
                                  Icons.person_outline,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Namaste 🙏",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "Raman Ji",
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
                      ),

                      const SizedBox(height: 24),

                      // Filter buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildFilterButton("Yesterday"),
                          _buildFilterButton("Today"),
                          _buildFilterButton("Monthly"),
                        ],
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),

            // Dynamic content based on selected filter
            Expanded(child: Container(child: _buildContentForSelectedFilter())),
          ],
        ),
      ),
    );
  }

  // ! Build filter button
  Widget _buildFilterButton(String text) {
    final bool isSelected = selectedFilter == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = text; // Update the selected filter
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.white,
            width: 2,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            //  color: isSelected ? Colors.black : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // Build content for the selected filter
  Widget _buildContentForSelectedFilter() {
    if (selectedFilter == "Yesterday") {
      return _buildYesterdayContent();
    } else if (selectedFilter == "Today") {
      return _buildTodayContent();
    } else if (selectedFilter == "Monthly") {
      return _buildThisMounthContent();
    } else {
      return const Center(child: Text("No Data"));
    }
  }

  // ! Yesterday details list widget
  Widget _buildYesterdayContent() {
    return FadeInUp(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FadeInDown(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Profit/Loss",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "+₹7,374",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16), // Add spacing between sections
          SizedBox(
            height: 500,
            // color: Colors.grey[100],
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<TodayPnLBloc>().add(
                  FetchTodayPnLEvent(useCache: false),
                );
              },
              child: BlocBuilder<TodayPnLBloc, TodayPnLState>(
                builder: (context, state) {
                  if (state is TodayPnLLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TodayPnLLoaded) {
                    if (state.todayPnL.vehicles.isEmpty) {
                      return Text(
                        'no data fount',
                        style: TextStyle(color: Colors.amber),
                      );
                    }

                    final todayPnL = state.todayPnL;
                    final header = todayPnL.header;
                    final firstVehicle = todayPnL.vehicles[0];

                    return ListView(
                      children: [
                        buildTransactionItem(
                          image: "assets/earning.svg",
                          title: "Earnings",
                          subtitle: "₹500",
                          suffixTitle: "₹ ${firstVehicle.earning}",
                          suffixSubTitle: "predicted ₹1,200",
                          color: Colors.green,
                        ),
                        buildTransactionItem(
                          image: "assets/cost.svg",
                          title: "Variable Cost",
                          subtitle: "₹500",
                          suffixTitle:
                              "₹ ${firstVehicle.costing.toStringAsFixed(0)}",
                          suffixSubTitle: "predicted ₹1,20",
                          color: Colors.green,
                        ),
                        buildTransactionItem(
                          image: "assets/trip.svg",
                          title: "No. of trips completed",
                          subtitle: "₹500",
                          suffixTitle: header.tripsCompleted.toString(),
                          color: Colors.green,
                        ),
                        buildTransactionItem(
                          image: "assets/vehicle.svg",
                          title: "Vehicles on the road",
                          subtitle: "₹500",
                          suffixTitle: header.vehiclesOnRoad.toString(),
                          color: Colors.green,
                        ),
                        buildTransactionItem(
                          image: "assets/distance.svg",
                          title: "Total distance travelled",
                          subtitle: "₹500",
                          suffixTitle: "${header.totalDistance} km",
                          color: Colors.green,
                        ),
                        SizedBox(height: 110),
                      ],
                    );
                  } else if (state is TodayPnLError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: TextStyle(color: Colors.amber),
                      ),
                    );
                  } else {
                    return const Center(child: Text('No data found.'));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ! Today details list widget
  Widget _buildTodayContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Profit/Loss",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "+₹7,374",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16), // Add spacing between sections
        Container(
          color: Colors.grey[100],
          child: ListView(
            shrinkWrap: true, // Prevents infinite height issues
            physics:
                const NeverScrollableScrollPhysics(), // Disable nested scrolling
            padding: const EdgeInsets.all(16),
            children: [
              // Transaction items
              buildTransactionItem(
                image: "assets/cost.png",
                title: "Petrol Paid",
                subtitle: "₹500",
                suffixTitle: "10 minutes ago",
                color: Colors.green,
              ),
              buildTransactionItem(
                image: "assets/cost.png",
                title: "Oil Filter Installed",
                subtitle: "₹250",
                suffixTitle: "1 hour ago",
                color: Colors.blue,
              ),
              buildTransactionItem(
                image: "assets/cost.png",
                title: "Tyre Air Filled",
                subtitle: "₹50",
                suffixTitle: "Yesterday at 5:30 PM",
                color: Colors.orange,
              ),
              buildTransactionItem(
                image: "assets/cost.png",
                title: "Oil change expense",
                subtitle: "₹1,200",
                suffixTitle: "2 days ago",
                color: Colors.purple,
              ),
              const SizedBox(height: 16),
              // Vehicles overview section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.directions_car, size: 20),
                        SizedBox(width: 8),
                        Text(
                          "Vehicles Overview",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildVehicleStats(
                          Icons.directions_car,
                          "2",
                          "Total Vehicles",
                        ),
                        _buildVehicleStats(Icons.person, "3", "Total Drivers"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //! Monthly  details list widget
  Widget _buildThisMounthContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Profit/Loss",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "+₹7,374",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16), // Add spacing between sections
        Container(
          color: Colors.grey[100],
          child: ListView(
            shrinkWrap: true, // Prevents infinite height issues
            physics:
                const NeverScrollableScrollPhysics(), // Disable nested scrolling
            padding: const EdgeInsets.all(16),
            children: [
              // Transaction items
              buildTransactionItem(
                image: "assets/earning.svg",
                title: "Petrol Paid",
                subtitle: "₹500",
                suffixTitle: "10 minutes ago",
                color: Colors.green,
              ),
              buildTransactionItem(
                image: "assets/Icon1.svg",
                title: "Oil Filter Installed",
                subtitle: "₹250",
                suffixTitle: "1 hour ago",
                color: Colors.blue,
              ),
              buildTransactionItem(
                image: "assets/Icon2.svg",
                title: "Tyre Air Filled",
                subtitle: "₹50",
                suffixTitle: "Yesterday at 5:30 PM",
                color: Colors.orange,
              ),
              buildTransactionItem(
                image: "assets/Icon3.svg",
                title: "Oil change expense",
                subtitle: "₹1,200",
                suffixTitle: "2 days ago",
                color: Colors.purple,
              ),
              const SizedBox(height: 16),
              // Vehicles overview section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.directions_car, size: 20),
                        SizedBox(width: 8),
                        Text(
                          "Vehicles Overview",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildVehicleStats(
                          Icons.directions_car,
                          "2",
                          "Total Vehicles",
                        ),
                        _buildVehicleStats(Icons.person, "3", "Total Drivers"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//! Widget for icons , title and suffix etc
Widget buildTransactionItem({
  required String title,
  required String subtitle,
  required String suffixTitle,
  required String image,
  String? suffixSubTitle,
  required MaterialColor color,
}) {
  return Container(
    height: 69,
    padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 15),
    margin: const EdgeInsets.only(bottom: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        SizedBox(
          height: 60,
          child: SvgPicture.asset(image, height: 36, width: 36),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                subtitle,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(suffixTitle, style: const TextStyle(color: Colors.black)),
            suffixSubTitle != null
                ? Text(
                  suffixSubTitle,
                  style: TextStyle(color: Color(0xFF757575), fontSize: 12),
                )
                : SizedBox.shrink(),
          ],
        ),
      ],
    ),
  );
}

_buildVehicleStats(IconData icon, String count, String label) {
  return Row(
    children: [
      Icon(icon, size: 30, color: Colors.blue),
      const SizedBox(height: 8),
      Text(
        count,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 4),
      Text(label),
    ],
  );
}
