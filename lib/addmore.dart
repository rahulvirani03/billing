import 'package:billing/itemmodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'productist.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddMore extends StatefulWidget {
  List<ItemModel> items;
  String billno, date;
  AddMore(List<ItemModel> items, String billno, String date) {
    this.items = items;
    this.billno = billno;
    this.date = date;
  }
  @override
  _AddMoreState createState() => _AddMoreState();
}

class _AddMoreState extends State<AddMore> {
  @override
  @override
  void initState() {
    super.initState();
  }

  final _prodKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final qtyController = TextEditingController();
  final rateController = TextEditingController();

  String name, qty, rate, price, billno;
  int pr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[600],
      appBar: AppBar(
        title: Text('RF Billing'),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _prodKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Text(
                      'Product Details',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Product Name:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  Card(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                          child: TextFormField(
                            onChanged: (text) {
                              name = text;
                            },
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: 'Enter product name',
                            ),
                            validator: (value) {
                              if (name == null) {
                                return ('Enter a valid product name');
                              }
                            },
                          ),
                        ),
                      ])),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Quantity:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                    child: TextFormField(
                                        keyboardType: TextInputType.phone,
                                        onChanged: (text) {
                                          qty = text;
                                          pr = int.parse(qtyController.text) *
                                              int.parse(rateController.text);
                                          setState(() {
                                            priceController.text =
                                                pr.toString();
                                            print(priceController.text);
                                          });
                                        },
                                        controller: qtyController,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Qunatity',
                                        ),
                                        validator: (value) {
                                          if (qty == null) {
                                            return ('Qty cannot be empty');
                                          }
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Rate:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Card(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                  child: TextFormField(
                                      keyboardType: TextInputType.phone,
                                      onChanged: (text) {
                                        rate = text;
                                        pr = int.parse(qtyController.text) *
                                            int.parse(rateController.text);
                                        setState(() {
                                          priceController.text = pr.toString();
                                          print(priceController.text);
                                        });
                                      },
                                      controller: rateController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Rate',
                                      ),
                                      validator: (value) {
                                        if (rate == null) {
                                          return ('Rate cannot be empty');
                                        }
                                      }),
                                ),
                              ],
                            )),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Price:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Card(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                  child: TextField(
                                    enabled: false,
                                    onChanged: (text) {
                                      price = text;
                                    },
                                    controller: priceController,
                                    decoration: InputDecoration(
                                      hintText: 'Price',
                                    ),
                                  ),
                                ),
                              ],
                            )),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 20.0, 0, 5.0),
                        child: ButtonTheme(
                          minWidth: 160.0,
                          height: 50.0,
                          buttonColor: Colors.green[800],
                          child: RaisedButton(
                            color: Colors.green[800],
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_prodKey.currentState.validate()) {
                                  ItemModel item = new ItemModel(
                                      name.toUpperCase(),
                                      qty.toUpperCase(),
                                      rate.toUpperCase(),
                                      pr.toString().toUpperCase());

                                  widget.items.add(item);
                                  nameController.clear();
                                  qtyController.clear();
                                  rateController.clear();
                                  priceController.clear();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'Something went wrong',
                                      backgroundColor: Colors.blue);
                                }
                              });
                              print(widget.items.map((e) => e.name));
                              print(widget.items.map((e) => e.qty));
                              print(widget.items.map((e) => e.rate));
                              print(widget.items.map((e) => e.price));
                              Fluttertoast.showToast(
                                  msg: 'Item Added Successfully',
                                  backgroundColor: Colors.blue);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 20.0,
                      ),
                      ButtonTheme(
                        minWidth: 120.0,
                        height: 40.0,
                        buttonColor: Colors.green[800],
                        child: RaisedButton(
                          color: Colors.green[800],
                          child: Text(
                            'Show Bill',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductList(
                                        widget.items,
                                        widget.billno,
                                        widget.date)));
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
