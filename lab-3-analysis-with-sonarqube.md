# Avanade DevOps HOL - Lab 3 - Analysis with SonarQube

In this lab, we enable SonarQube for analysis of our code.

Based on [this](https://docs.sonarqube.org/display/SCAN/Analyzing+with+SonarQube+Extension+for+VSTS-TFS) tutorial.

## Prerequisites

- Complete [Lab 2 - Define your multi-stage continuous deployment process with approvals and gates](lab-2-multi-stage-deployments.md).

## Tasks

1. Go to your SonarQube site and start the tutorial for creating a new project. Make sure you save the Project Key somewhere safe for later use in VSTS

1. Edit your build definition and add task "Prepare analysis on SonarQube" before any Msbuild or VSBuild task
   - Install SonarQube extension from marketplace if the task is not yet available on your VSTS account
   - Enter the Project Key and make up a name for your Project

1. Let the SonarQube scanner use the following additional properties:
   - sonar.exclusions=wwwroot/lib/**
   - d:sonar.login="\<your token\>"

1. Add task "Run Code Analysis" and "Publish Analysis Results" to your build

1. Reorder the tasks to respect the following order:
   - Prepare Analysis Configuration task before any MSBuild or Visual Studio Build task
   - Run Code Analysis task after the Visual Studio Test task
   - Publish Analysis Result task after the Run Code Analysis task

1. Save the build, do not queue it. Now edit your Web Application csproj file and add a ProjectGuid. Commit this change to queue the next build. (The dotnet build task will come up with the following warning: The project does not have a valid ProjectGuid. Analysis results for this project will not be uploaded to SonarQube)
   - <details><summary>Click here for an example</summary>

        ```xml
        <PropertyGroup>
            <TargetFramework>netcoreapp2.0</TargetFramework>
            <ProjectGuid>c1182fc3-8c56-4d10-b550-965843e9e9b4</ProjectGuid>
        </PropertyGroup>
        ```
     </details>

1. When the build passes, view the detailed SonarQube report

## Next steps

Continue with [Lab 4 - Feature Toggle](lab-4-feature-toggle.md).