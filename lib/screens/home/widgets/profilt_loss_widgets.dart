import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/providers/filter_bloc/filter_bloc.dart';
import 'package:fleet_wise/providers/filter_bloc/filter_event.dart';
import 'package:fleet_wise/providers/filter_bloc/filter_state.dart';
import 'package:fleet_wise/providers/pnl_providers/monthly_pnl_bloc/monthly_pnl_bloc.dart';
import 'package:fleet_wise/providers/pnl_providers/monthly_pnl_bloc/monthly_pnl_event.dart';
import 'package:fleet_wise/providers/pnl_providers/monthly_pnl_bloc/monthly_pnl_state.dart';
import 'package:fleet_wise/providers/pnl_providers/today_pnl_bloc/today_pnl_bloc.dart';
import 'package:fleet_wise/providers/pnl_providers/today_pnl_bloc/today_pnl_event.dart';
import 'package:fleet_wise/providers/pnl_providers/today_pnl_bloc/today_pnl_state.dart';
import 'package:fleet_wise/providers/pnl_providers/yesterday_pnl_bloc/yesterday_pnl_bloc.dart';
import 'package:fleet_wise/providers/pnl_providers/yesterday_pnl_bloc/yesterday_pnl_event.dart';
import 'package:fleet_wise/providers/pnl_providers/yesterday_pnl_bloc/yesterday_pnl_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:flutter_svg/svg.dart';

