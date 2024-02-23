# bitbucket pipelines pipe: tag validator

This is a Bitbucket pipe to validate that a pipeline is running on a given branch that has a tag. 

## overview

A pipeline can be triggered by either a branch or a tag, but not both. This pipe works around this limitation by letting you target a specific branch that has a tag.

## yaml definition

```yaml
script:
  - pipe: docker://baizmandesign/tag-validator:latest
    variables:
      TARGET_BRANCH: "<string>"
```

Place this pipe at the top of your pipeline. If it fails, the execution of the pipeline will stop.

## variables

There is one required variable, `TARGET_BRANCH`. This is the name of the branch on which the pipeline is allowed to run.

## drawbacks

The pipe has several drawbacks:

+ The pipeline must be configured to run on every commit or be triggered to run on a specific branch or branch pattern.
+ The pipeline will always run or always run on the given branch (unless you include "[skip ci]" or "[ci skip]" in the commit message). This means it's eating up build minutes even if it doesn't complete the build process due to a validation error, such as the absence of a tag on the HEAD commit.
+ If the pipe detects that it's running on the wrong branch or that a tag does not exist on the HEAD commit, the pipeline fails and triggers an email notification. This may be undesirable.

## to do

+ Include a tag name or tag name pattern to target the pipeline execution conditions more precisely. 
