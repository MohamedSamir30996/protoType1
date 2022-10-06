import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_start/layout/ShopApp/Cubit/Cubit.dart';
import 'package:udemy_start/layout/ShopApp/Cubit/States.dart';
import 'package:udemy_start/models/shop_app/categories_model.dart';
import 'package:udemy_start/models/shop_app/home_model.dart';
import 'package:udemy_start/shared/components/components.dart';
import 'package:udemy_start/shared/components/variables.dart';
import 'package:udemy_start/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.model.status!) {
            ShowToast(
              text: state.model.message!,
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) => productBuilder(cubit.homeModel, cubit.categoriesModel , context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productBuilder(ShopHomeModel? model , CategoriesModel? categoriesModel , context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
          children: [
            CarouselSlider(
              items: model?.data?.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1,
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  SizedBox(
                    height: 10.0,
                  ),

                  Container(
                    height: 100.0,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categoriesModel!.data!.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10.0,
                      ),
                      itemCount: categoriesModel!.data!.data.length,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                padding: EdgeInsets.all(8),
                childAspectRatio: 1 / 1.67,
                children: List.generate(model!.data!.products.length,
                    (index) => BuildGridProduct(model.data!.products[index],context)),
              ),
            )
          ],
        ),
  );

  Widget buildCategoryItem(DataModel model) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(model.image ?? ''),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(
          .8,
        ),
        width: 100.0,
        child: Text(
          model.name ?? '',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );


  Widget BuildGridProduct(ProductModel model,context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: NetworkImage(model.image ?? ''),
                    height: 200,
                    width: double.infinity,
                  ),
                  Text(
                    model.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.1,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${model.price.round() ?? ''}",
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.3,
                              color: defaultColor,
                            ),
                          ),
                          if(model.discount != 0)
                            Row(
                              children: [
                                Text(
                                  "${model.old_price.round() ?? ''}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.3,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                if(model.discount != 0)
                                  Container(
                                    color: defaultColor[100],
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      "- ${((model.old_price-model.price)*100/model.old_price).round()} %",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: defaultColor,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),

                      Spacer(),
                      IconButton(onPressed: (){
                        ShopCubit.get(context).changeFavorites(model.id!);
                        print(model.id);
                      },

                          icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:ShopCubit.get(context).favorites[model.id]! ? defaultColor: Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        size: 14.0,
                        color: Colors.white,
                      ),
                          ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
  );
}
