Remove-Item bin -Force -Recurse
Remove-Item obj -Force -Recurse
dotnet build-server shutdown
nuget locals global-packages -clear
Remove-Item ./refitter.msbuild -Recurse -Force
Remove-Item Refitter.MSBuild.*.nupkg -Force
Remove-Item Petstore.cs
dotnet restore ../../src/Refitter.sln
dotnet clean -c release ../../src/Refitter.sln
dotnet build -c release ../../src/Refitter/Refitter.csproj
dotnet build -c release ../../src/Refitter.MSBuild/Refitter.MSBuild.csproj
dotnet pack -c release ../../src/Refitter.MSBuild/Refitter.MSBuild.csproj -o .
nuget add .\Refitter.MSBuild.1.0.0.nupkg -source .
dotnet restore
dotnet add package Refitter.MSBuild -s .
dotnet build -v d -filelogger
dotnet remove package Refitter.MSBuild
Remove-Item Refitter.MSBuild.*.nupkg -Force