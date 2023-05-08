using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace ORB.Data
{
    // https://docs.microsoft.com/en-us/dotnet/standard/serialization/system-text-json-converters-how-to?pivots=dotnet-5-0#converter-samples-for-common-scenarios
    public class ObjectToInferredTypesConverter : JsonConverter<object>
    {
        public override object Read(
            ref Utf8JsonReader reader,
            Type typeToConvert,
            JsonSerializerOptions options) => reader.TokenType switch
            {
                JsonTokenType.True => true,
                JsonTokenType.False => false,
                JsonTokenType.Number when reader.TryGetInt64(out long l) => l,
                JsonTokenType.Number => reader.GetDouble(),
                JsonTokenType.String when reader.TryGetDateTime(out DateTime datetime) => datetime,
                JsonTokenType.String => reader.GetString(),
                JsonTokenType.StartArray => ReadArray(JsonDocument.ParseValue(ref reader).RootElement.Clone()),
                _ => JsonDocument.ParseValue(ref reader).RootElement.Clone()
            };

        private static object ReadArray(JsonElement element)
        {
            using (var e = element.EnumerateArray())
            {
                if (e.All(el => el.ValueKind == JsonValueKind.Number))
                {
                    return element.ToObject<int[]>();
                }
                if (e.All(el => el.ValueKind == JsonValueKind.String))
                {
                    return element.ToObject<string[]>();
                }
            }

            throw new NotImplementedException("Array type not implemented");
        }

        public override void Write(
            Utf8JsonWriter writer,
            object objectToWrite,
            JsonSerializerOptions options) =>
            JsonSerializer.Serialize(writer, objectToWrite, objectToWrite.GetType(), options);
    }

    public static class JsonExtensions
    {
        public static T ToObject<T>(this JsonElement element)
        {
            var json = element.GetRawText();
            return JsonSerializer.Deserialize<T>(json);
        }
    }
}