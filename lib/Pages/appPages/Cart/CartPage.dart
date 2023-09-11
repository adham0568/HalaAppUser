import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/Pages/appPages/Sections/ChackeOut/ChackeOutPage.dart';
import 'package:halaapp/models/HIGHT.dart';
import 'package:provider/provider.dart';
import '../../../provider/CartProvider.dart';
import '../../../provider/TotalPrudact.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int decimalPlaces = 1;

  SizeFix SizeQ=SizeFix();
  @override
  Widget build(BuildContext context) {
    final Provaider = Provider.of<CartProvider>(context);
    final Provaider1 = Provider.of<total>(context);
    final cartItems = Provaider.listitem();
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/Img/logowelcome.png',
          height: 100,
          color: Colors.white,
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                Color.fromRGBO(56, 95, 172, 1),
                Color.fromRGBO(1, 183, 168, 1)
              ])),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(9),
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.teal,width: 1)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    height: SizeQ.wight(context: context)/6,
                                    width: SizeQ.wight(context: context)/6,
                                    margin: const EdgeInsets.only(left: 5),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child:CachedNetworkImage(
                                          imageUrl: Provaider.listitem()[index].ImageUrl,
                                          placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),)),
                                      cartItems[index].OpitionSelected.length>=1?
                                    Column(
                                      children: [
                                        Text(
                                          cartItems[index].Name,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          height: SizeQ.Hight(context: context)/10,
                                          width: SizeQ.wight(context: context)/4,
                                          child: ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:cartItems[index].OpitionSelected.length,
                                            itemBuilder: (context, index1) => Align(
                                            child: Text(
                                                cartItems[index].Opitions[index1]['subOptions'][cartItems[index].OpitionSelected[index1]]['optionName']
                                                    ,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w100),
                                            ),
                                          ),),
                                        )
                                      ],
                                    )
                                    :
                                Text(
                                  cartItems[index].Name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${(cartItems[index].Prise * Provaider.GetNumberByProducts(Provaider.listitem()[index])).toStringAsFixed(decimalPlaces)}' '₪',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.pink,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 9),
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.black,width: 0.5)
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Provaider1.addNum();
                                            setState(() {
                                              Provaider.AddToCart(item: Provaider.listitem()[index]);
                                            });
                                          },
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.teal.shade300,
                                            size: 40,
                                          )),
                                      Text(
                                        Provaider.GetNumberByProducts(Provaider.listitem()[index]).toString(),
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Provaider1.removeNum();
                                            setState(() {
                                              Provaider.RemoveToCart(Provaider.listitem()[index],
                                                  Provaider.listitem()[index].IdPrudact);
                                            });
                                          },
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.teal.shade300,
                                            size: 40,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Provaider.Products.isEmpty
                    ? const Center(
                        child: Text(
                        'السلة فارغة قم باضافة بعض المنتجات',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ))
                    : InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChackeOotPage()));
                  },
                      child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.red,
                              gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.teal,
                                    Colors.cyanAccent
                                  ])),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 5, right: 5),
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(255, 255, 255, 110),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  children: [
                                    Text(
                                      '${Provaider. PirseCalculating().toString()} ₪',
                                      style: const TextStyle(
                                        fontSize: 40,
                                        color: Color.fromRGBO(0, 197, 185, 50),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Text(
                                'إكمال الطلب',
                                style:
                                    TextStyle(fontSize: 30, color: Colors.white),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 15, right: 15),
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(255, 255, 255, 110),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  children: [
                                    Text(
                                      Provaider.Products.length.toString(),
                                      style: const TextStyle(
                                        fontSize: 40,
                                        color: Color.fromRGBO(0, 197, 185, 50),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
