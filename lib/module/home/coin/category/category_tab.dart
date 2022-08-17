import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../widget/_widget.dart';
import 'category_bloc.dart';
import 'category_state.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state.loading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state.categories?.isEmpty ?? true) {
          return const Center(child: Text('Server Error'));
        }
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: state.categories!.length,
          itemBuilder: (context, i) {
            final item = state.categories![i];
            return GestureDetector(
              onTap: () => {},
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: item.top3Coins
                              .map((e) => Container(
                                  margin: const EdgeInsets.only(right: 4),
                                  child: WidgetImage(
                                    url: e,
                                    height: 24,
                                    width: 24,
                                    border: 24 / 2,
                                  )))
                              .toList(),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          NumberFormat.compactSimpleCurrency().format(item.marketCap),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        WidgetArrowStatus(value: item.marketCapChange24H),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
