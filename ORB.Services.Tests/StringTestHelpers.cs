using System;
using System.Linq;

namespace ORB.Services.Tests
{
    public static class StringTestHelpers
    {
        public static string GenerateStringOfLength(int length = 10)
        {
            return new string(Enumerable.Repeat('a', length).ToArray());
        }
    }
}