import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/services/profi_loss_service.dart';
import 'package:flutter/material.dart';

class ProfitLossPage extends StatefulWidget {
  const ProfitLossPage({super.key});

  @override
  State<ProfitLossPage> createState() => _ProfitLossPageState();
}

class _ProfitLossPageState extends State<ProfitLossPage> {
  String selectedFilter = "Today"; // Default selected filter

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
                          ProfiLossService profiLossService =
                              ProfiLossService();
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
          height: 500,
          // color: Colors.grey[100],
          child: ListView.builder(
            itemBuilder: (context, index) {
              return buildTransactionItem(
                icon: Icons.local_gas_station,
                title: "Petrol Paid",
                amount: "₹500",
                time: "10 minutes ago",
                color: Colors.green,
              );
            },
            itemCount: 10,
          ),
        ),
      ],
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
                icon: Icons.local_gas_station,
                title: "Petrol Paid",
                amount: "₹500",
                time: "10 minutes ago",
                color: Colors.green,
              ),
              buildTransactionItem(
                icon: Icons.filter_alt,
                title: "Oil Filter Installed",
                amount: "₹250",
                time: "1 hour ago",
                color: Colors.blue,
              ),
              buildTransactionItem(
                icon: Icons.tire_repair,
                title: "Tyre Air Filled",
                amount: "₹50",
                time: "Yesterday at 5:30 PM",
                color: Colors.orange,
              ),
              buildTransactionItem(
                icon: Icons.oil_barrel,
                title: "Oil change expense",
                amount: "₹1,200",
                time: "2 days ago",
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
                icon: Icons.local_gas_station,
                title: "Petrol Paid",
                amount: "₹500",
                time: "10 minutes ago",
                color: Colors.green,
              ),
              buildTransactionItem(
                icon: Icons.filter_alt,
                title: "Oil Filter Installed",
                amount: "₹250",
                time: "1 hour ago",
                color: Colors.blue,
              ),
              buildTransactionItem(
                icon: Icons.tire_repair,
                title: "Tyre Air Filled",
                amount: "₹50",
                time: "Yesterday at 5:30 PM",
                color: Colors.orange,
              ),
              buildTransactionItem(
                icon: Icons.oil_barrel,
                title: "Oil change expense",
                amount: "₹1,200",
                time: "2 days ago",
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

Widget buildTransactionItem({
  required IconData icon,
  required String title,
  required String amount,
  required String time,
  required MaterialColor color,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.only(bottom: 16),
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
    child: Row(
      children: [
        Icon(icon, size: 40, color: color),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(amount, style: TextStyle(color: color, fontSize: 16)),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Text(time, style: const TextStyle(color: Colors.grey)),
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
