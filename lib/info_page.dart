import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Get device info")),
      body: const InfoPageBody(),
    );
  }
}

class InfoPageBody extends StatefulWidget {
  const InfoPageBody({Key? key}) : super(key: key);

  @override
  _InfoPageBodyState createState() => _InfoPageBodyState();
}

class _InfoPageBodyState extends State<InfoPageBody> {
  static const _platform = MethodChannel("pltfrm_chnl_demo/info");
  int _batteryLevel = -1;
  int _batteryStatus = -1;

  void _getBatteryLevel() async {
    int batteryLvl;
    try {
      final result = await _platform.invokeMethod("getBatteryLevel");
      batteryLvl = result;
    } on PlatformException catch (e) {
      batteryLvl = -1;
    }

    setState(() {
      _batteryLevel = batteryLvl;
    });
  }

  void _getBatteryStatus() async {
    int batteryStatus;
    try {
      final result = await _platform.invokeMethod("getBatteryStatus");
      batteryStatus = result;
    } on PlatformException catch (e) {
      batteryStatus = -1;
    }

    setState(() {
      _batteryStatus = batteryStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomButton(text: "Get Battery Level", onPressed: () => _getBatteryLevel()),
          CustomButton(text: "Get Battery Status", onPressed: () => _getBatteryStatus()),
          Text('Battery Level: ' + _batteryLevel.toString() + '%'),
          const SizedBox(height: 10.0),
          Text('Battery Status: ' + _batteryStatus.toString()),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, this.onPressed, required this.text}) : super(key: key);

  final Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
