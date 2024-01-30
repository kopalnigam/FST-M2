-- Load the input file from HDFS
inputFile = LOAD 'hdfs:///user/kopal/input.txt' AS (line:chararray);
-- Tokenize the lines in the file
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
-- Group words by word [MAP]
grpd = GROUP words BY word;
-- Count the total number of words [REDUCE]
totalCount = FOREACH grpd GENERATE $0, COUNT($1);

-- Delete the output folder
rmf hdfs:///user/kopal/PigOutput;
-- Store the output
STORE totalCount INTO 'hdfs:///user/kopal/PigOutput';
