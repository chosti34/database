#include "stdafx.h"
#include "file_utils.h"
#include "database.h"

void HandleCommand(const Database &database, const std::string &author)
{
    unsigned amount = database.count(author);

    if (amount > 0)
    {
        std::cout << "Record id: ";
        auto range = database.equal_range(author);
        for (auto it = range.first; it != range.second; ++it)
        {
            std::cout << it->second.id << " ";
        }
        std::cout << "\n";
    }
    else
    {
        std::cout << "Not found\n";
    }
}

void EnterApplicationMainLoop(const Database &database)
{
    std::string buffer;
    while ((std::cout << "Enter username: ") && (std::getline(std::cin, buffer)))
    {
        if (buffer == "...")
        {
            std::cout << "Good bye!" << std::endl;
            break;
        }
        else
        {
            HandleCommand(database, buffer);
        }
    }
}

void ExecuteApplication()
{
    std::ifstream input = OpenFileForReading("data.csv");
    Database database;

    ReadFileToDatabase(input, database);
    EnterApplicationMainLoop(database);
}

int main()
{
    try
    {
        ExecuteApplication();
    }
    catch (const std::exception &ex)
    {
        std::cerr << ex.what() << std::endl;
        return 1;
    }

    return 0;
}
