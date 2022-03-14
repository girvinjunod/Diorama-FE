import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _startDate = TextEditingController();
  TextEditingController _endDate = TextEditingController();
  String _tripName = "Trip: Tes Nama Trip";
  String _dateRange = "(DD-MM-YYYY - DD-MM-YYYY)";

  @override
  void initState() {
    _startDate.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Align(
          alignment: Alignment.topCenter,
          child: ListView(shrinkWrap: true, children: <Widget>[
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Add New Event',
                        style: TextStyle(
                            fontSize: 26, color: const Color(0xFF05445E)),
                      ),
                      SizedBox(height: 20),
                      Text(
                        _tripName,
                        style: TextStyle(
                            fontSize: 16, color: const Color(0xFF000000)),
                      ),
                      Text(
                        _dateRange,
                        style: TextStyle(
                            fontSize: 14, color: const Color(0xFF189AB4)),
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          // Buka file manager
                        },
                        child: const Text('+ Add Photo',
                            style: TextStyle(
                                fontSize: 16,
                                color: const Color(0xFF189AB4),
                                fontWeight: FontWeight.w400)),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(40),
                          primary: const Color(0xffffffff),
                          padding: EdgeInsets.all(15),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                              side: BorderSide(color: const Color(0xFF189AB4), width: 2)
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      TextFormField(
                        decoration: InputDecoration(
                          errorMaxLines: 3,
                          labelText: 'Event Date',
                          icon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        controller: _startDate,
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1800),
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                            setState(() {
                              _startDate.text = formattedDate;
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a date';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        maxLength: 1000,
                        minLines: 3,
                        maxLines: 5,
                        decoration: InputDecoration(
                          errorMaxLines: 3,
                          labelText: 'Caption',
                          icon: Icon(Icons.book),
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Success')),
                            );
                          }
                        },
                        child: const Text('Create Event',
                            style: TextStyle(
                                fontSize: 22,
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w400)),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(40),
                          primary: const Color(0xFF189AB4),
                          padding: EdgeInsets.all(15),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ]),
              ),
            ),
          ]),
        ));
  }
}
