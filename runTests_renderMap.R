library('RUnit');

dirName <- "C:/Users/ssbhat3/Desktop/R-HOW-TO/";
masterName <- "renderMap.R"
master <- paste0(dirName, masterName)
source(master);

test.suite <- defineTestSuite("testing 1-2-3", 
                              "C:/Users/ssbhat3/Desktop/R-HOW-TO/tests_renderMap", 
                              testFileRegexp = '^\\d+\\.R');
test.result <- runTestSuite(test.suite);
printTextProtocol(test.result);


