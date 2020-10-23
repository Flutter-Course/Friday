import 'package:deliver_manager/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddOrderSheet extends StatefulWidget {
  final List<String> deliveryMen;
  final Function addOrder;
  AddOrderSheet(this.deliveryMen, this.addOrder);
  @override
  _AddOrderSheetState createState() => _AddOrderSheetState();
}

class _AddOrderSheetState extends State<AddOrderSheet> {
  TextEditingController controller;
  String selectedDeliveryMan;
  DateTime selectedDate;
  double price;
  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedDeliveryMan = widget.deliveryMen[0];
    price = 0.0;
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Text(
                  'Let\'s add an order',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Who will deliver?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Card(
                      color: Colors.blue[50],
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            value: selectedDeliveryMan,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            items: widget.deliveryMen.map((deliveryMan) {
                              return DropdownMenuItem(
                                child: Text(deliveryMan),
                                value: deliveryMan,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedDeliveryMan = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'When will be delivered?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      children: [
                        RaisedButton(
                          color: Colors.blue[50],
                          child: Text(
                            DateFormat('EEEE, dd/MM/yyyy').format(
                              selectedDate,
                            ),
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () async {
                            DateTime date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now().subtract(
                                Duration(days: 7),
                              ),
                              lastDate: DateTime.now().add(
                                Duration(days: 90),
                              ),
                            );
                            if (date != null) {
                              setState(() {
                                selectedDate = DateTime(
                                  date.year,
                                  date.month,
                                  date.day,
                                  selectedDate.hour,
                                  selectedDate.minute,
                                );
                              });
                            }
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'at',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RaisedButton(
                          color: Colors.blue[50],
                          child: Text(
                            DateFormat('hh:mm a').format(
                              selectedDate,
                            ),
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(selectedDate),
                            );
                            if (time != null) {
                              setState(() {
                                selectedDate = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  time.hour,
                                  time.minute,
                                );
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'What is the price?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue[50],
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        color: Colors.blue[900],
                        child: Text(
                          'Add Order',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          try {
                            double price = double.parse(controller.text);
                            if (price < 0) {
                              throw 'Negative price';
                            }
                            Order newOrder = Order(
                              deliveryMan: selectedDeliveryMan,
                              price: price,
                              orderDate: selectedDate,
                            );
                            widget.addOrder(newOrder);
                          } catch (error) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Invalid order data'),
                                  content:
                                      Text('You have entered invalid price.'),
                                  actions: [
                                    FlatButton(
                                      child: Text('Ok'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
