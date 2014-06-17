#Ad Predictor
This application imports CSVs which contain information about app ad impressions. A user can input parameters and receive a recommendation for the best ad to show based on past data.

###How to Use
1. Clone repository in terminal 'git clone https://github.com/bmprovost/ad_predictor.git'.
2. Run 'bundle install' to install dependencies.
3. To load the terminal client, in IRB, "load 'terminal.rb'" Instructions are provided in the client.

Sample CSVs are in the /data directory. 'import ./data/training.csv' will import the largest file, which will take around 30 seconds.

###Application
Each impression is stored as an [Impression entity](./lib/ad_predictor/entities/impression.rb). When these entities are created they are stored in a SQLite database via the ActiveRecord ORM.

Database interaction is handled in the [AdPredictor::Database::ORM](./lib/ad_predictor/database/ORM.rb) class. This separates persistence from the business logic to allow easy substitution of databases or ORMs.

Business logic is handled as Use Cases. There are three: [GetAd](./lib/ad_predictor/use_cases/get_ad.rb), [GetClickthrough](./lib/ad_predictor/use_cases/get_clickthrough.rb), and [ImportCSV](./lib/ad_predictor/use_cases/import_csv.rb). These are called from the terminal client but could just as easily be called from another interface.

Tests are in the [/spec](./spec) folder. To run the tests, type 'rspec' in your terminal from the root directory after 'bundle install'ing.

###Improvements
* Rather than basing ad suggestions on clickthrough rate, we could (and probably should) base the suggestion on expected value of showing an ad. As an extreme example, an ad in Australia for Clash of Clans could pay $8 per install, have a 50% clickthrough and a 50% install rate for an expected value of $2. Another ad could still pay $8 per install, have a 100% clickthrough but only a 10% install rate and be worth $0.80. This could be implemented with a separate database table "Ads" which contains $/install and install rate for each ad (although those could vary based on region, platform, etc.) The GetAd Use Case would then take that information into account when choosing the ad.
* GetAd does not currently work well for small sample sizes. It returns nil when it can't find any matches for the input parameters. One way we could deal with this is to remove the params least correlated with expected value one by one until we have a sufficient sample, then return an ad. If the params are very obscure and end up matching up with nothing, we will just return the ad with the highest expected value.
* GetAd always returns the ad with the calculated highest value, which does not allow for test data that may change future predictions. We could return the highest calculated value some percentage of the time and return a test ad with a small sample size some percent of the time. The test percentage could be specified or scale based on size of sample.