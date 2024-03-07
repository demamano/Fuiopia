import 'package:dbclient/dbclient.dart';
import 'package:fuiopia/data/models/category_model.dart';

class FirebaseCategoryRepository {
  final DbClient dbClient;
  const FirebaseCategoryRepository(this.dbClient);
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final categoriesData = await dbClient.fetchAll(collection: 'categories');
      return categoriesData
          .map((e) => CategoryModel.fromMap(e.id, e.data))
          .toList();
    } catch (e) {
      throw Exception("failed to Load Categoris$e");
    }
  }

  Future<void> createCategories() async {
    try {
      for (var category in categories) {
        await dbClient.add(collection: 'categories', data: category);
      }
    } catch (e) {
      throw Exception("Field to create categories$e");
    }
  }
}

List<Map<String, dynamic>> categories = [
  {
    "name": "Appliances",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1708904889/yxcuxpcejbrbs9s7stjb.jpg"
  },
  {
    "name": "Arts",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/c_scale,h_720,w_1080/uz1ko0xvrb6cvnqjeeju.jpg"
  },
  {
    "name": "Automotive",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/t_automative/psv7twfnn9v9kfkjh6aj.jpg"
  },
  {
    "name": "Baby products",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/c_scale,h_720,w_1080/dgjo1qtn3jb2mza1x0qj.jpg"
  },
  {
    "name": "Beauty and personal care",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1708906701/d2qsomqemm2c0f9qfryg.jpg"
  },
  {
    "name": "Books",
    "imageUrl":
        "https://macmillan-dam.captureweb.co.uk/cdn/macmill…/0/14665546cf5662d409143d004ffc0c54/131898933.jpg"
  },
  {
    "name": "Clothing, shoes, and jewellery",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/t_clothing_shoe/b5ordvjmqc37yvcabr6g.jpg"
  },
  {
    "name": "Electronics",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/e_improve:outdoor/c_scale,h_1080,w_1920/ozfzx3jaxdkyz8m5eril.jpg"
  },
  {
    "name": "Grocery",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/c_scale,h_720,w_1080/tvv2byu9tqoae1wc16rm.jpg"
  },
  {
    "name": "Health",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/t_health_cat/lufxzvxrxq6ic6hkeof1.jpg"
  },
  {
    "name": "Home and kitchen",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/t_kitchen_home/wjphb0zd0mixinxzzdkp.jpg"
  },
  {
    "name": "Musical Instrument",
    "imageUrl":
        "https://ventsmagazine.com/wp-content/uploads/2023/10/instruments-660x330.jpg"
  },
  {
    "name": "Office products",
    "imageUrl":
        "https://aa-business.co.uk/wp-content/uploads/2019/10/Office-Accessories.jpg"
  },
  {
    "name": "Sports and outdoors",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/t_outdoor/swm1v9dhaenuv1cs5xh9.jpg"
  },
  {
    "name": "Tools and home",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/t_home_tools/rpagwkin91nov4qhqjlx.jpg"
  },
];
