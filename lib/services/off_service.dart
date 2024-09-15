import 'package:defood/models/errors/base/app_error.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class OpenFoodFactsService {
  OpenFoodFactsService() {
    OpenFoodAPIConfiguration.userAgent = UserAgent(
      name: 'DeFood',
      url: 'https://github.com/Sinneida/defood/',
    );

    OpenFoodAPIConfiguration.globalLanguages = <OpenFoodFactsLanguage>[
      OpenFoodFactsLanguage.ENGLISH
    ];

    OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.POLAND;
  }

  Future<Product> getProductData(String barcode) async {
    final config = ProductQueryConfiguration(
      barcode,
      version: ProductQueryVersion.v3,
    );
    final product = await OpenFoodAPIClient.getProductV3(config);
    if (product.product == null) {
      throw AppError('Failed to download product data');
    }
    return product.product!;
    // print(product.product?.productName); // Coca Cola Zero
    // print(product.product?.brands); // Coca-Cola
    // print(product.product?.quantity); // 330ml
    // print(product.product?.nutriments
    //     ?.getValue(Nutrient.salt, PerSize.oneHundredGrams)); // 0.0212
    // print(product.product?.additives?.names); // [E150d, E338, E950, E951]
    // print(product.product?.allergens?.names); // []
  }
}
