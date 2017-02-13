#pragma once

#include <vector>
#include <string>
#include <algorithm>

bool Contains(const std::string &str, char element);

std::vector<std::string> SplitString(const std::string &str, const std::string &delim = " ", bool processQuotes = false);
