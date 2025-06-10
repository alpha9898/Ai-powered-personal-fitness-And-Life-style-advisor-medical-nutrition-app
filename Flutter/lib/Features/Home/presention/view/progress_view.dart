import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
// import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProgressView extends StatefulWidget {
  const ProgressView({super.key});

  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Body Stats', 'Activity', 'Workouts'];

  // Body measurements
  double _weight = 0.0;
  double _height = 0.0;
  double _bodyFat = 0.0;
  double _musclePercentage = 0.0;
  double _bmi = 0.0;
  double _waistCircumference = 0.0;
  double _chestCircumference = 0.0;
  double _armCircumference = 0.0;

  // Activity tracking
  int _steps = 0;
  int _dailyStepGoal = 10000; // Default daily step goal
  DateTime? _lastStepResetDate;
  Map<String, int> _dailySteps = {};
  double _sleepHours = 0.0;
  int _waterCups = 0; // Changed to int for cup counting
  final int _dailyWaterGoal = 8; // Recommended 8 cups per day

  // Workout progress
  List<WorkoutRecord> _workoutRecords = [];

  // Charts data
  List<FlSpot> _weightData = [];
  List<FlSpot> _bodyFatData = [];
  List<FlSpot> _muscleData = [];
  List<FlSpot> _bmiData = [];
  List<FlSpot> _waistData = [];
  List<FlSpot> _chestData = [];
  List<FlSpot> _armData = [];
  List<FlSpot> _stepsData = [];
  List<FlSpot> _sleepData = [];
  List<FlSpot> _waterData = []; // Added water tracking data

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _loadSavedData();
    // _initPedometer();
    _checkDayChange();
  }

  void _checkDayChange() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (_lastStepResetDate == null ||
        _lastStepResetDate!.day != today.day ||
        _lastStepResetDate!.month != today.month ||
        _lastStepResetDate!.year != today.year) {
      _resetDailySteps();
    }
  }

  void _resetDailySteps() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    _lastStepResetDate = today;
    _steps = 0;
    _saveDailySteps();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();

    // Load last reset date
    final lastResetStr = prefs.getString('lastStepResetDate');
    if (lastResetStr != null) {
      _lastStepResetDate = DateTime.parse(lastResetStr);
    }

    // Load daily steps history
    final stepsHistoryStr = prefs.getString('dailySteps');
    if (stepsHistoryStr != null) {
      final Map<String, dynamic> decoded = Map<String, dynamic>.from(
        json.decode(stepsHistoryStr),
      );
      _dailySteps = decoded.map((key, value) => MapEntry(key, value as int));
    }

    setState(() {
      _steps = prefs.getInt('steps') ?? 0;
      _dailyStepGoal = prefs.getInt('dailyStepGoal') ?? 10000;

      // Convert daily steps to chart data
      _stepsData = _dailySteps.entries.map((entry) {
        final date = DateTime.parse(entry.key);
        final daysAgo = DateTime.now().difference(date).inDays;
        return FlSpot(daysAgo.toDouble(), entry.value.toDouble());
      }).toList();

      // Sort by date (x-axis)
      _stepsData.sort((a, b) => a.x.compareTo(b.x));

      // Keep only last 7 days
      if (_stepsData.length > 7) {
        _stepsData = _stepsData.sublist(_stepsData.length - 7);
      }

      // Normalize x-axis to 0-6
      final xOffset = _stepsData.isEmpty ? 0 : _stepsData.first.x;
      _stepsData = _stepsData.map((spot) {
        return FlSpot(spot.x - xOffset, spot.y);
      }).toList();

      _weight = prefs.getDouble('weight') ?? 0.0;
      _height = prefs.getDouble('height') ?? 0.0;
      _bodyFat = prefs.getDouble('bodyFat') ?? 0.0;
      _musclePercentage = prefs.getDouble('musclePercentage') ?? 0.0;
      _bmi = prefs.getDouble('bmi') ?? 0.0;
      _waistCircumference = prefs.getDouble('waist') ?? 0.0;
      _chestCircumference = prefs.getDouble('chest') ?? 0.0;
      _armCircumference = prefs.getDouble('arm') ?? 0.0;
      _sleepHours = prefs.getDouble('sleepHours') ?? 0.0;
      _waterCups = prefs.getInt('waterCups') ?? 0;

      // Load history data for all metrics
      _loadMetricHistory('bodyFat', _bodyFatData);
      _loadMetricHistory('muscle', _muscleData);
      _loadMetricHistory('bmi', _bmiData);
      _loadMetricHistory('waist', _waistData);
      _loadMetricHistory('chest', _chestData);
      _loadMetricHistory('arm', _armData);

      // Keep existing water history loading
      final waterHistory = prefs.getStringList('waterHistory') ?? [];
      _waterData = waterHistory.asMap().entries.map((entry) {
        return FlSpot(entry.key.toDouble(), double.parse(entry.value));
      }).toList();
    });
  }

  void _loadMetricHistory(String metric, List<FlSpot> dataList) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('${metric}History') ?? [];
    dataList.clear();
    dataList.addAll(
      history.asMap().entries.map((entry) {
        return FlSpot(entry.key.toDouble(), double.parse(entry.value));
      }),
    );
  }

  void _saveMetricHistory(String metric, List<FlSpot> dataList) async {
    final prefs = await SharedPreferences.getInstance();
    final history = dataList.map((spot) => spot.y.toString()).toList();
    await prefs.setStringList('${metric}History', history);
  }

  double _calculateBMI() {
    if (_height <= 0) return 0;
    return _weight / ((_height / 100) * (_height / 100));
  }

  // void _initPedometer() {
  //   Pedometer.stepCountStream.listen(
  //     (StepCount event) {
  //       setState(() {
  //         _steps = event.steps;
  //         _saveDailySteps();
  //       });
  //     },
  //     onError: (error) {
  //       print("Pedometer error: $error");
  //       setState(() {
  //         _steps = 0;
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Pedometer error: $error')),
  //       );
  //     },
  //   );
  // }

  Future<void> _saveDailySteps() async {
    final prefs = await SharedPreferences.getInstance();

    // Save current steps
    await prefs.setInt('steps', _steps);

    // Save last reset date
    if (_lastStepResetDate != null) {
      await prefs.setString(
          'lastStepResetDate', _lastStepResetDate!.toIso8601String());
    }

    // Update daily steps map
    final today = DateTime.now();
    final dateKey =
        DateTime(today.year, today.month, today.day).toIso8601String();
    _dailySteps[dateKey] = _steps;

    // Save daily steps history
    await prefs.setString('dailySteps', json.encode(_dailySteps));

    // Update chart data
    setState(() {
      _stepsData = _dailySteps.entries.map((entry) {
        final date = DateTime.parse(entry.key);
        final daysAgo = DateTime.now().difference(date).inDays;
        return FlSpot(daysAgo.toDouble(), entry.value.toDouble());
      }).toList();

      // Sort by date (x-axis)
      _stepsData.sort((a, b) => a.x.compareTo(b.x));

      // Keep only last 7 days
      if (_stepsData.length > 7) {
        _stepsData = _stepsData.sublist(_stepsData.length - 7);
      }

      // Normalize x-axis to 0-6
      final xOffset = _stepsData.isEmpty ? 0 : _stepsData.first.x;
      _stepsData = _stepsData.map((spot) {
        return FlSpot(spot.x - xOffset, spot.y);
      }).toList();
    });
  }

  void _addWaterCup() async {
    setState(() {
      _waterCups++;
      _waterData
          .add(FlSpot(_waterData.length.toDouble(), _waterCups.toDouble()));
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('waterCups', _waterCups);

    // Save water history
    final waterHistory = _waterData.map((spot) => spot.y.toString()).toList();
    await prefs.setStringList('waterHistory', waterHistory);
  }

  void _resetWaterCups() async {
    setState(() {
      _waterCups = 0;
      // Keep the history but add new point with 0 cups
      _waterData.add(FlSpot(_waterData.length.toDouble(), 0));
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('waterCups', _waterCups);

    // Save water history
    final waterHistory = _waterData.map((spot) => spot.y.toString()).toList();
    await prefs.setStringList('waterHistory', waterHistory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Tracking',
            style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => _showResetConfirmationDialog(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBodyStatsTab(),
          _buildActivityTab(),
          _buildWorkoutsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDataDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBodyStatsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBasicMeasurementsSection(),
          const SizedBox(height: 24),
          _buildCircumferenceSection(),
          const SizedBox(height: 24),
          _buildCompositionSection(),
        ],
      ),
    );
  }

  Widget _buildBasicMeasurementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Basic Measurements',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        _buildMetricCard(
          'Weight',
          '$_weight kg',
          Icons.monitor_weight,
          _weightData,
          Colors.blue,
        ),
        const SizedBox(height: 16),
        _buildMetricCard(
          'BMI',
          _bmi.toStringAsFixed(1),
          Icons.health_and_safety,
          _bmiData,
          Colors.green,
        ),
      ],
    );
  }

  Widget _buildCircumferenceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Body Measurements',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        _buildMetricCard(
          'Waist',
          '$_waistCircumference cm',
          Icons.straighten,
          _waistData,
          Colors.orange,
        ),
        const SizedBox(height: 16),
        _buildMetricCard(
          'Chest',
          '$_chestCircumference cm',
          Icons.straighten,
          _chestData,
          Colors.purple,
        ),
        const SizedBox(height: 16),
        _buildMetricCard(
          'Arms',
          '$_armCircumference cm',
          Icons.straighten,
          _armData,
          Colors.teal,
        ),
      ],
    );
  }

  Widget _buildCompositionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Body Composition',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        _buildMetricCard(
          'Body Fat',
          '$_bodyFat%',
          Icons.percent,
          _bodyFatData,
          Colors.red,
        ),
        const SizedBox(height: 16),
        _buildMetricCard(
          'Muscle Mass',
          '$_musclePercentage%',
          Icons.fitness_center,
          _muscleData,
          Colors.amber,
        ),
      ],
    );
  }

  Widget _buildActivityTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepsCard(),
          const SizedBox(height: 16),
          _buildMetricCard(
            'Sleep',
            '$_sleepHours hours',
            Icons.bedtime,
            _sleepData,
            Colors.green,
          ),
          const SizedBox(height: 16),
          _buildWaterIntakeCard(),
        ],
      ),
    );
  }

  Widget _buildWorkoutsTab() {
    return ListView.builder(
      itemCount: _workoutRecords.length,
      itemBuilder: (context, index) {
        final workout = _workoutRecords[index];
        return ListTile(
          title: Text(workout.name),
          subtitle: Text('Weight: ${workout.weight}kg x ${workout.reps} reps'),
          trailing: Text(workout.date.toString().split(' ')[0]),
        );
      },
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon,
      List<FlSpot> chartData, Color color) {
    // Calculate min and max for Y axis
    double minY = _calculateMinY(chartData);
    double maxY = _calculateMaxY(chartData);
    double interval = _calculateInterval(chartData);

    return Card(
      color: const Color(0xFF1D1D1D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(title, style: TextStyle(fontSize: 16, color: color)),
                const Spacer(),
                Text(value,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color)),
              ],
            ),
            if (chartData.isNotEmpty) ...[
              const SizedBox(height: 16),
              SizedBox(
                height: 150,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      horizontalInterval: interval,
                      verticalInterval: 1,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey[800]!,
                          strokeWidth: 0.5,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: Colors.grey[800]!,
                          strokeWidth: 0.5,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 35,
                          interval: interval,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toStringAsFixed(1),
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 10,
                              ),
                            );
                          },
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.grey[800]!, width: 0.5),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: chartData,
                        isCurved: true,
                        color: color,
                        barWidth: 2,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) {
                            return FlDotCirclePainter(
                              radius: 3,
                              color: color,
                              strokeWidth: 1,
                              strokeColor: Colors.white,
                            );
                          },
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          color: color.withOpacity(0.15),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              color.withOpacity(0.15),
                              color.withOpacity(0.05),
                            ],
                          ),
                        ),
                      ),
                    ],
                    minY: minY,
                    maxY: maxY,
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        tooltipBgColor: Colors.grey[800]!,
                        getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                          return touchedBarSpots.map((barSpot) {
                            return LineTooltipItem(
                              '${barSpot.y.toStringAsFixed(1)}',
                              TextStyle(color: color),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  double _calculateInterval(List<FlSpot> data) {
    if (data.isEmpty) return 1;
    double minValue = data.first.y;
    double maxValue = data.first.y;

    for (var spot in data) {
      if (spot.y < minValue) minValue = spot.y;
      if (spot.y > maxValue) maxValue = spot.y;
    }

    double range = maxValue - minValue;
    // Ensure interval is never zero
    if (range == 0) {
      // If all values are the same, create a reasonable interval
      return maxValue == 0 ? 1 : maxValue / 5;
    }
    double interval = range / 5; // Show roughly 5 intervals
    return interval < 0.1 ? 0.1 : interval; // Ensure minimum interval of 0.1
  }

  double _calculateMinY(List<FlSpot> data) {
    if (data.isEmpty) return 0;
    double minValue = data.first.y;

    for (var spot in data) {
      if (spot.y < minValue) minValue = spot.y;
    }

    double maxValue = _findMaxValue(data);
    double padding = (maxValue - minValue) * 0.1;
    return minValue - padding;
  }

  double _calculateMaxY(List<FlSpot> data) {
    if (data.isEmpty) return 10;
    double maxValue = data.first.y;

    for (var spot in data) {
      if (spot.y > maxValue) maxValue = spot.y;
    }

    double minValue = _findMinValue(data);
    double padding = (maxValue - minValue) * 0.1;
    return maxValue + padding;
  }

  double _findMinValue(List<FlSpot> data) {
    if (data.isEmpty) return 0;
    double minValue = data.first.y;
    for (var spot in data) {
      if (spot.y < minValue) minValue = spot.y;
    }
    return minValue;
  }

  double _findMaxValue(List<FlSpot> data) {
    if (data.isEmpty) return 0;
    double maxValue = data.first.y;
    for (var spot in data) {
      if (spot.y > maxValue) maxValue = spot.y;
    }
    return maxValue;
  }

  Widget _buildWaterIntakeCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.water_drop),
                const SizedBox(width: 8),
                const Text('Water Intake', style: TextStyle(fontSize: 18)),
                const Spacer(),
                Text('$_waterCups / $_dailyWaterGoal cups',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: _waterCups / _dailyWaterGoal,
              backgroundColor: Colors.blue.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _addWaterCup,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Cup'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _resetWaterCups,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            if (_waterData.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text('Water Intake History',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          interval: 2,
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: _waterData,
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 3,
                        dotData: FlDotData(show: true),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.blue.withOpacity(0.2),
                        ),
                      ),
                    ],
                    minY: 0,
                    maxY: _dailyWaterGoal.toDouble(),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStepsCard() {
    final progress = _steps / _dailyStepGoal;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.directions_walk, color: Colors.blue),
                const SizedBox(width: 8),
                const Text('Steps',
                    style: TextStyle(fontSize: 16, color: Colors.blue)),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _steps.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      'Goal: $_dailyStepGoal',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: Colors.blue.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            if (_stepsData.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'Last 7 Days',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 150,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      horizontalInterval: _calculateInterval(_stepsData),
                      verticalInterval: 1,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey[800]!,
                          strokeWidth: 0.5,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: Colors.grey[800]!,
                          strokeWidth: 0.5,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            final daysAgo = value.toInt();
                            if (daysAgo == 0)
                              return const Text('Today',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10));
                            if (daysAgo == 1)
                              return const Text('Yesterday',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10));
                            final date = DateTime.now()
                                .subtract(Duration(days: daysAgo));
                            return Text(
                              '${date.day}/${date.month}',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 10),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 45,
                          interval: _calculateInterval(_stepsData),
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value >= 1000
                                  ? '${(value / 1000).toStringAsFixed(1)}k'
                                  : value.toStringAsFixed(0),
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 10),
                            );
                          },
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.grey[800]!, width: 0.5),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: _stepsData,
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 2,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) {
                            return FlDotCirclePainter(
                              radius: 3,
                              color: Colors.blue,
                              strokeWidth: 1,
                              strokeColor: Colors.white,
                            );
                          },
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.blue.withOpacity(0.15),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.blue.withOpacity(0.15),
                              Colors.blue.withOpacity(0.05),
                            ],
                          ),
                        ),
                      ),
                    ],
                    minY: 0,
                    maxY: _calculateMaxY(_stepsData),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showAddDataDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Update Measurements',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(labelText: 'Weight (kg)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _weight = double.tryParse(value) ?? _weight;
                    setState(() {
                      _bmi = _calculateBMI();
                    });
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Height (cm)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _height = double.tryParse(value) ?? _height;
                    setState(() {
                      _bmi = _calculateBMI();
                    });
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Body Fat (%)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _bodyFat = double.tryParse(value) ?? _bodyFat;
                  },
                ),
                TextField(
                  decoration:
                      const InputDecoration(labelText: 'Muscle Mass (%)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _musclePercentage =
                        double.tryParse(value) ?? _musclePercentage;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Waist (cm)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _waistCircumference =
                        double.tryParse(value) ?? _waistCircumference;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Chest (cm)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _chestCircumference =
                        double.tryParse(value) ?? _chestCircumference;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Arms (cm)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _armCircumference =
                        double.tryParse(value) ?? _armCircumference;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    // Save all measurements
                    await prefs.setDouble('weight', _weight);
                    await prefs.setDouble('height', _height);
                    await prefs.setDouble('bodyFat', _bodyFat);
                    await prefs.setDouble(
                        'musclePercentage', _musclePercentage);
                    await prefs.setDouble('bmi', _bmi);
                    await prefs.setDouble('waist', _waistCircumference);
                    await prefs.setDouble('chest', _chestCircumference);
                    await prefs.setDouble('arm', _armCircumference);

                    // Update charts data
                    setState(() {
                      _weightData
                          .add(FlSpot(_weightData.length.toDouble(), _weight));
                      _bodyFatData.add(
                          FlSpot(_bodyFatData.length.toDouble(), _bodyFat));
                      _muscleData.add(FlSpot(
                          _muscleData.length.toDouble(), _musclePercentage));
                      _bmiData.add(FlSpot(_bmiData.length.toDouble(), _bmi));
                      _waistData.add(FlSpot(
                          _waistData.length.toDouble(), _waistCircumference));
                      _chestData.add(FlSpot(
                          _chestData.length.toDouble(), _chestCircumference));
                      _armData.add(FlSpot(
                          _armData.length.toDouble(), _armCircumference));
                    });

                    // Save history for all metrics
                    _saveMetricHistory('bodyFat', _bodyFatData);
                    _saveMetricHistory('muscle', _muscleData);
                    _saveMetricHistory('bmi', _bmiData);
                    _saveMetricHistory('waist', _waistData);
                    _saveMetricHistory('chest', _chestData);
                    _saveMetricHistory('arm', _armData);

                    if (mounted) Navigator.pop(context);
                  },
                  child: const Text('Save All Measurements'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showResetConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1D1D1D),
          title: const Text(
            'Reset All Data',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'This will permanently delete all your progress data. This action cannot be undone.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _resetAllData();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Reset',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _resetAllData() async {
    final prefs = await SharedPreferences.getInstance();

    // Clear all stored data
    await prefs.remove('steps');
    await prefs.remove('lastStepResetDate');
    await prefs.remove('dailySteps');
    await prefs.remove('dailyStepGoal');
    await prefs.remove('weight');
    await prefs.remove('height');
    await prefs.remove('bodyFat');
    await prefs.remove('musclePercentage');
    await prefs.remove('bmi');
    await prefs.remove('waist');
    await prefs.remove('chest');
    await prefs.remove('arm');
    await prefs.remove('sleepHours');
    await prefs.remove('waterCups');
    await prefs.remove('waterHistory');

    // Clear metric histories
    await prefs.remove('bodyFatHistory');
    await prefs.remove('muscleHistory');
    await prefs.remove('bmiHistory');
    await prefs.remove('waistHistory');
    await prefs.remove('chestHistory');
    await prefs.remove('armHistory');

    // Reset all state variables
    setState(() {
      _steps = 0;
      _dailyStepGoal = 10000;
      _lastStepResetDate = null;
      _dailySteps = {};
      _weight = 0.0;
      _height = 0.0;
      _bodyFat = 0.0;
      _musclePercentage = 0.0;
      _bmi = 0.0;
      _waistCircumference = 0.0;
      _chestCircumference = 0.0;
      _armCircumference = 0.0;
      _sleepHours = 0.0;
      _waterCups = 0;

      // Clear all chart data
      _weightData.clear();
      _bodyFatData.clear();
      _muscleData.clear();
      _bmiData.clear();
      _waistData.clear();
      _chestData.clear();
      _armData.clear();
      _stepsData.clear();
      _sleepData.clear();
      _waterData.clear();
      _workoutRecords.clear();
    });

    // Show confirmation
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All data has been reset'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class WorkoutRecord {
  final String name;
  final double weight;
  final int reps;
  final DateTime date;

  WorkoutRecord({
    required this.name,
    required this.weight,
    required this.reps,
    required this.date,
  });
}
