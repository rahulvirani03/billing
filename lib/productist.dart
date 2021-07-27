import 'package:billing/addprod.dart';
import 'package:billing/updateitem.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'itemmodel.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:open_file/open_file.dart' as open_file;
import 'package:number_to_words/number_to_words.dart';
import 'addmore.dart';

class ProductList extends StatefulWidget {
  List<ItemModel> items;
  String billno, date;

  int total = 0;
  ProductList(List<ItemModel> items, String billno, String date) {
    this.billno = billno;
    this.date = date;
    print(billno + date);

    this.items = items;
    print(items.map((e) => e.name));
    print(items.map((e) => e.qty));
    print(items.map((e) => e.rate));
    print(items.map((e) => e.price));
  }
  ProductListNew(List<ItemModel> items) {
    items = this.items;
  }

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<ItemModel> items;
  Future<void> generateInvoice(List<ItemModel> items, String tot) async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219, 255)));
    //Generate PDF grid.
    final PdfGrid grid = getGrid(items);
    //Draw the header section by creating text element
    final PdfLayoutResult result = drawHeader(page, pageSize, grid);
    //Draw grid
    drawGrid(page, grid, result);

    //Add invoice footer
    drawFooter(page, pageSize);
    //Save and launch the document
    final List<int> bytes = document.save();
    //Dispose the document.
    document.dispose();
    //Get the storage folder location using path_provider package.
    final Directory directory =
        await path_provider.getApplicationDocumentsDirectory();
    final String path = directory.path;
    print(path);
    // String leng=this.items.length.toString();

    String filename = 'output' + items.length.toString();

    final File file = File('$path/$filename.pdf');
    // if (file.length() != null) {
    //   await file.delete();
    //   String filename = 'new_output' + items.length.toString();
    //   final File file1 = File('$path/$filename.pdf');
    //   await file1.writeAsBytes(bytes);
    //   //Launch the file (used open_file package)
    //   await await open_file.OpenFile.open('$path/$filename.pdf');
    // } else {
    await file.writeAsBytes(bytes);
    //Launch the file (used open_file package)
    await await open_file.OpenFile.open('$path/$filename.pdf');
  }

  //Draws the invoice header
  PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215, 255)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //Draw string
    page.graphics.drawString(
        'Rahul Foods And General', PdfStandardFont(PdfFontFamily.helvetica, 22),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 65),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString(
        'Nashik 422002', PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 105, 105),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString(
        '9763861683/9096129992', PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 105, 135),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString('saileshvirani00@gmail.com',
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 95, 165),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(65, 104, 205)));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 14);
    //Draw string
    page.graphics.drawString('Invoice', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));
    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String dateformat = format.format(DateTime.now());
    //'Invoice Number: 2058557939\r\n\r\nDate: ' + format.format(DateTime.now());
    final Size contentSize = contentFont.measureString(dateformat);
    const String address = ''; //'''Bill To: \r\n\r\nAbraham Swearegin,
    //  \r\n\r\nUnited States, California, San Mateo,
    //  \r\n\r\n9920 BridgePointe Parkway, \r\n\r\n9365550136''';

    PdfTextElement(text: widget.date, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120));

    PdfTextElement(text: widget.billno, font: contentFont)
        .draw(page: page, bounds: Rect.fromLTRB(70, 120, 50, 80));

    PdfTextElement(text: 'Bill No.:', font: contentFont)
        .draw(page: page, bounds: Rect.fromLTRB(20, 120, 90, 80));

    PdfTextElement(text: 'Date:', font: contentFont)
        .draw(page: page, bounds: Rect.fromLTRB(325, 120, 90, 80));

    return PdfTextElement(text: address, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120));
  }

  //Draws the grid
  void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect totalPriceCellBounds;
    Rect quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0));

    //Draw grand total.
    page.graphics.drawString('',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            quantityCellBounds.left,
            result.bounds.bottom + 10,
            quantityCellBounds.width,
            quantityCellBounds.height));
  }

  //Draw the invoice footer data.
  void drawFooter(PdfPage page, Size pageSize) {
    final PdfPen linePen =
        PdfPen(PdfColor(142, 170, 219, 255), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
        Offset(pageSize.width, pageSize.height - 100));

    const String footerContent = 'Grand Total:';

    // '''800 Interchange Blvd.\r\n\r\nSuite 2501, Austin,
    //      TX 78721\r\n\r\nAny Questions? support@adventure-works.com''';

    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 15),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTRB(140, 680, 260, 20));

    page.graphics.drawString(
        'Amount in Words:', PdfStandardFont(PdfFontFamily.helvetica, 15),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTRB(135, 700, 260, 20));

    page.graphics.drawString(tot, PdfStandardFont(PdfFontFamily.helvetica, 15),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTRB(260, 680, 300, 20));
    String words = NumberToWord().convert('en-in', int.parse(tot));
    page.graphics.drawString(
        words.toUpperCase(), PdfStandardFont(PdfFontFamily.helvetica, 15),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTRB(250, 700, 440, 40));
  }

  //Create PDF grid and return
  PdfGrid getGrid(List<ItemModel> items) {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    int len = items.length;
    print(len);
    grid.columns.add(count: 5);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'SR.NO';
    headerRow.cells[1].value = 'Name';
    headerRow.cells[2].value = 'Qty';
    headerRow.cells[3].value = 'Rate';
    headerRow.cells[4].value = 'Price';

    //Add rows
    for (int i = 0; i < len; i++) {
      addProducts(i + 1, items[i].name, items[i].qty, items[i].rate,
          items[i].price, grid);
    }

    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    //Set gird columns width
    grid.columns[0].width = 50;
    grid.columns[1].width = 150;
    grid.columns[2].width = 110;
    grid.columns[3].width = 110;
    grid.columns[4].width = 110;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }

        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  //Create and row for the grid.
  void addProducts(int no, String name, String qty, String rate, String price,
      PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.cells[0].value = no.toString();
    row.cells[1].value = name;
    row.cells[2].value = qty;
    row.cells[3].value = rate;
    row.cells[4].value = price;
  }

  //Get the total amount.
  // double getTotalAmount(PdfGrid grid) {
  //   double total = 0;
  //   for (int i = 0; i < grid.rows.count; i++) {
  //     final String value = grid.rows[i].cells[grid.columns.count - 1].value;
  //     total += double.parse(value);
  //   }
  //   return total;
  // }

  String tot;
  @override
  void initState() {
    this.items = widget.items;
    for (int i = 0; i < widget.items.length; i++) {
      print(widget.total = widget.total + int.parse(widget.items[i].price));

      tot = widget.total.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  child: Text('Add More Items'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddMore(
                                widget.items, widget.billno, widget.date)));
                  },
                ),
              ],
            ),
            Center(
              child: Text(
                'INVOICE',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Qty",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Rate",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Price",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                  rows: widget.items
                      .map((docs) => DataRow(cells: [
                            DataCell(
                                Text(
                                  docs.name,
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.white),
                                ), onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateProd(
                                          docs.name,
                                          docs.qty,
                                          docs.rate,
                                          docs.price,
                                          items,
                                          widget.billno,
                                          widget.date)));
                            }),
                            DataCell(
                              Text(
                                docs.qty,
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white),
                              ),
                            ),
                            DataCell(
                              Text(
                                docs.rate,
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white),
                              ),
                            ),
                            DataCell(
                              Text(
                                docs.price,
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white),
                              ),
                            ),
                          ]))
                      .toList()),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 50.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'TOTAL',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      '$tot',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.picture_as_pdf),
        onPressed: () {
          generateInvoice(widget.items, tot);
        },
      ),
    );
  }
}

// class ProductList extends StatelessWidget {
//   List<ItemModel> items;
//   ProductList(List<ItemModel> items) {
//     this.items = items;
//     print(items.map((e) => e.name));
//     print(items.map((e) => e.qty));
//     print(items.map((e) => e.rate));
//     print(items.map((e) => e.price));
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           ListView.builder(
//               shrinkWrap: true,
//               itemCount: items.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(
//                     items[index].name,
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 );
//               })
//         ],
//       ),
//     );
//   }
// }
