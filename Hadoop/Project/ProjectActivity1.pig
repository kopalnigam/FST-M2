-- Load all input files from HDFS
inputFile = LOAD 'hdfs:///user/kopal/project' USING PigStorage('\t') AS (Name:chararray,Dialogue:chararray);

-- Group by Name [Map]
grpd = GROUP inputFile BY Name;

-- Count the total words [Reduce]
totalCount = FOREACH grpd GENERATE $0 as Character, COUNT($1) as DialogueCount;

-- Sort by number of lines
finalCount = ORDER totalCount BY DialogueCount DESC

-- Store the result in HDFS
STORE cntd INTO 'hdfs:///user/kopal/project/PigOutput';