import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ViewPayments extends StatefulWidget {
  const ViewPayments({Key? key}) : super(key: key);

  @override
  State<ViewPayments> createState() => _ViewPaymentsState();
}

class _ViewPaymentsState extends State<ViewPayments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Payments'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2.0,
          child: Column(
            children: [
              Row(
                children: [
                  Text('NAME: ',style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            fontSize: 14,
                    color: Colors.black,
          ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text('QUALIFICATON: ',style: GoogleFonts.cairo(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),),
                  ],
              ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('MOBILE NUMBER: ',style: GoogleFonts.cairo(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('EMAIL: ',style: GoogleFonts.cairo(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('AMOUNT : ',style: GoogleFonts.cairo(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('PASSING YEAR: ',style: GoogleFonts.cairo(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),),
                    ],
                  ),


            ],
          ),
        ),
      ),
    );
  }
}
