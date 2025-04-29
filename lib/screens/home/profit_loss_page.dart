import 'package:fleet_wise/providers/filter_bloc/filter_bloc.dart';
import 'package:fleet_wise/providers/filter_bloc/filter_state.dart';
import 'package:fleet_wise/providers/pnl_providers/monthly_pnl_bloc/monthly_pnl_bloc.dart';
import 'package:fleet_wise/providers/pnl_providers/monthly_pnl_bloc/monthly_pnl_event.dart';
import 'package:fleet_wise/providers/pnl_providers/today_pnl_bloc/today_pnl_bloc.dart';
import 'package:fleet_wise/providers/pnl_providers/today_pnl_bloc/today_pnl_event.dart';
import 'package:fleet_wise/providers/pnl_providers/yesterday_pnl_bloc/yesterday_pnl_bloc.dart';
import 'package:fleet_wise/providers/pnl_providers/yesterday_pnl_bloc/yesterday_pnl_event.dart';
import 'package:fleet_wise/screens/home/widgets/profilt_loss_widgets.dart';
import 'package:fleet_wise/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfitLossPage extends StatefulWidget {
  const ProfitLossPage({super.key});

  @override
  State<ProfitLossPage> createState() => _ProfitLossPageState();
}

class _ProfitLossPageState extends State<ProfitLossPage> {
  //! UpdateUserName
  updateUserName() async {
    final LocalStorageService localStorageService = LocalStorageService();
    name = await localStorageService.getUserName();

    setState(() {});
  }

  String name = '';

  @override
  void initState() {
    updateUserName();
    context.read<TodayPnLBloc>().add(FetchTodayPnLEvent(useCache: true));
    context.read<YesterdayPnlBloc>().add(
      FetchYesterdayPnLEvent(useCache: true),
    );
    context.read<MonthlyPnlBloc>().add(FetchMonthlyPnLEvent(useCache: true));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProfiltLossWidgets profiltLossWidgets = ProfiltLossWidgets();
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<FilterBloc, FilterState>(
          builder: (context, filterState) {
            return Column(
              children: [
                //! build heade and Deatail list and yesetday ,today and mothly navigation
                profiltLossWidgets.buildHeaderwithBackgroundEffectAndData(
                  selectedFileter: filterState.selectedFilter,
                  context: context,
                  name: name,
                ),
                //!  Container for Vehicle Overview
                profiltLossWidgets.buildVehicleOverview(),
              ],
            );
          },
        ),
      ),
    );
  }
}
