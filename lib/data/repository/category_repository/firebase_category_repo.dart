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
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1710321807/wgvjnkqkudnz80rewayn.jpg"
  },
  {
    "name": "Automotive",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1710321808/qsvpbrqeyvalefeac5ls.png"
  },
  {
    "name": "Baby products",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1710321808/nw14ed5qankgywlq1jjr.png"
  },
  {
    "name": "Beauty and personal care",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1710321809/ojknuijdxaw84pejvjci.png"
  },
  {
    "name": "Books",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1710321808/ix7e7m2nj8a7gbrbwmos.png"
  },
  {
    "name": "Clothing, shoes, and jewellery",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1710321809/xfkrbjxs3wadhslmv85v.png"
  },
  {
    "name": "Electronics",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1710321810/s9fxrvudmzlcxk1qn1xc.png"
  },
  {
    "name": "Grocery",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1710321808/hukkgbz5ir5vajer8re1.png"
  },
  {
    "name": "Health",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1710321807/diwco2trudx777arp6ah.png"
  },
  {
    "name": "Home and kitchen",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1710321806/y3kx1w4niosbfwk3kxu4.png"
  },
  {
    "name": "Musical Instrument",
    "imageUrl":
        "https://ventsmagazine.com/wp-content/uploads/2023/10/instruments-660x330.jpg"
  },
  {
    "name": "Office products",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1710321807/yh9pa86hzcnn9cucou1z.png"
  },
  {
    "name": "Sports and outdoors",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1710321809/isgc3lgzlrjkyahpq4fr.png"
  },
  {
    "name": "Tools and home",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/t_home_tools/rpagwkin91nov4qhqjlx.jpg"
  },
];
