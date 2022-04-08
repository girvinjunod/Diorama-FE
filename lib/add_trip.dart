import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model/trip.dart';

class AddTripPage extends StatefulWidget {
  const AddTripPage({Key? key}) : super(key: key);

  @override
  _AddTripPageState createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _tripName = TextEditingController();
  TextEditingController _startDate = TextEditingController();
  TextEditingController _endDate = TextEditingController();
  TextEditingController _locationName = TextEditingController();

  @override
  void initState() {
    _startDate.text = "";
    _endDate.text = "";
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
                        'Add New Trip',
                        style: TextStyle(
                            fontSize: 26, color: const Color(0xFF05445E)),
                      ),
                      SizedBox(height: 40),
                      TextFormField(
                        maxLength: 50,
                        decoration: InputDecoration(
                          errorMaxLines: 3,
                          labelText: 'Trip Name',
                          icon: Icon(Icons.airplane_ticket_rounded),
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        controller: _tripName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a trip name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          errorMaxLines: 3,
                          labelText: 'Start Date',
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
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              _startDate.text = formattedDate;
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a start date';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          errorMaxLines: 3,
                          labelText: 'End Date',
                          icon: Icon(Icons.calendar_today_outlined),
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        controller: _endDate,
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1800),
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              _endDate.text = formattedDate;
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an end date';
                          }
                          DateTime sd = new DateFormat("yyyy-MM-dd").parse(_startDate.text);
                          DateTime ed = new DateFormat("yyyy-MM-dd").parse(value);
                          if (ed.isBefore(sd)) {
                            return "End date earlier than start date";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        maxLength: 50,
                        decoration: InputDecoration(
                          errorMaxLines: 3,
                          labelText: 'Location',
                          icon: Icon(Icons.edit_location),
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        controller: _locationName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a location';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // User id temporarily hardcoded as 1
                            addTrip(1, _startDate.text, _endDate.text, _tripName.text, _locationName.text).then((status){
                              if(status == "SUCCESS"){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Trip successfully added')),
                                );
                              }
                              else
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Error adding trip')),
                                );
                              }
                            });
                            
                          }
                        },
                        child: const Text('Create Trip',
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
