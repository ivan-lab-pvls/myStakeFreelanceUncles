import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../service/hive_service.dart';
import '../hidden_symbols_screen.dart';

class BottomBarWidget extends StatefulWidget {
  final ValueNotifier play;
  final ValueNotifier<int> selectI;
  final ValueNotifier<int> stake;
  const BottomBarWidget({super.key, required this.play, required this.selectI, required this.stake});

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  late final TextEditingController _controller;
  late final GlobalKey<FormState> _formKey;
  String? errorText;
  //TextEditingController _controller = TextEditingController();
  int selectItem = 0;
  int userMoney = HiveService.getUser()!.money;
  void isValid() {
    if (_controller.text.isEmpty) {
      errorText = null;
      setState(() {});
      return;
    }
    final money = int.parse(_controller.text);

    if (money < 10) {
      errorText = 'Неможливо поставити менше 10';
    } else if (money > userMoney) {
      errorText = 'Занадто багато! Перевірте баланс';
    } else {
      errorText = null;
    }
    setState(() {});
  }

  @override
  void initState() {
    selectItem = 0;
    super.initState();
    _controller = TextEditingController(text: '');
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: ValueListenableBuilder(
        valueListenable: widget.play,
        builder: (context, valuer, child) {
          return Container(
            padding: EdgeInsets.only(left: 24, top: 24, right: 24, bottom: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF2B2C37),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: !valuer ? [
                BoxShadow(
                  color: Color(0xFFE60BEB),
                  offset: Offset(0, -2),
                  blurRadius: 0
                ),
                BoxShadow(
                    color: Color(0xFFE60BEB),
                    offset: Offset(0, -60),
                    blurRadius: 140
                )
              ] : []
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Your Bet', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.white),),
                    ValueListenableBuilder(
                        valueListenable: HiveService.getUserListenable(),
                        builder: (context, box, child) {
                          userMoney = box.values.first.money;
                          final user = box.values.first;
                          return Row(
                            children: [
                              Text('Balance', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.white),),
                              const SizedBox(width: 10,),
                              const Image(image: AssetImage('assets/image/ms_money.png'), width: 14,),
                              const SizedBox(width: 8,),
                              Text(user.money.toString(), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.white),),
                            ],
                          );
                        }
                    ),
                  ],
                ),
                SizedBox(height: 18,),
                Form(
                  key: _formKey,
                  child: TextField(
                    style: TextStyle(fontSize: 12, color: Colors.white),
                    controller: _controller,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.white,
                    textAlignVertical: TextAlignVertical.center,
                    onChanged: (value){
                      isValid();
                      setState(() {

                      });
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      prefixIcon: Container(width: 10, alignment: Alignment.center ,child: Image(image: AssetImage('assets/image/ms_money.png'), width: 16,)),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 10,
                      ),
                      filled: true,
                      fillColor: Color(0xFF1B1B22),
                      suffixIcon: (_controller.text.isEmpty)
                          ? null
                          : IconButton(
                        onPressed: () => setState(() {
                          _controller.clear();
                          errorText = null;
                        }),
                        icon: Icon(Icons.close),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      //errorText: errorText,
                      /*errorStyle: AppTextStyles.caption12.copyWith(
                        color: AppColors.pink,
                      ),

                       */
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    itemb(10),
                    itemb(20),
                    itemb(50),
                    itemb(100),
                    itemb(250)
                  ],
                ),
                SizedBox(height: 26,),
                GestureDetector(
                  onTap: (){
                    if (_controller.text.isNotEmpty && int.parse(_controller.text) <= HiveService.getUser()!.money){
                      if (!valuer && widget.selectI.value != 0){
                        widget.stake.value = int.parse(_controller.text);
                        widget.play.value = true;
                        HiveService.updateUserMoney(HiveService.getUser()!.money - int.parse(_controller.text));
                      }
                    }
                    FocusScope.of(context).unfocus();

                  },
                  child: Container(
                    width: 220,
                    height: 52,
                    decoration: !valuer ? BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [Color(0xFF00AAEB), Color(0xFFE60BEB)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF8D1890),
                          offset: Offset(0, 4),
                          blurRadius: 0
                        )
                      ]
                    ) : BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xFF3D3A5F)

                    ),
                    alignment: Alignment.center,
                    child: Text('Play', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 16),),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom,),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget itemb (int i){
    return GestureDetector(
      onTap: (){
        setState(() {
          selectItem = i;
        });
        if (_controller.text.isNotEmpty){
          _controller.text = (int.parse(_controller.text) + i).toString();
        } else {
          _controller.text = i.toString();
        }
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 48 - 40) / 5,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xFF618FE3),
          border: Border.all(
            color: selectItem == i ? Colors.white : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: selectItem == i ? Color(0xFF5BD2FF) : Colors.transparent,
              offset: Offset(0, 4),
              blurRadius: 9
            )
          ]
        ),
        alignment: Alignment.center,
        child: Text('+$i', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),),
      ),
    );
  }
}
