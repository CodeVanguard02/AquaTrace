import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SeeReportPage extends StatefulWidget {
  const SeeReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<SeeReportPage> {
  int currentMonth = DateTime.now().month;
  int currentYear = DateTime.now().year;
  DateTime today = DateTime.now();
  final double totalWaterUsageLimit = 14100.0; // 14.1 KL
  final double criticalWaterLevel = 150.0; // 150 L

  void _previousMonth() {
    setState(() {
      if (currentMonth > 1) {
        currentMonth--;
      } else if (currentYear > DateTime.now().year) {
        currentMonth = 12;
        currentYear--;
      }
    });
  }

  void _nextMonth() {
    setState(() {
      if (currentMonth < 12 || (currentMonth == 12 && currentYear < DateTime.now().year)) {
        currentMonth++;
        if (currentMonth > 12) {
          currentMonth = 1;
          currentYear++;
        }
      }
    });
  }

  List<FlSpot> _getMonthData() {
    DateTime firstDayOfMonth = DateTime(currentYear, currentMonth, 1);
    DateTime lastDayOfMonth = DateTime(currentYear, currentMonth + 1, 0);
    List<FlSpot> spots = [];
    bool isCurrentMonth = currentMonth == DateTime.now().month && currentYear == DateTime.now().year;

    for (int i = 0; i < lastDayOfMonth.day; i++) {
      if (isCurrentMonth && i >= today.day) {
        break;
      }
      spots.add(FlSpot(i.toDouble(), (i % 5 + 1).toDouble()));  // Mock data
    }

    return spots;
  }

  String _getMonthName(int month) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June', 'July',
      'August', 'September', 'October', 'November', 'December'
    ];
    return monthNames[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    DateTime firstDayOfMonth = DateTime(currentYear, currentMonth, 1);
    DateTime lastDayOfMonth = DateTime(currentYear, currentMonth + 1, 0);
    bool isCurrentMonth = currentMonth == DateTime.now().month && currentYear == DateTime.now().year;
    double currentWaterUsage = 14000.0; // Example current water usage

    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Usage Report'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
        
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _previousMonth,
                  child: const Text('Previous Month'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.withOpacity(0.7),
                  ),
                ),
                Text(
                  '${_getMonthName(currentMonth)} $currentYear',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: currentMonth == DateTime.now().month && currentYear == DateTime.now().year
                      ? null
                      : _nextMonth,
                  child: const Text('Next Month'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Water Usage',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          CircularProgressIndicator(
                            value: currentWaterUsage / totalWaterUsageLimit,
                            strokeWidth: 10,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              currentWaterUsage >= totalWaterUsageLimit - criticalWaterLevel
                                  ? Colors.red
                                  : Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '${currentWaterUsage.toStringAsFixed(0)}L / 14.1KL',
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.water_drop, color: Colors.blue),
                              SizedBox(width: 5),
                              Text('Flow Rate: 125L/h'),
                            ],
                          ),
                          if (currentWaterUsage >= totalWaterUsageLimit - criticalWaterLevel)
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                'Warning: Water is about to run out!',
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Water Usage History',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: LineChart(
                              LineChartData(
                                gridData: FlGridData(show: true),
                                titlesData: FlTitlesData(
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 1,
                                      getTitlesWidget: (value, meta) {
                                        return Text('${value.toInt()}');
                                      },
                                    ),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 5,
                                      getTitlesWidget: (value, meta) {
                                        DateTime date = DateTime(currentYear, currentMonth, value.toInt() + 1);
                                        if (date.day == today.day && date.month == today.month) {
                                          return Text('Today');
                                        }
                                        return Text('${value.toInt() + 1}');
                                      },
                                    ),
                                  ),
                                ),
                                borderData: FlBorderData(show: true),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: _getMonthData(),
                                    isCurved: true,
                                    color: Colors.blue,
                                    barWidth: 3,
                                    isStrokeCapRound: true,
                                    belowBarData: BarAreaData(
                                      show: true,
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.blue.withOpacity(0.3),
                                          Colors.blue.withOpacity(0.0),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Session',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('Start Date/Time')),
                      DataColumn(label: Text('End Date/Time')),
                      DataColumn(label: Text('Usage Volume (L)')),
                      DataColumn(label: Text('Usage Time (minutes)')),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('01/07/2024 08:00')),
                        DataCell(Text('01/07/2024 10:00')),
                        DataCell(Text('500')),
                        DataCell(Text('120')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('02/07/2024 08:00')),
                        DataCell(Text('02/07/2024 09:30')),
                        DataCell(Text('300')),
                        DataCell(Text('90')),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
