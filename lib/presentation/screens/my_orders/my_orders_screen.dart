import 'package:fuiopia/presentation/common_blocs/order/bloc.dart';
import 'package:fuiopia/data/models/models.dart';
import 'package:fuiopia/configs/config.dart';
import 'package:fuiopia/constants/constants.dart';
import 'package:fuiopia/presentation/widgets/custom_widgets.dart';
import 'package:fuiopia/presentation/widgets/single_card/order_card.dart';
import 'package:fuiopia/utils/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentTabIndex = 0;

  @override
  void initState() {
    BlocProvider.of<OrderBloc>(context).add(LoadMyOrders());

    tabController = TabController(
      length: 2,
      vsync: this,
    );

    tabController.addListener(() {
      setState(() {
        currentTabIndex = tabController.index;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Translate.of(context).translate("my_orders"))),
      body: SafeArea(child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is MyOrdersLoading) {
            return const Loading();
          }
          if (state is MyOrdersLoaded) {
            return Column(
              children: <Widget>[
                _buildTabs(),
                SizedBox(height: SizeConfig.defaultSize),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: <Widget>[
                      _buildListOrders(state.deliveringOrders),
                      _buildListOrders(state.deliveredOrders),
                    ],
                  ),
                )
              ],
            );
          }
          if (state is MyOrdersLoadFailure) {
            return const Center(child: Text("Load Failure"));
          }
          return const Center(child: Text("Something went wrongs."));
        },
      )),
    );
  }

  _buildTabs() {
    return DefaultTabController(
      length: 2,
      child: TabBar(
        controller: tabController,
        tabs: <Widget>[
          Tab(text: Translate.of(context).translate("be_delivering")),
          Tab(text: Translate.of(context).translate("delivered")),
        ],
        onTap: (index) {},
        labelStyle: FONT_CONST.BOLD_PRIMARY_18,
        labelColor: COLOR_CONST.textColor,
        unselectedLabelColor: COLOR_CONST.textColor,
        unselectedLabelStyle: FONT_CONST.BOLD_DEFAULT,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: COLOR_CONST.primaryColor,
        indicatorWeight: 2,
      ),
    );
  }

  _buildListOrders(List<OrderModel> orders) {
    return orders.isEmpty
        ? Center(
            child: Image.asset(IMAGE_CONST.NO_RECORD),
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return OrderModelCard(order: orders[index]);
            },
          );
  }
}
