// const bool isProduction = bool.fromEnvironment('dart.vm.product');
const bool isProduction = false;

const testConfig = {"online": false, "data_url": "http://localhost:8888"};

const productionConfig = {
  "online": true,
  "data_url": "http://localhost:8888",
};

final environment = isProduction ? productionConfig : testConfig;
