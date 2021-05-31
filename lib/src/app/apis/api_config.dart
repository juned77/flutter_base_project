//API Base URL's
const String BASE_URL = BASE_URL_LIVE;

const String BASE_URL_DEMO = 'https://beta-api.aimseteshopee.com';
const String BASE_URL_LIVE = 'https://api.aimseteshopee.com';
//Apis
String kCategoryList = '/api/product/category_list';
String kDashboardApi = '/api/dashboard/v2';
String kProductsList = '/api/product/list';
String kProductDetails = '/api/product/detail/';
String kGetCartDetails = '/api/cart/?user_id=';
String kRemoveItemFromCart = '/api/cart/?user_id=';
String kUpdatePickupType = '/api/cart/updatePickupType?user_id=';
String kAddToCart = '/api/cart/';
String kUpdateCartItem = '/api/cart/';
String kGetAddressFromPinCode = '/api/location/getPickupPoint?pincode=';
String kCreateOrder = '/api/razorpay/createOrder/?user_id=';
String kProductBrand = '/api/common/product_brand';
String kOrdersList = '/api/order/list';
String kCancelOrder = '/api/order/cancelOrder';
String kAddToFavorite = '/api/product/addToFavorite';
String kOrderDetails = '/api/order/detail/';
String kFavoriteProductList = '/api/product/favoriteProductList?user_id=';
String kGetStates = '/api/common/get_states';
String kGetCitiesByState = '/api/common/get_cities_by_state';
String kCreateAddress = '/api/user/address/create';
String kUpdateAddress = '/api/user/address/update';
String kDeleteAddress = '/api/user/address/delete';
String kAddressList = '/api/user/address/list';
String kUploadImage = '/api/upload/uploadImage';
String kConfirmOrder = '/api/user/confirmOrder';
