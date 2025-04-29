$solutionName = Read-Host "Enter your Clean Architecture solution name"
## Create solution
dotnet new sln -o $solutionName
cd $solutionName

# Add class libraries
dotnet new classlib -o src/$solutionName.Core
dotnet new classlib -o src/$solutionName.UseCases
dotnet new classlib -o src/$solutionName.Infrastructure

# Add API Web
dotnet new web -o src/$solutionName.Web

# Add test projects
dotnet new xunit -o tests/$solutionName.UnitTests
dotnet new xunit -o tests/$solutionName.IntegrationTests
dotnet new xunit -o tests/$solutionName.FunctionalTests

# Add projects to solution
dotnet sln add (ls -r **/*.csproj)

# Add references for class libraries and web
dotnet add src/$solutionName.UseCases reference src/$solutionName.Core
dotnet add src/$solutionName.Infrastructure reference src/$solutionName.Core
dotnet add src/$solutionName.Infrastructure reference src/$solutionName.UseCases
dotnet add src/$solutionName.Web reference src/$solutionName.UseCases
dotnet add src/$solutionName.Web reference src/$solutionName.Infrastructure

# Add references for tests
dotnet add tests/$solutionName.UnitTests reference src/$solutionName.Core
dotnet add tests/$solutionName.UnitTests reference src/$solutionName.UseCases
dotnet add tests/$solutionName.IntegrationTests reference src/$solutionName.Infrastructure
dotnet add tests/$solutionName.FunctionalTests reference src/$solutionName.Web
dotnet add tests/$solutionName.FunctionalTests reference src/$solutionName.UseCases
dotnet add tests/$solutionName.FunctionalTests reference src/$solutionName.Infrastructure