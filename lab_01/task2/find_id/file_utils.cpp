#include "stdafx.h"
#include "file_utils.h"

std::ifstream OpenFileForReading(const std::string &fileName)
{
    std::ifstream file(fileName);
    if (!file)
    {
        throw std::runtime_error("failed to open " + fileName);
    }
    return std::move(file);
}
