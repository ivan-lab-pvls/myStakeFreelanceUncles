import 'package:flutter/material.dart';

class FillAll extends StatefulWidget {
  const FillAll({super.key});

  @override
  State<FillAll> createState() => _FillAllState();
}

class _FillAllState extends State<FillAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24),
                  child: Container(
                    width: double.infinity,

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 6,),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(width: 36, height: 36,),
                              Text('Fill up all fields', style: TextStyle(height: 1, fontSize: 22, color: Color(0xFF121F2B)),),
                              SizedBox(width: 36, height: 36, child: Align(
                                alignment: Alignment.topCenter,
                                child: IconButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, icon: Icon(Icons.close_rounded)),
                              ))
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
