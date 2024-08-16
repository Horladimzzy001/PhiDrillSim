import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class storepage extends StatefulWidget {
  const storepage({super.key});

  @override
  State<storepage> createState() => _storepageState();
}

class _storepageState extends State<storepage> {
  List items = [
    {
      'name': "Danami Children's Zip Up Hoodie",
     'age': 'N10,000',
     'image':
     'lib/images/image 6.png'
     },
    {'name': "Danami Children's Zip Up Hoodie", 'age': 'N20,000',
    'image':'lib/images/image 5.png'
    },
    {'name': "ADIDAS Sports Performance Slides", 'age': 'N30,000','image':'lib/images/image 5.png'},
    {'name': "ADIDAS Sports Performance Slides", 'age': 'N40,000','image':'lib/images/image 6.png'},
      {
      'name': "Danami Children's Zip Up Hoodie",
     'age': 'N10,000',
     'image':
     'lib/images/image 6.png'
     },
    {'name': "Danami Children's Zip Up Hoodie", 'age': 'N20,000',
    'image':'lib/images/image 5.png'
    },
    {'name': "ADIDAS Sports Performance Slides", 'age': 'N30,000','image':'lib/images/image 5.png'},
    {'name': "ADIDAS Sports Performance Slides", 'age': 'N40,000','image':'lib/images/image 6.png'}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 245, 245),
      body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Kids Store',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),),
                  Row(
                    children: [
                     Image(image: AssetImage('lib/images/Frame 6.png')),
                      SizedBox(width: 10,),
                      Image(image: AssetImage('lib/images/Frame 7.png'))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 286,
                  crossAxisCount: 2, mainAxisSpacing: 10,crossAxisSpacing: 20),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                
                  child: Column(
                 
                    children: [
                      Container(
                        height: 221,
                        child: Column(
                         
                          children: [
                            Container(
                              
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                                
                              ),
                              padding: EdgeInsets.all(8.0),
                              height: 150,
                              width: 150,
                              child: Image(image: AssetImage(items[index]['image'])),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(items[index]['name']),
                              Text(items[index]['age'],style: TextStyle(fontWeight: FontWeight.bold),),
                                ],
                              ),
                            )
                              
                          ],
                        ),
                      ),
                     
                      SizedBox(height: 10.7,),
                      SizedBox(
                        height: 40,
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:  Color(0xFFF6F2F7),
                            shape: StadiumBorder(),
                            side: BorderSide(color: Color(0xff64436E))
                          ),
                          onPressed: (){
                        
                        }, child: Text('Add to Cart',style: TextStyle(color: Color(0xff64436E),fontWeight:FontWeight.bold ),)),
                      ),
                      
                    ],
                  ),
                  
                );
                
              },
              itemCount: items.length,
            )
          ],
        ),
      )),
    );
  }
}
