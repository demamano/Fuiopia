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
      for (var category in bannerData) {
        await dbClient.add(collection: 'banners', data: category);
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
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1710321806/y3kx1w4niosbfwk3kxu4.png"
  },
  {
    "name": "Arts",
    "imageUrl":
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1710751233/ap9ilshynizljikmxotg.png"
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
        "https://res.cloudinary.com/dr3oej7m6/image/upload/t_health-t/diwco2trudx777arp6ah.jpg"
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
        "https://res.cloudinary.com/dr3oej7m6/image/upload/v1710751255/qxvbdmt3rwdt0sjd3eka.png"
  },
];

List<Map<String, dynamic>> bannerData = [
  {
    "imageUrl":"https://res.cloudinary.com/dr3oej7m6/image/upload/v1710758600/ni1un1dfg1ipvxsniv9s.jpg"
  },
  {
    "imageUrl":"https://res.cloudinary.com/dr3oej7m6/image/upload/v1710758604/ydpfymjrkf0vgsszdhge.png",
  },
  {
    "imageUrl":"https://res.cloudinary.com/dr3oej7m6/image/upload/v1710758601/ru8xhsxijq4wlyjafsbk.png",
  }

];
  List<Map<String, dynamic>> sampleData = [
    {
      'id': '1',
      'categoryId': 'category1',
      'name': 'Product 1',
      'description': 'Description of Product 1',
      'images': ['image1.jpg', 'image2.jpg'],
      'rating': 4.5,
      'quantity': 10,
      'soldQuantity': 5,
      'originalPrice': 100,
      'percentOff': 10,
      'isAvailable': true,
    },
    {
      'id': '2',
      'categoryId': 'category2',
      'name': 'Product 2',
      'description': 'Description of Product 2',
      'images': ['image3.jpg', 'image4.jpg'],
      'rating': 4.0,
      'quantity': 15,
      'soldQuantity': 8,
      'originalPrice': 120,
      'percentOff': 15,
      'isAvailable': false,
    },
    {
      'id': '3',
      'categoryId': 'category1',
      'name': 'Product 3',
      'description': 'Description of Product 3',
      'images': ['image5.jpg', 'image6.jpg'],
      'rating': 3.8,
      'quantity': 20,
      'soldQuantity': 12,
      'originalPrice': 80,
      'percentOff': 20,
      'isAvailable': true,
    },
    {
      'id': '4',
      'categoryId': 'category3',
      'name': 'Product 4',
      'description': 'Description of Product 4',
      'images': ['image7.jpg', 'image8.jpg'],
      'rating': 4.2,
      'quantity': 12,
      'soldQuantity': 6,
      'originalPrice': 150,
      'percentOff': 5,
      'isAvailable': true,
    },
    {
      'id': '5',
      'categoryId': 'category2',
      'name': 'Product 5',
      'description': 'Description of Product 5',
      'images': ['image9.jpg', 'image10.jpg'],
      'rating': 4.7,
      'quantity': 18,
      'soldQuantity': 10,
      'originalPrice': 200,
      'percentOff': 25,
      'isAvailable': true,
    },
    
  ];



