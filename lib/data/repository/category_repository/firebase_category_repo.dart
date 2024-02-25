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
        "https://cdn.firstcry.com/education/2023/01/13101355/Names-Of-Household-Appliances-In-English.jpg"
  },
  {
    "name": "Arts",
    "imageUrl":
        "https://worlduniversityofdesign.ac.in/assets/images/bgs/school-of-visual-arts-banner.jpg"
  },
  {
    "name": "Automotive",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1708780964/psv7twfnn9v9kfkjh6aj.jpg"
  },
  {
    "name": "Baby products",
    "imageUrl":
        "https://softsensbaby.com/cdn/shop/files/Website-Banner.gif?v=1704862260"
  },
  {
    "name": "Beauty and personal care",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1708782899/twia9w1qyousywztecac.jpg"
  },
  {
    "name": "Books",
    "imageUrl":
        "https://macmillan-dam.captureweb.co.uk/cdn/macmill…/0/14665546cf5662d409143d004ffc0c54/131898933.jpg"
  },
  {
    "name": "Clothing, shoes, and jewellery",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1708775940/b5ordvjmqc37yvcabr6g.jpg"
  },
  {
    "name": "Electronics",
    "imageUrl":
        "https://www.polytechnichub.com/wp-content/uploads/2017/04/Electronic.jpg"
  },
  {
    "name": "Grocery",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1708796244/tvv2byu9tqoae1wc16rm.jpg"
  },
  {
    "name": "Health",
    "imageUrl":
        "https://www.medibid.com/wp-content/uploads/2023/12/HealthCoach-Page-Hero-Side.jpg"
  },
  {
    "name": "Home and kitchen",
    "imageUrl":
        "https://m.media-amazon.com/images/I/81yXPUqatGL._AC_SL1500_.jpg"
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
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1708798251/swm1v9dhaenuv1cs5xh9.jpg"
  },
  {
    "name": "Tools and home",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1708797670/rpagwkin91nov4qhqjlx.jpg"
  },
];
