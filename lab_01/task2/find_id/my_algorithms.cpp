#include "stdafx.h"
#include "my_algorithms.h"

enum class ParserState
{
    Quotes,
    Normal
};

void SwitchParserState(ParserState &state)
{
    switch (state)
    {
    case ParserState::Quotes:
        state = ParserState::Normal;
        break;
    case ParserState::Normal:
        state = ParserState::Quotes;
        break;
    }
}

bool Contains(const std::string &str, char element)
{
    return std::any_of(str.begin(), str.end(), [&](char ch) {
        return (element == ch);
    });
}

std::vector<std::string> SplitString(const std::string &str, const std::string &delim, bool processQuotes)
{
    std::vector<std::string> result;
    std::string buffer;
    ParserState state = ParserState::Normal;

    for (std::size_t i = 0; i < str.size(); ++i)
    {
        if ((processQuotes) && (str[i] == '\"'))
        {
            SwitchParserState(state);
            continue;
        }

        if (!Contains(delim, str[i]))
        {
            buffer += str[i];
            if (i == str.size() - 1)
            {
                result.push_back(buffer);
                buffer.clear();
            }
        }
        else if ((state == ParserState::Normal) && (!buffer.empty()))
        {
            result.push_back(buffer);
            buffer.clear();
        }
    }

    return result;
}