class ProfiltLossWidgets {
  //!  Header and  Background Container with Row and column effect als yesterday,monthlt and today container
  buildHeaderwithBackgroundEffectAndData({
    required String
    selectedFileter, // Note: Consider renaming to selectedFilter
    required BuildContext context,
    required String name,
  }) {
    final Map<String, Color> backgroundColor = {
      'Yesterday': Color(0xFF94716B),
      'Monthly': Color(0xFF3F5BD9),
      'Today': Color(0xFF00725D),
    };
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [backgroundColor[selectedFileter]!, Color(0xFF101010)],
          stops: [0.0, 0.12],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      width: 430,
      height: MediaQuery.of(context).size.height - 110,
      child: Stack(
        children: [
          Stack(
            children: [
              Positioned(
                top: 0,
                child: SizedBox(
                  height: 430,
                  width: 430,
                  child: Image.asset(
                    'assets/row_column.png',
                    fit: BoxFit.cover,
                  ),
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
            ],
          ),
          Column(
            children: [
              // Top section with gradient background and profit display
              Padding(
                // Replaced Positioned with Padding
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    Row(
                      children: [
                        Image.asset(
                          "assets/Avaronn.png",
                          height: 60,
                          width: 60,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Namaste 🙏",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
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
                    const SizedBox(height: 25),
                    // Filter buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFilterButton("Yesterday", context),
                        _buildFilterButton("Today", context),
                        _buildFilterButton("Monthly", context),
                      ],
                    ),
                    const SizedBox(height: 2),
                  ],
                ),
              ),
              // Dynamic content based on selected filter
              SizedBox(
                height: 546,
                child: Container(child: _buildContentForSelectedFilter()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ! Build filter button
  Widget _buildFilterButton(String text, BuildContext cotext) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, filterState) {
        final bool isSelected = filterState.selectedFilter == text;
        return GestureDetector(
          onTap: () {
            context.read<FilterBloc>().add(SelectFilter(text));
          },
          child: Container(
            margin: EdgeInsets.only(right: 10),
            width: 112,
            height: 41,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color:
                  isSelected ? Colors.white : Color.fromARGB(31, 255, 255, 255),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color:
                    isSelected
                        ? AppColors.white
                        : const Color.fromARGB(142, 255, 255, 255),
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: isSelected ? AppColors.black : Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //! Build content for the selected filter
  Widget _buildContentForSelectedFilter() {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, filterState) {
        if (filterState.selectedFilter == "Yesterday") {
          return _buildYesterdayContent(context);
        } else if (filterState.selectedFilter == "Today") {
          return _buildTodayContent(context);
        } else if (filterState.selectedFilter == "Monthly") {
          return _buildThisMounthContent(context);
        } else {
          return const Center(child: Text("No Data"));
        }
      },
    );
  }

  // ! Yesterday details list widget
  Widget _buildYesterdayContent(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<YesterdayPnlBloc>().add(
          FetchYesterdayPnLEvent(useCache: false),
        );
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FadeInDown(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Profit/Loss",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Fri, 7 Mar",
                      style: TextStyle(color: Colors.white38, fontSize: 16),
                    ),
                  ],
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
                  child: BlocBuilder<YesterdayPnlBloc, YesterdayPnlState>(
                    builder: (context, state) {
                      String pnl = '0';
                      if (state is YesterdayPnLLoaded) {
                        if (state.yesterdayPnL.header.profitOrLoss
                            .toString()
                            .isNotEmpty) {
                          pnl =
                              state.yesterdayPnL.header.profitOrLoss
                                  .toInt()
                                  .toString();
                        }
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "₹$pnl",
                            style: TextStyle(
                              color: Color(0xFF00CBA6),
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            "predicted: ₹1,523",
                            style: TextStyle(
                              color: Colors.white38,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // const SizedBox(height: 16), // Add spacing between sections
          RefreshIndicator(
            onRefresh: () async {
              context.read<YesterdayPnlBloc>().add(
                FetchYesterdayPnLEvent(useCache: false),
              );
            },
            child: SizedBox(
              height: 500,
              // color: Colors.grey[100],
              child: FadeInUp(
                child: BlocBuilder<YesterdayPnlBloc, YesterdayPnlState>(
                  builder: (context, state) {
                    if (state is YesterdayPnLLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is YesterdayPnLLoaded) {
                      if (state.yesterdayPnL.vehicles.isEmpty) {
                        return Center(
                          child: Text(
                            'No internet connection',
                            style: TextStyle(
                              color: AppColors.baseColor,
                              fontSize: 18,
                            ),
                          ),
                        );
                      }

                      final todayPnL = state.yesterdayPnL;
                      final header = todayPnL.header;
                      final firstVehicle = todayPnL.vehicles[0];

                      return ListView(
                        children: [
                          buildTransactionItem(
                            image: "assets/earning.svg",
                            title: "Earnings",
                            subtitle: "Total revenue generated",
                            suffixTitle: "₹ ${firstVehicle.earning}",
                            suffixSubTitle: "predicted ₹1,200",
                          ),
                          buildTransactionItem(
                            image: "assets/cost.svg",
                            title: "Variable Cost",
                            subtitle: "Expenses & maintenance",
                            suffixTitle:
                                "₹ ${firstVehicle.costing.toStringAsFixed(0)}",
                            suffixSubTitle: "predicted ₹1,20",
                          ),
                          buildTransactionItem(
                            image: "assets/trip.svg",
                            title: "No. of trips completed",
                            subtitle: "Successful trips finished",
                            suffixTitle: header.tripsCompleted.toString(),
                          ),
                          buildTransactionItem(
                            image: "assets/vehicle.svg",
                            title: "Vehicles on the road",
                            subtitle: "Active fleet count",
                            suffixTitle: header.vehiclesOnRoad.toString(),
                          ),
                          buildTransactionItem(
                            image: "assets/distance.svg",
                            title: "Total distance travelled",
                            subtitle: "Kilometers covered by the fleet",
                            suffixTitle: "${header.totalDistance} km",
                          ),
                          SizedBox(height: 110),
                        ],
                      );
                    } else if (state is YesterdayPnLError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: TextStyle(color: Colors.amber),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'No data found.',
                          style: TextStyle(
                            color: AppColors.baseColor,
                            fontSize: 18,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ! Today details list widget
  Widget _buildTodayContent(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<TodayPnLBloc>().add(FetchTodayPnLEvent(useCache: false));
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FadeInDown(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Profit/Loss",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Fri, 7 Mar",
                      style: TextStyle(color: Colors.white38, fontSize: 16),
                    ),
                  ],
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
                  child: BlocBuilder<TodayPnLBloc, TodayPnLState>(
                    builder: (context, state) {
                      String pnl = '0';
                      if (state is TodayPnLLoaded) {
                        if (state.todayPnL.header.profitOrLoss
                            .toString()
                            .isNotEmpty) {
                          pnl =
                              state.todayPnL.header.profitOrLoss
                                  .toInt()
                                  .toString();
                        }
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "₹$pnl",
                            style: TextStyle(
                              color: Color(0xFF00CBA6),
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            "predicted: ₹1,523",
                            style: TextStyle(
                              color: Colors.white38,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // const SizedBox(height: 16), // Add spacing between sections
          RefreshIndicator(
            onRefresh: () async {
              context.read<TodayPnLBloc>().add(
                FetchTodayPnLEvent(useCache: false),
              );
            },
            child: SizedBox(
              height: 500,

              child: FadeInUp(
                child: BlocBuilder<TodayPnLBloc, TodayPnLState>(
                  builder: (context, state) {
                    if (state is TodayPnLLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TodayPnLLoaded) {
                      log('---------------------');
                      log('${state.todayPnL.vehicles.length}');

                      log('---------------------');
                      if (state.todayPnL.vehicles.isEmpty) {
                        return Center(
                          child: Text(
                            'No internet connection',
                            style: TextStyle(
                              color: AppColors.baseColor,
                              fontSize: 18,
                            ),
                          ),
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
                            subtitle: "Total revenue generated",
                            suffixTitle: "₹ ${firstVehicle.earning}",
                            suffixSubTitle: "predicted ₹1,200",
                          ),
                          buildTransactionItem(
                            image: "assets/cost.svg",
                            title: "Variable Cost",
                            subtitle: "Expenses & maintenance",
                            suffixTitle:
                                "₹ ${firstVehicle.costing.toStringAsFixed(0)}",
                            suffixSubTitle: "predicted ₹1,20",
                          ),
                          buildTransactionItem(
                            image: "assets/trip.svg",
                            title: "No. of trips completed",
                            subtitle: "Successful trips finished",
                            suffixTitle: header.tripsCompleted.toString(),
                          ),
                          buildTransactionItem(
                            image: "assets/vehicle.svg",
                            title: "Vehicles on the road",
                            subtitle: "Active fleet count",
                            suffixTitle: header.vehiclesOnRoad.toString(),
                          ),
                          buildTransactionItem(
                            image: "assets/distance.svg",
                            title: "Total distance travelled",
                            subtitle: "Kilometers covered by the fleet",
                            suffixTitle: "${header.totalDistance} km",
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
                      return const Center(
                        child: Text(
                          'No data found.',
                          style: TextStyle(
                            color: AppColors.baseColor,
                            fontSize: 18,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //! Monthly  details list widget
  Widget _buildThisMounthContent(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<MonthlyPnlBloc>().add(
          FetchMonthlyPnLEvent(useCache: false),
        );
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FadeInDown(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Profit/Loss",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Fri, 7 Mar",
                      style: TextStyle(color: Colors.white38, fontSize: 16),
                    ),
                  ],
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
                  child: BlocBuilder<MonthlyPnlBloc, MonthlyPnLState>(
                    builder: (context, state) {
                      String pnl = '0';
                      if (state is MonthlyPnLLoaded) {
                        if (state.monthlyPnL.header.profitOrLoss
                            .toString()
                            .isNotEmpty) {
                          pnl =
                              state.monthlyPnL.header.profitOrLoss
                                  .toInt()
                                  .toString();
                        }
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "₹$pnl",
                            style: TextStyle(
                              color: Color(0xFF00CBA6),
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            "predicted: ₹1,523",
                            style: TextStyle(
                              color: Colors.white38,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          RefreshIndicator(
            onRefresh: () async {
              context.read<MonthlyPnlBloc>().add(
                FetchMonthlyPnLEvent(useCache: false),
              );
            },
            child: SizedBox(
              height: 500,

              child: FadeInUp(
                child: BlocBuilder<MonthlyPnlBloc, MonthlyPnLState>(
                  builder: (context, state) {
                    if (state is MonthlyPnLLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is MonthlyPnLLoaded) {
                      if (state.monthlyPnL.vehicles.isEmpty) {
                        return Center(
                          child: Text(
                            'No internet connection',
                            style: TextStyle(
                              color: AppColors.baseColor,
                              fontSize: 18,
                            ),
                          ),
                        );
                      }

                      final todayPnL = state.monthlyPnL;
                      final header = todayPnL.header;
                      final firstVehicle = todayPnL.vehicles[0];

                      return ListView(
                        children: [
                          buildTransactionItem(
                            image: "assets/earning.svg",
                            title: "Earnings",
                            subtitle: "Total revenue generated",
                            suffixTitle: "₹ ${firstVehicle.earning}",
                            suffixSubTitle: "predicted ₹1,200",
                          ),
                          buildTransactionItem(
                            image: "assets/cost.svg",
                            title: "Variable Cost",
                            subtitle: "Expenses & maintenance",
                            suffixTitle:
                                "₹ ${firstVehicle.costing.toStringAsFixed(0)}",
                            suffixSubTitle: "predicted ₹1,20",
                          ),
                          buildTransactionItem(
                            image: "assets/trip.svg",
                            title: "No. of trips completed",
                            subtitle: "Successful trips finished",
                            suffixTitle: header.tripsCompleted.toString(),
                          ),
                          buildTransactionItem(
                            image: "assets/vehicle.svg",
                            title: "Vehicles on the road",
                            subtitle: "Active fleet count",
                            suffixTitle: header.vehiclesOnRoad.toString(),
                          ),
                          buildTransactionItem(
                            image: "assets/distance.svg",
                            title: "Total distance travelled",
                            subtitle: "Kilometers covered by the fleet",
                            suffixTitle: "${header.totalDistance} km",
                          ),
                          SizedBox(height: 110),
                        ],
                      );
                    } else if (state is MonthlyPnLError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: TextStyle(color: Colors.amber),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'No data found.',
                          style: TextStyle(
                            color: AppColors.baseColor,
                            fontSize: 18,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //! Details container for icons , title ,subtitle, and suffix title etc
  Widget buildTransactionItem({
    required String title,
    required String subtitle,
    required String suffixTitle,
    required String image,
    String? suffixSubTitle,
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
                    color: Color(0xFF757575),
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

  //!  Container for Vehicle Overview
  buildVehicleOverview() {
    return SizedBox(
      height: 200,

      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Image.asset('assets/ambulance.png', width: 24, height: 24),
            ),
            Text(
              'Vehicles Overview',
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
