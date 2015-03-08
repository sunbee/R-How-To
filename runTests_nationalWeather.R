library('RUnit');

dirName <- "C:/Users/ssbhat3/Desktop/Org Docs/MonResCen/R HOW TO/";
masterName <- "nationalWeather.R"
master <- paste0(dirName, masterName)
source(master);

test.suite <- defineTestSuite("testing 1-2-3", 
                              "C:/Users/ssbhat3/Desktop/Org Docs/MonResCen/R HOW TO/tests_nationalWeather", 
                              testFileRegexp = '^\\d+\\.R');
test.result <- runTestSuite(test.suite);
printTextProtocol(test.result);
