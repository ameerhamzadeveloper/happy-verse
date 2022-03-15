import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/routes/routes_names.dart';
class InterestSubCat extends StatefulWidget {
  const InterestSubCat({Key? key}) : super(key: key);

  @override
  _InterestSubCatState createState() => _InterestSubCatState();
}

class _InterestSubCatState extends State<InterestSubCat> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit,RegisterState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Intrests"),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                ),
                onPressed: () => Navigator.pushNamed(context, createProfile),
                child: const Text(
                  "Next",
                ),
              )
            ],
          ),
          body: Column(
            children: [
              const SizedBox(height: 20,),
              Expanded(
                child: Card(
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10,),
                          Text("Let's Get more specific. Which topics intrest you"),
                          SizedBox(height: 20,),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.intrest!.length,
                            itemBuilder: (ctx,i){
                              if(state.intrest![i].isSelect){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Popular in ${state.intrest![i].intrestCategoryTitle}",style: TextStyle(fontSize: 17),),
                                    ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.intrest![i].intrestSubCategory.length,
                                      itemBuilder: (ctx,j){
                                        return Column(
                                          children: [
                                            const SizedBox(height: 10,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(state.intrest![i].intrestSubCategory[j].interestSubCategoryTitle,style: const TextStyle(color: Colors.grey),),
                                                Checkbox(
                                                    value: state.intrest![i].intrestSubCategory[j].isSelect,
                                                    onChanged: (v)=>context.read<RegisterCubit>().onSubIntSelect(i, j),
                                                )
                                              ],
                                            ),
                                            const Divider(),
                                          ],
                                        );
                                      },
                                    )
                                  ],
                                );
                              }
                              return Container();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
