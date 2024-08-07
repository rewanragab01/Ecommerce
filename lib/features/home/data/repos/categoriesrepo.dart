// import 'package:ecommerce/features/home/data/model/categoriesmodel.dart';
// import 'package:ecommerce/features/home/data/model/productmodel.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class CategoriesRepository {
//   final String baseUrl = 'https://student.valuxapps.com/api';

//   Future<List<Category>> fetchCategories() async {
//     final response = await http.get(Uri.parse('$baseUrl/categories?page=1'));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final List<dynamic> jsonCategories = data['data']['data'];

//       return jsonCategories.map((json) {
//         String englishName = _translateToEnglish(json['name']);
//         return Category.fromJson(
//             {'name': englishName, 'image': json['image'], 'id': json['id']});
//       }).toList();
//     } else {
//       throw Exception('Failed to load categories');
//     }
//   }

//   Future<List<ProductModel>> fetchCategoriesProduct(int id) async {
//     final response = await http.get(Uri.parse('$baseUrl/categories/$id'));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final List<dynamic> jsonCategoriesproduct = data['data']['data'];

//       return jsonCategoriesproduct.map((json) {
//         String englishName = _translateToEnglish(json['name']);
//         return ProductModel.fromJson({
//           'name': englishName,
//           'image': json['image'],
//           'price': (json['price'] as num).toDouble(),
//           'old_price': (json['old_price'] as num).toDouble(),
//           'images': json['images'],
//         });
//       }).toList();
//     } else {
//       throw Exception('Failed to load categories product');
//     }
//   }

