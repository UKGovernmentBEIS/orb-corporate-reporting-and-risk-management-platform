# ORB.Services.Tests

## Generate coverage reports

` dotnet test --collect:"XPlat Code Coverage"
` dotnet tool install --tool-path . dotnet-reportgenerator-globaltool
` ./reportgenerator -reports:./**/coverage.cobertura.xml -targetdir:./coverlet/reports -reporttypes:"Html"
