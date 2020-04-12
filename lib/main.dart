import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Timer",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  TabController tb;
  int initialvalue = 0;
  int mint = 0;
  int sec = 0;
  bool started = true;
  bool stopped = true;
  String timetoShow = "";
  bool cancletimer = false;

  final dur = const Duration(seconds: 1);

  int timefortimer;
  @override
  void initState() {
    tb = new TabController(length: 2, vsync: this);
    super.initState();
  }

  void start() {
    setState(() {
      started = false;
      stopped = false;
    });
    timefortimer = ((initialvalue * 3600) + mint * 60 + sec);
    Timer.periodic(dur, (Timer t) {
      setState(() {
        if (timefortimer < 1 || cancletimer == true) {
          t.cancel();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHome()));
        } else if (timefortimer < 60) {
          timetoShow = timefortimer.toString();
          timefortimer = timefortimer - 1;
        } else if (timefortimer < 3600) {
          int m = timefortimer ~/ 60;
          int s = timefortimer - (60 * m);
          timetoShow = m.toString() + ":" + s.toString();
          timefortimer = timefortimer - 1;
        } else {
          int h = timefortimer ~/ 3600;
          int t = timefortimer - (3600 * h);
          int m = t ~/ 60;
          int s = (60 * m);
          timetoShow = h.toString() + ":" + m.toString() + ":" + s.toString();
          timefortimer = timefortimer - 1;
        }
      });
    });
  }

  void stop() {
    setState(() {
      started = true;
      stopped = true;
      cancletimer = true;
      timetoShow = "";
    });
  }

  Widget timer() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: (Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "HH",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      listViewWidth: 50.0,
                      initialValue: initialvalue,
                      minValue: 0,
                      maxValue: 23,
                      onChanged: (val) {
                        setState(() {
                          initialvalue = val;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "MM",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      listViewWidth: 50,
                      initialValue: mint,
                      minValue: 0,
                      maxValue: 23,
                      onChanged: (val) {
                        setState(() {
                          mint = val;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "SS",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      listViewWidth: 50.0,
                      initialValue: sec,
                      minValue: 0,
                      maxValue: 23,
                      onChanged: (val) {
                        setState(() {
                          sec = val;
                        });
                      },
                    ),
                  ],
                ),
              ],
            )),
          ),
          Expanded(
            flex: 1,
            child: Text(
              timetoShow,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 35.0, vertical: 15),
                    onPressed: started ? start : null,
                    child: Text(
                      "Start",
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    color: Colors.green,
                  ),
                  RaisedButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 35.0, vertical: 15),
                    onPressed: stopped ? null : stop,
                    child: Text(
                      "Stop",
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    color: Colors.red,
                  ),
                ],
              )),
        ],
      ),
    );
  }

/* 
The below code is for Stop Watch....
*/

  bool stopisPressed = true;
  bool resetisPressed = true;
  bool startisPressed = true;
  String timetoDisplay = "00:00:00";
  var sWatch= Stopwatch();
  final durr=  const Duration(seconds: 1);

void startTimer()
{
  Timer(durr, keepRunning);
}

void keepRunning()
{
  if(sWatch.isRunning)
  {
    startTimer();
  }
  setState(() {
    timetoDisplay= sWatch.elapsed.inHours.toString().padLeft(2, "0")+
    ":"+ (sWatch.elapsed.inMinutes % 60).toString().padLeft(2,"0")+":"+
    (sWatch.elapsed.inSeconds % 60).toString().padLeft(2,"0");

  });

}

  void stop_Watch() {
    setState(() {
      stopisPressed= true;
      resetisPressed= false;
    });
    sWatch.stop();
  }

  void resetStopwatch() {
    setState(() {
      startisPressed= true;
      resetisPressed= true;
    });
    sWatch.reset();
    timetoDisplay = "00:00:00";
  }

  void startStopwatch() {
    setState(() {
      stopisPressed= false;
      startisPressed= false;
    });
    sWatch.start();
    startTimer();
  }


  Widget stopWatch() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                timetoDisplay,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: stopisPressed ? null : stop_Watch,
                        color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Text(
                            "Stop",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: resetisPressed ? null : resetStopwatch,
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Text(
                            "Reset",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                    onPressed: startisPressed ? startStopwatch : null,
                    color: Colors.orange,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Text(
                        "Start",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Timer",
        ),
        bottom: TabBar(
          labelStyle: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          labelPadding: EdgeInsets.only(bottom: 3.0),
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: Colors.white54,
          tabs: [
            Text("Timer"),
            Text("Stop Watch"),
          ],
          controller: tb,
        ),
      ),
      body: TabBarView(
        children: [
          timer(),
          stopWatch(),
        ],
        controller: tb,
      ),
    );
  }
}
