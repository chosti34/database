#pragma once

struct Record
{
    unsigned id;
    std::string filePath;
    std::string description;
    std::string date;
    std::string author;
    std::string platform;
    std::string type;
    int port;
};

typedef std::multimap<std::string, Record> Database;

void ReadFileToDatabase(std::ifstream &file, Database &database);
