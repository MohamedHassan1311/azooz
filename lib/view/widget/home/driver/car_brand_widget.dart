import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/style/colors.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../model/request/driver_category_model.dart';
import '../../../../providers/be_captain/car_category_provider.dart';
import '../../../../utils/smart_text_inputs.dart';

class CarBrandWidget extends StatefulWidget {
  const CarBrandWidget({Key? key}) : super(key: key);

  @override
  State<CarBrandWidget> createState() => CarBrandWidgetState();
}

class CarBrandWidgetState extends State<CarBrandWidget> {
  late Future<CarCategoryModel?> _driverCateoryFuture;

  @override
  void initState() {
    _driverCateoryFuture = context.read<CarCategoryProvider>().getCarCategory();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CarCategoryModel?>(
        future: _driverCateoryFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Consumer<CarCategoryProvider>(
              builder: (context, carCategory, child) {
                return SmartDropDownField<CarCategory>(
                  label: "",
                  hasLabel: false,
                  fillColor: Palette.kSelectorColor,
                  hint: Text(
                    LocaleKeys.carKind.tr(),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  onChanged: (driverCategory) {
                    context.read<CarCategoryProvider>().setCarCategory =
                        driverCategory!;
                    print("Selected Driver Category:: ${driverCategory.name}");
                    print("Selected Driver Category::ID ${driverCategory.id}");
                  },
                  items: carCategory.listCarCategory!
                      .map((types) => DropdownMenuItem<CarCategory>(
                            value: types,
                            child: Text(
                              types.name.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                          ))
                      .toList(),
                );
              },
            );
          }
          return const SizedBox();
        });
  }
}
