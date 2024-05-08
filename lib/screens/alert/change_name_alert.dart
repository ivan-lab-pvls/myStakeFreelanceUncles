import 'package:flutter/material.dart';

import 'bv_fill_all_xcv.dart';

class ChangeNameAlert extends StatefulWidget {
  const ChangeNameAlert({super.key});

  @override
  State<ChangeNameAlert> createState() => _ChangeNameAlertState();
}

class _ChangeNameAlertState extends State<ChangeNameAlert> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24),
            child: Container(
              width: double.infinity,

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white.withOpacity(0.9)
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
                        Text('Change name', style: TextStyle(height: 1, fontSize: 22, color: Color(0xFF121F2B), fontWeight: FontWeight.w700),),
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
                  Padding(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Name', style: TextStyle(fontSize: 13,),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    child: TextField(
                      maxLines: 1,
                      controller: textEditingController,
                      style: const TextStyle(fontSize: 16, color: Color(0xFF121F2B), height: 1.2),
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true, // Включить заливку цветом
                        fillColor: const Color(0xFF929292).withOpacity(0.15), // Указать цвет фона
                        border: OutlineInputBorder( // Определить границы
                          borderRadius: BorderRadius.circular(8.0), // Закругление углов
                          borderSide: BorderSide.none, // Убрать видимую линию границы
                        ),
                        contentPadding: const EdgeInsets.only(left: 12.0, top: 9, right: 12, bottom: 5), // Добавить отступ со всех сторон
                      ),
                    ),
                  ),
                  SizedBox(height: 24,),
                  Padding(
                    padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    child: lightRedButton('Change', (){
                      print('object');
                      //Navigator.of(context).pop(Task(nameoftaskController.text, selectDate, descriptionController.text, 'widget.player', false));
                      if (textEditingController.text.isNotEmpty){
                        Navigator.of(context).pop(textEditingController.text);
                      } else {
                        showDialog(
                          useSafeArea: false,
                          context: context,
                          builder: (BuildContext context) {

                            return FillAll();
                          },
                        );
                      }



                      //BlocProvider.of<PlayerBloc>(context).add(AddPlayerEvent(imagePic, nameEditorController.text, int.parse(numberEditorController.text), selectDate, selectPosition.toString()));
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget lightRedButton(String str, void Function() toDo) {
    return GestureDetector(
      onTap: (){
        toDo();
      },
      child: Container(
        width: 200,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(0.4)
        ),
        alignment: Alignment.center,
        child: Text(str, style: TextStyle( color: Colors.white, fontSize: 24),),
      ),
    );
  }
}