//   String _translateToEnglish(String arabicText) {
//     const translations = {
//       'اجهزه الكترونيه': 'Electronic Devices',
//       'مكافحة كورونا': 'COVID-19 Prevention',
//       'رياضة': 'Sports',
//       'ادوات الاناره': 'Lighting Tools',
//       'ملابس': 'Clothing',
//       'ابل ايفون 12 برو ماكس - 256جيجابيت, ازرق':
//           'Apple iPhone 12 Pro Max - 256GB, Blue',
//       'لاب توب ابل ماك بوك برو': 'Apple MacBook Pro laptop',
//       'مكبر صوت بلوتوث مقاوم للمياه ومحمول اكستريم 2 من جيه بي ال JBLXTREME2BLUAM - ازرق':
//           'JBL JBLXTREME2BLUAM Waterproof Portable Bluetooth Speaker Extreme 2 - Blue',
//       'تليفزيون سمارت 65 بوصة 4K الترا اتش دي منحني من سامسونج UA65RU7300RXUM':
//           'Samsung 65-inch 4K Ultra HD Curved Smart TV UA65RU7300RXUM',
//       'نيكون FX-format D750 - 24.3 ميجابيكسيل,كاميرا اس ال ار , عدسه 24-120 ملم, اسود':
//           'Nikon FX-format D750 - 24.3 MP, SLR camera, 24-120 mm lens, black',
//       'هارد اس اس دي داخلي 240 جيجابايت A400 ساتا 3 من كينجستون - 2.5 بوصة - SA400S37/240G':
//           'Kingston 240GB A400 SATA 3 Internal SSD - 2.5 inch - SA400S37/240G',
//       'أداة تمرين حديد كيتل بيل من ستارك، 24 كجم': 'Stark Kettlebell, 24 kg',
//       'كمامة لحماية الوجه، 50 قطعة - ازرق فاتح بأستك و دعامة':
//           'Face protection mask, 50 pieces - light blue with elastic band and backing',
//       'موبايل شاومي ريدمي 10 بشريحتي اتصال - 6.53 بوصة فل اتش دي ، 64 جيجا ، 4 جيجا رام ، شبكة الجيل الرابع ال تي اي - رمادي كربوني':
//           'Xiaomi Redmi 10 dual SIM mobile phone - 6.53 inches FHD, 64 GB, 4 GB RAM, 4G LTE network - Carbon Gray',
//       'حذاء رياضي للتمرين شبكي للنساء فليكس اسينشيال من نايكي - ابيض':
//           'Nike Flex Essential Mesh Training Shoes for Women - White',
//       'تي شيرت رجالي من Nike NSW Icon Futura, أسود (أسود/أبيض010)، مقاس متوسط':
//           'Nike Men\'s NSW Icon Futura T-Shirt, Black (Black/White 010), Medium',
//       'كمامة طبية بحلقات اذن ناعمة ومرنة من ايفوني، 50 قطعة':
//           'Medical mask with soft and flexible ear loops from Evony, 50 pieces',
//       'سوار شاومي مي الذكي 5 - اسود': 'Xiaomi Mi Smart Band 5 - Black',
//       'حلقة اضاءة دائرية للبث المباشر والتصوير الاحترافي M-33 مع استدارة 360 درجة 33 سم مع حامل موبايل وحامل ثلاثي 2.1 متر - ابيض و اسود':
//           'M-33 circular lighting ring for live broadcasting and professional photography with 360-degree rotation, 33 cm, with mobile holder and tripod stand, 2.1 meters - white and black',
//       'بلوفر شتوي بياقة عالية - جملي': 'High collar winter pullover - camel',
//       'سماعات العاب لاسلكية لبلاي ستيشن 5 Pulse 3D من سوني':
//           'Sony PlayStation 5 Pulse 3D wireless gaming headphones',
//       'سماعات رأس لاسلكية من سوني WI-C200 - اسود':
//           'Sony WI-C200 Wireless Headphones - Black',
//       'ضوء ليلي من شاومي مع مستشعر حركي وقاعدة مغناطسية - ابيض':
//           'Xiaomi night light with motion sensor and magnetic base - white',
//       'قميص بأكمام طويلة وجيب برقعة - زيتوني غامق':
//           'Long sleeve shirt with patch pocket - dark olive',
//       'جاكيت رجالي بياقة كولاج بلون موحد':
//           'Men\'s solid color collage collar jacket',
//     };
//     return translations[arabicText] ?? arabicText;
//   }
// }
import 'package:ecommerce/features/home/data/model/categoriesmodel.dart';
import 'package:ecommerce/features/home/data/model/productmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriesRepository {
  final String baseUrl = 'https://student.valuxapps.com/api';

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories?page=1'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> jsonCategories = data['data']['data'];

      return jsonCategories.map((json) {
        String englishName = _translateToEnglish(json['name']);
        return Category.fromJson(
            {'name': englishName, 'image': json['image'], 'id': json['id']});
      }).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<ProductModel>> fetchCategoriesProduct(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/categories/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> jsonCategoriesproduct = data['data']['data'];

      return jsonCategoriesproduct.map((json) {
        String englishName = _translateToEnglish(json['name']);
        return ProductModel.fromJson({
          'id': json['id'],
          'name': englishName,
          'image': json['image'],
          'price': json['price'],
          'old_price': json['old_price'],
          'description': json['description'],
          'images': json['images'],
        });
      }).toList();
    } else {
      throw Exception('Failed to load categories product');
    }
  }

  String _translateToEnglish(String arabicText) {
    const translations = {
      'اجهزه الكترونيه': 'Electronic Devices',
      'مكافحة كورونا': 'COVID-19 Prevention',
      'رياضة': 'Sports',
      'ادوات الاناره': 'Lighting Tools',
      'ملابس': 'Clothing',
      'ابل ايفون 12 برو ماكس - 256جيجابيت, ازرق':
          'Apple iPhone 12 Pro Max - 256GB, Blue',
      'لاب توب ابل ماك بوك برو': 'Apple MacBook Pro laptop',
      'مكبر صوت بلوتوث مقاوم للمياه ومحمول اكستريم 2 من جيه بي ال JBLXTREME2BLUAM - ازرق':
          'JBL JBLXTREME2BLUAM Waterproof Portable Bluetooth Speaker Extreme 2 - Blue',
      'تليفزيون سمارت 65 بوصة 4K الترا اتش دي منحني من سامسونج UA65RU7300RXUM':
          'Samsung 65-inch 4K Ultra HD Curved Smart TV UA65RU7300RXUM',
      'نيكون FX-format D750 - 24.3 ميجابيكسيل,كاميرا اس ال ار , عدسه 24-120 ملم, اسود':
          'Nikon FX-format D750 - 24.3 MP, SLR camera, 24-120 mm lens, black',
      'هارد اس اس دي داخلي 240 جيجابايت A400 ساتا 3 من كينجستون - 2.5 بوصة - SA400S37/240G':
          'Kingston 240GB A400 SATA 3 Internal SSD - 2.5 inch - SA400S37/240G',
      'أداة تمرين حديد كيتل بيل من ستارك، 24 كجم': 'Stark Kettlebell, 24 kg',
      'كمامة لحماية الوجه، 50 قطعة - ازرق فاتح بأستك و دعامة':
          'Face protection mask, 50 pieces - light blue with elastic band and backing',
      'موبايل شاومي ريدمي 10 بشريحتي اتصال - 6.53 بوصة فل اتش دي ، 64 جيجا ، 4 جيجا رام ، شبكة الجيل الرابع ال تي اي - رمادي كربوني':
          'Xiaomi Redmi 10 dual SIM mobile phone - 6.53 inches FHD, 64 GB, 4 GB RAM, 4G LTE network - Carbon Gray',
      'حذاء رياضي للتمرين شبكي للنساء فليكس اسينشيال من نايكي - ابيض':
          'Nike Flex Essential Mesh Training Shoes for Women - White',
      'تي شيرت رجالي من Nike NSW Icon Futura, أسود (أسود/أبيض010)، مقاس متوسط':
          'Nike Men\'s NSW Icon Futura T-Shirt, Black (Black/White 010), Medium',
      'كمامة طبية بحلقات اذن ناعمة ومرنة من ايفوني، 50 قطعة':
          'Medical mask with soft and flexible ear loops from Evony, 50 pieces',
      'سوار شاومي مي الذكي 5 - اسود': 'Xiaomi Mi Smart Band 5 - Black',
      'حلقة اضاءة دائرية للبث المباشر والتصوير الاحترافي M-33 مع استدارة 360 درجة 33 سم مع حامل موبايل وحامل ثلاثي 2.1 متر - ابيض و اسود':
          'M-33 circular lighting ring for live broadcasting and professional photography with 360-degree rotation, 33 cm, with mobile holder and tripod stand, 2.1 meters - white and black',
      'بلوفر شتوي بياقة عالية - جملي': 'High collar winter pullover - camel',
      'سماعات العاب لاسلكية لبلاي ستيشن 5 Pulse 3D من سوني':
          'Sony PlayStation 5 Pulse 3D wireless gaming headphones',
      'سماعات رأس لاسلكية من سوني WI-C200 - اسود':
          'Sony WI-C200 Wireless Headphones - Black',
      'ضوء ليلي من شاومي مع مستشعر حركي وقاعدة مغناطسية - ابيض':
          'Xiaomi night light with motion sensor and magnetic base - white',
      'قميص بأكمام طويلة وجيب برقعة - زيتوني غامق':
          'Long sleeve shirt with patch pocket - dark olive',
      'جاكيت رجالي بياقة كولاج بلون موحد':
          'Men\'s solid color collage collar jacket',
    };
    return translations[arabicText] ?? arabicText;
  }
}
