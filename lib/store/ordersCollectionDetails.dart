import 'package:flutter/material.dart';

class OrdersDetailsCollection extends StatefulWidget {
  const OrdersDetailsCollection({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OrdersDetailsCollectionState();
}

class _OrdersDetailsCollectionState extends State<OrdersDetailsCollection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(

                  children: [
                    SizedBox(width: 10,),
                    Icon(Icons.arrow_back_ios),
                    SizedBox(width: 70,),
                    Text('My Orders',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),)
                  ],
                ),
                SizedBox(height: 20,),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 44,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Row(
                          children: [
                            Image(image: AssetImage('lib/images/image 5.png'),width: 70,height: 70,),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('PJ Masks Children Hooded T-Shirt'),
                                SizedBox(height: 10,),
                                Text('N10,000',style: TextStyle(fontWeight: FontWeight.w600),)
                              ],
                            )
                          ],
                        ),
                      );
                    }
                ),
                SizedBox(height: 10,),
                Divider(color: Color(0xFFEDEDED)
                  ,),
                SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date Ordered',style: TextStyle(color: Color(0xFF737373),fontSize: 12),),
                    Row(
                      children: [

                        Text('21st March 2024',style: TextStyle(fontSize: 12),),
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 10,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Number of Items',style: TextStyle(color: Color(0xFF737373),fontSize: 12),),
              Row(
                children: [

                  Text('1',style: TextStyle(fontSize: 12),),
                ],
              ),

            ],
          ),

          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery Method',style: TextStyle(color: Color(0xFF737373),fontSize: 12),),
              Row(
                children: [

                  Text('Pick up at Peony',style: TextStyle(fontSize: 12),),
                ],
              ),

            ],
          ),
          SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Status',style: TextStyle(color: Color(0xFF737373),fontSize: 12),),
                    Row(
                      children: [
                        CircleAvatar(backgroundColor: Color(0xFFE36E9A),radius: 5,),
                        SizedBox(width: 5,),
                        Text('Delivered',style: TextStyle(color: Color(0xFF737373),fontSize: 12),),
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total',style: TextStyle(fontWeight: FontWeight.w400),),
              Row(
                children: [

                  Text('N10,000',style: TextStyle(fontWeight: FontWeight.w600),),
                ],
              ),

            ],
          ),
          SizedBox(height: 10,),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
