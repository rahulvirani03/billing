import 'package:billing/itemmodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'productist.dart';

class UpdateProd extends StatefulWidget {
  String name, qty, rate, price, billno, date;
  List<ItemModel> items;
  UpdateProd(String name, String qty, String rate, String price,
      List<ItemModel> items, String billno, String date) {
    this.name = name;
    this.qty = qty;
    this.rate = rate;
    this.price = price;
    this.items = items;
    this.billno = billno;
    this.date = date;
  }
  @override
  _UpdateProdState createState() => _UpdateProdState();
}

class _UpdateProdState extends State<UpdateProd> {
  @override
  String _date = "Not set";
  @override
  void initState() {
    updatenamecontroller.text = widget.name;
    updatepricecontroller.text = widget.price;
    updateqtycontroller.text = widget.qty;
    updateratecontroller.text = widget.rate;
    super.initState();
  }

  final _prodKey = GlobalKey<FormState>();
  final updatenamecontroller = TextEditingController();
  final updatepricecontroller = TextEditingController();
  final updateqtycontroller = TextEditingController();
  final updateratecontroller = TextEditingController();

  String name, qty, rate, price, billno;
  int pr;
  List<ItemModel> items = [];
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
                              if (text == null) {
                                name = widget.name;
                              }
                              name = text;
                            },
                            controller: updatenamecontroller,
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
                                          if (text == null) {
                                            qty = widget.qty;
                                          }
                                          qty = text;
                                          pr = int.parse(
                                                  updateqtycontroller.text) *
                                              int.parse(
                                                  updateratecontroller.text);
                                          setState(() {
                                            updatepricecontroller.text =
                                                pr.toString();
                                            print(updatepricecontroller.text);
                                          });
                                        },
                                        controller: updateqtycontroller,
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
                                        if (text == null) {
                                          rate = widget.rate;
                                        }
                                        rate = text;
                                        pr = int.parse(
                                                updateqtycontroller.text) *
                                            int.parse(
                                                updateratecontroller.text);
                                        setState(() {
                                          updatepricecontroller.text =
                                              pr.toString();
                                          print(updatepricecontroller.text);
                                        });
                                      },
                                      controller: updateratecontroller,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                    controller: updatepricecontroller,
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
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 20.0, 0, 5.0),
                        child: ButtonTheme(
                          minWidth: 160.0,
                          height: 50.0,
                          buttonColor: Colors.green[800],
                          child: RaisedButton(
                            color: Colors.green[800],
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              print('Before Editing');
                              print(widget.items.map((e) => e.name));
                              if (name == null) {
                                name = widget.name;
                              }
                              if (qty == null) {
                                qty = widget.qty;
                              }
                              if (rate == null) {
                                rate = widget.rate;
                              }
                              // if (price == null) {
                              //   price = widget.price;
                              // }
                              print('Before Editing 1');
                              print(rate);
                              print(qty);
                              price =
                                  (int.parse(qty) * int.parse(rate)).toString();
                              print(price);
                              print(name);
                              print(qty);
                              print(rate);
                              print(price);
                              setState(() {
                                ItemModel newitem = new ItemModel(
                                    name.toUpperCase(),
                                    qty.toUpperCase(),
                                    rate.toUpperCase(),
                                    price.toString().toUpperCase());
                                ItemModel upitem = new ItemModel(
                                    widget.name.toUpperCase(),
                                    widget.qty.toUpperCase(),
                                    widget.rate.toUpperCase(),
                                    widget.price.toString().toUpperCase());
                                String search = widget.name;
                                upitem = widget.items
                                    .where((element) =>
                                        element.name == widget.name)
                                    .first;

                                var index = widget.items.indexOf(upitem);
                                print(index);
                                if (index != -1) {
                                  widget.items[index] = newitem;
                                }

                                print(widget.items[index].name);
                                print(widget.items[index].qty);
                                print(widget.items[index].rate);
                                print(widget.items[index].price);
                              });
                              print(widget.items.map((e) => e.name));
                              print(widget.items.map((e) => e.qty));
                              print(widget.items.map((e) => e.rate));
                              print(widget.items.map((e) => e.price));
                              Fluttertoast.showToast(
                                  msg: 'Item Updated',
                                  backgroundColor: Colors.blue);
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
                              Icons.delete,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              print('Before Deleting');
                              print(widget.items.map((e) => e.name));
                              if (name == null) {
                                name = widget.name;
                              }
                              if (qty == null) {
                                qty = widget.qty;
                              }
                              if (rate == null) {
                                rate = widget.rate;
                              }
                              print('Before Deleting 1');
                              print(rate);
                              print(qty);
                              print(price = (int.parse(qty) * int.parse(rate))
                                  .toString());
                              print(name);
                              print(qty);
                              print(rate);
                              print(price);
                              setState(() {
                                ItemModel delitem = new ItemModel(
                                    widget.name.toUpperCase(),
                                    widget.qty.toUpperCase(),
                                    widget.rate.toUpperCase(),
                                    widget.price.toString().toUpperCase());

                                delitem = widget.items
                                    .where((element) =>
                                        element.name ==
                                        widget.name.toUpperCase())
                                    .first;
                                print(delitem.name);
                                var index = widget.items.indexOf(delitem);
                                print(index);
                                if (index != -1) {
                                  widget.items.removeWhere(
                                      (element) => element.name == widget.name);
                                  print('deleted');
                                }
                              });
                              print(widget.items.map((e) => e.name));
                              print(widget.items.map((e) => e.qty));
                              print(widget.items.map((e) => e.rate));
                              print(widget.items.map((e) => e.price));
                              Fluttertoast.showToast(
                                  msg: 'Item Deleted',
                                  backgroundColor: Colors.blue);
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
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
