#include "stdafx.h"
#include "database.h"
#include "my_algorithms.h"

Record GetRecordByParsedString(const std::vector<std::string> &parsedString)
{
    Record record;

    record.id = std::stoi(parsedString[0]);
    record.filePath = parsedString[1];
    record.description = parsedString[2];
    record.date = parsedString[3];
    record.author = parsedString[4];
    record.platform = parsedString[5];
    record.type = parsedString[6];
    record.port = std::stoi(parsedString[7]);

    return record;
}

void ReadFileToDatabase(std::ifstream &file, Database &database)
{
    std::string buffer;
    std::getline(file, buffer); // skip first line

    while (std::getline(file, buffer))
    {
        std::vector<std::string> parsedString = SplitString(buffer, ",", true);
        Record record = GetRecordByParsedString(parsedString);
        database.insert(std::make_pair(parsedString[4], record));
    }
}
