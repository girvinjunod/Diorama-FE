import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'model/event.dart';
class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _startDate = TextEditingController();
  TextEditingController _caption = TextEditingController();
  String _tripName = "Trip: Tes Nama Trip";
  String _dateRange = "(DD-MM-YYYY - DD-MM-YYYY)";
  var _imageFile;
  var _imagePath;
  bool _isNotPicked = true;

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
                      Visibility(
                        child: ElevatedButton(
                          onPressed: () {
                            _getFromGallery();
                            _isNotPicked = false;
                          },
                          child: const Text('+ Add Photo',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: const Color(0xFF189AB4),
                                  fontWeight: FontWeight.w400)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(200),
                            primary: const Color(0xffD4F1F4),
                            padding: EdgeInsets.all(15),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                                side: BorderSide(color: const Color(0xFF189AB4), width: 2)
                            ),
                          ),
                        ),
                        visible: _isNotPicked,
                      ),
                      Visibility(
                        child: _imageFile != null
                        ? (kIsWeb)
                          ? Image.memory(_imageFile)
                          : Image.file(_imageFile)
                        : SizedBox(height: 0),
                        visible: _imageFile != null,
                      ),
                      Visibility(
                        child: SizedBox(height: 40),
                        visible: _isNotPicked==false,
                      ),
                      Visibility(
                        child: ElevatedButton(
                          onPressed: () {
                            _getFromGallery();
                          },
                          child: const Text('Change Photo',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: const Color(0xFF189AB4),
                                  fontWeight: FontWeight.w400)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(40),
                            primary: const Color(0xffD4F1F4),
                            padding: EdgeInsets.all(15),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                                side: BorderSide(color: const Color(0xFF189AB4), width: 2)
                            ),
                          ),
                        ),
                        visible: _isNotPicked==false,
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
                                DateFormat('yyyy-MM-dd').format(pickedDate);
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
                        controller: _caption,
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_isNotPicked)
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please upload an image')),
                              );
                            }
                            else
                            {
                              // Success, send event
                              DateTime now = DateTime.now();
                              String postTime = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
                              addEvent("1", "1", _caption.text, _startDate.text, postTime, _imageFile).then((status){
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

  _getFromGallery() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    _imagePath = pickedFile;
    if (pickedFile != null) {
      if(kIsWeb){
        var f = await pickedFile.readAsBytes();
        setState(() {
          _imageFile = f;
        });
      } else {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    }
  }

}

