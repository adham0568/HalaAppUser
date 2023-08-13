import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/provider/CartProvider.dart';
import 'package:halaapp/provider/TotalPrudact.dart';
import 'package:provider/provider.dart';
import '../../Cart/CartPage.dart';
import 'PrudactRestaurant.dart';

class PrudactsRust extends StatefulWidget {
  Map DataFromCollection;

  PrudactsRust({super.key, required this.DataFromCollection});
  @override
  State<PrudactsRust> createState() => _PrudactsRustState();
}
String? numOfPrudacts;
class _PrudactsRustState extends State<PrudactsRust> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    int columnCount = 3;
    final Provaider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(expandedHeight: 200,
            pinned: true,
            backgroundColor: Colors.black12,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: widget.DataFromCollection['ImageUrl'],
                placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.white,child: Icon(CupertinoIcons.back,color: Colors.black,),),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                width: 40,height: 40,
                child: Stack(
                  children: [
                    Positioned(
                        top: 9,
                        left: 15,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: const BoxDecoration(color: Color.fromRGBO(0, 222, 207, 100), shape: BoxShape.circle),

                          child: Center(child: Consumer<total>(
                            builder: (context, value, child) {
                              return Text(value.Num1().toString(),style: const TextStyle(fontSize: 15,color: Colors.black45),);
                            },
                          )),
                        )),
                    Positioned(
                        top: 10,
                        right: 2,
                        left: 1,
                        bottom: 10,
                        child: IconButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const CartPage()));
                        },
                            icon: const Icon(CupertinoIcons.cart,
                              color: Colors.black,))),
                  ],
                ),
              )
            ],
          ),

          SliverList(delegate: SliverChildBuilderDelegate((context, index) {
            if(index.isOdd){return GridViewRust(Prudact: widget.DataFromCollection,Swich: true,Uid: '',);}
            else{return Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors:
                        [
                          Color.fromRGBO(56, 95, 172, 1),
                          Color.fromRGBO(1, 183, 168, 1)
                        ])),
                width: double.infinity,
                child: Center(child: Text(widget.DataFromCollection['Name'],
                  style: const TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.white),)));}
          },childCount:2 )),
        ],
      ),
    );
  }
}








