import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapify_admin/src/modules/order/logic.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:timelines/timelines.dart';

import '../../../utils/constants/colors.dart';

const kTileHeight = 50.0;

class PackageDeliveryTrackingPage extends StatefulWidget {
  String? indexState;

   PackageDeliveryTrackingPage({super.key, this.indexState});

  @override
  State<PackageDeliveryTrackingPage> createState() => _PackageDeliveryTrackingPageState();
}

class _PackageDeliveryTrackingPageState extends State<PackageDeliveryTrackingPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        final data = _data(index + 1, widget.indexState!);
        return  _DeliveryProcesses(processes: data.deliveryProcesses);
      },
    );
  }
}

class _DeliveryProcesses extends StatelessWidget {
  const _DeliveryProcesses({Key? key, required this.processes})
      : super(key: key);

  final List<_DeliveryProcess> processes;
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: Color(0xff9b9b9b),
        fontSize: 12.5,
      ),
      child: FixedTimeline.tileBuilder(
        theme: TimelineThemeData(
          nodePosition: 0,
          color: Color(0xff989898),
          indicatorTheme: IndicatorThemeData(
            position: 0,
            size: 16.0,
          ),
          connectorTheme: ConnectorThemeData(
            thickness: 2.5,
          ),
        ),
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
          itemCount: processes.length,
          contentsBuilder: (_, index) {

            return Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    processes[index].name,
                    style: context.text.titleMedium?.copyWith(fontSize: 14.sp)
                  ),
                  35.heightBox,
                ],
              ),
            );
          },
          indicatorBuilder: (_, index) {
            if (processes[index].isCompleted) {
              return DotIndicator(
                color: AppColors.customTimeLineColor,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 12.0,
                ),
              );
            } else {
              return OutlinedDotIndicator(
                borderWidth: 2.5,
              );
            }
          },
          connectorBuilder: (_, index, ___) => SolidLineConnector(
            color: processes[index].isCompleted ? AppColors.customTimeLineColor : null,
          ),
        ),
      ),
    );
  }
}

_OrderInfo _data(int id, String index) {
  String? fulfillmentStatus = index;
  return    _OrderInfo(
    id: id,
    date: DateTime.now(),
    driverInfo: _DriverInfo(
      name: 'Philipe',
      thumbnailUrl:
      'https://i.pinimg.com/originals/08/45/81/084581e3155d339376bf1d0e17979dc6.jpg',
    ),
    deliveryProcesses: [
      _DeliveryProcess(
        'Order Placed',
        isCompleted: fulfillmentStatus == 'UNFULFILLED' || fulfillmentStatus == 'FULFILLED',
      ),
      _DeliveryProcess(
        'In Progress',
        isCompleted: fulfillmentStatus == 'UNFULFILLED' || fulfillmentStatus == 'FULFILLED',
      ),
      _DeliveryProcess(
        'Shipped',
        isCompleted: fulfillmentStatus == 'FULFILLED',
      ),
      // _DeliveryProcess.complete(),
    ],
  );
}

class _OrderInfo {
  const _OrderInfo({
    required this.id,
    required this.date,
    required this.driverInfo,
    required this.deliveryProcesses,
  });

  final int id;
  final DateTime date;
  final _DriverInfo driverInfo;
  final List<_DeliveryProcess> deliveryProcesses;
}

class _DriverInfo {
  const _DriverInfo({
    required this.name,
    required this.thumbnailUrl,
  });

  final String name;
  final String thumbnailUrl;
}

class _DeliveryProcess {
  const _DeliveryProcess(
      this.name, {
        this.messages = const [],
        this.isCompleted = false,
      });

  const _DeliveryProcess.complete()
      : this.name = 'Done',
        this.messages = const [],
        this.isCompleted = true;

  final String name;
  final List<_DeliveryMessage> messages;
  final bool isCompleted;

  bool get isDone => name == 'Done';
}

class _DeliveryMessage {
  const _DeliveryMessage(this.createdAt, this.message);

  final String createdAt; // final DateTime createdAt;
  final String message;

  @override
  String toString() {
    return '$createdAt $message';
  }
}