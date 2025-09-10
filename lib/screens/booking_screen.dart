class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  List<int> yearList = [2025, 2026];
  int selectedYear = 2025;
  int selectedIndex = 1;
  int selectedShift = 0;

  final List<String> days = ['Wed', 'Thu', 'Fri', 'Sat', 'Sun', 'Mon', 'Tue'];
  final List<int> dates = [10, 11, 12, 13, 14, 15, 16];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            constraints: BoxConstraints(maxWidth: 800),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 8,
                        ),
                      ),
                      onPressed: () {},
                      child: Text("New", style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 8,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Follow Up",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<int>(
                      value: selectedYear,
                      items: yearList
                          .map(
                            (year) => DropdownMenuItem(
                              child: Text(year.toString()),
                              value: year,
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedYear = val!;
                        });
                      },
                    ),
                    Spacer(),
                    IconButton(icon: Icon(Icons.arrow_left), onPressed: () {}),
                    Text(
                      "September",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(icon: Icon(Icons.arrow_right), onPressed: () {}),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(days.length, (i) {
                    bool selected = i == selectedIndex;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () => setState(() => selectedIndex = i),
                        child: Container(
                          width: 50,
                          decoration: BoxDecoration(
                            color:
                                selected ? Colors.green[100] : Colors.blue[50],
                            border: Border.all(
                              width: 2,
                              color: selected ? Colors.green : Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Column(
                            children: [
                              Text(
                                days[i],
                                style: TextStyle(
                                  color: selected ? Colors.green : Colors.blue,
                                  fontWeight: selected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                dates[i].toString(),
                                style: TextStyle(
                                  color: selected ? Colors.green : Colors.blue,
                                  fontWeight: selected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${dates[selectedIndex]}th September, $selectedYear',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 4),
                    child: Text(
                      "Please Select a Shift",
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.wb_sunny_outlined, color: Colors.blue),
                        label: Text(
                          'Morning Shift',
                          style: TextStyle(color: Colors.blue),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedShift == 0
                              ? Colors.blue[100]
                              : Colors.blue[50],
                          padding: EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(
                            color: selectedShift == 0
                                ? Colors.blue
                                : Colors.transparent,
                          ),
                        ),
                        onPressed: () => setState(() => selectedShift = 0),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.nights_stay_outlined,
                          color: Colors.blue,
                        ),
                        label: Text(
                          'Day Shift',
                          style: TextStyle(color: Colors.blue),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedShift == 1
                              ? Colors.blue[100]
                              : Colors.blue[50],
                          padding: EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(
                            color: selectedShift == 1
                                ? Colors.blue
                                : Colors.transparent,
                          ),
                        ),
                        onPressed: () => setState(() => selectedShift = 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[50],
                      padding: EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: BorderSide(color: Colors.green),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Proceed To Book',
                          style: TextStyle(color: Colors.green[700]),
                        ),
                        Text(
                          'NRs. 100',
                          style: TextStyle(color: Colors.green[700]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
