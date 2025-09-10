class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int selectedYear = DateTime.now().year;
  DateTime _focusedDate = DateTime.now();
  DateTime? _selectedDate;
  int selectedShift = 0;

  List<int> get yearList {
    final now = DateTime.now();
    return List.generate(2, (i) => now.year + i);
  }

  void _prevMonth() {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month + 1, 1);
    });
  }

  void _pickYear(int year) {
    setState(() {
      _focusedDate = DateTime(year, _focusedDate.month, 1);
      selectedYear = year;
    });
  }

  @override
  Widget build(BuildContext context) {
    final year = _focusedDate.year;
    final month = _focusedDate.month;
    final daysInMonth = DateUtils.getDaysInMonth(year, month);

    final days = List.generate(
      daysInMonth,
      (i) => DateTime(year, month, i + 1),
    );

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
                      onChanged: (val) => _pickYear(val!),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.arrow_left),
                      onPressed: _prevMonth,
                    ),
                    Text(
                      DateFormat.MMMM().format(_focusedDate),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_right),
                      onPressed: _nextMonth,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: days.length,
                    itemBuilder: (context, i) {
                      final date = days[i];
                      final selected = _selectedDate != null &&
                          DateUtils.isSameDay(_selectedDate, date);

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedDate = date),
                          child: Container(
                            width: 60,
                            decoration: BoxDecoration(
                              color: selected
                                  ? Colors.green[100]
                                  : Colors.blue[50],
                              border: Border.all(
                                width: 2,
                                color: selected ? Colors.green : Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat.E().format(date),
                                  style: TextStyle(
                                    color:
                                        selected ? Colors.green : Colors.blue,
                                    fontWeight: selected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "${date.day}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        selected ? Colors.green : Colors.blue,
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
                    },
                  ),
                ),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    _selectedDate == null
                        ? 'Please select a date'
                        : '${DateFormat.d().format(_selectedDate!)} '
                            '${DateFormat.MMMM().format(_selectedDate!)}, $selectedYear',
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
