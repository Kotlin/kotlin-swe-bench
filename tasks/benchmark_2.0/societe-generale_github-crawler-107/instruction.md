Running a simple configuration to crawl a Github organisation seems to fail
## Summary

I am not able to run and test the github-crawler without showing me always the message:

`Factory method 'remoteGitHub' threw exception; nested exception is java.lang.NullPointerException: name`

## Type of Issue
It is a : 
 - [ ] bug
 - [ ] request
 - [X] question regarding the documentation


## Motivation
I really would like to test your github-crawler, but it seems that I am doing something wrong in the `application.yml` file.
For testing your application, I am trying to crawl the **python** organisation

(Later I would like to focus on specific repositories, so not directly on organisation, but for simplicity reasons I am asking right now for an organisation).

This is the `application.yml` conifugration file I am using:

```
crawler:
    
    source-control:    
        # since v2.0.0, we need to mention the source control type. defaults to GitHub, but other options are possible
        # as defined in https://github.com/societe-generale/github-crawler/blob/master/github-crawler-core/src/main/kotlin/com/societegenerale/githubcrawler/GithubConfig.kt
        type: "GITHUB"
        # the base GitHub URL for your Github enterprise instance to crawl
        # or if it's github.com...
        gitHub.url: https://api.github.com
        # url: https://my.githubEnterprise/api/v3
        apiToken: "YOUR_TOKEN"
        # the name of the GitHub organization to crawl. To fetch the repositories, the crawler will hit 
        # https://${gitHub.url}/api/v3/orgs/${organizationName}/repos
        organizationName: python
        # default is false - API URL is slightly different depending on whether you're crawling an organization (most common case) or a user's repositories
        crawlUsersRepoInsteadOfOrgasRepos: false
     
     
    #### From here is the same configuration as written in README.MD, but even without the default configuration below it also seems to fail

```

For creating the token, I generated a **Personal Access Token** as described here in the offical guide from GitHub:

https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

For testing I gave my Personal Access Token full-access, just to make sure it is not because of the given rights of the token itself.


For crawling itself I am using this version:
https://repo1.maven.org/maven2/com/societegenerale/github-crawler/github-crawler-starter/2.0.1/

And this is how I am running the jar file:
`java -jar github-crawler-starter-2.0.1-exec.jar --spring.config.location=./`



## Current Behavior

The current provided `application.yml` seems to be fine, since I am able to run the application, however if fails with this error message:

`org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'gitHubCrawlerApplication': Unsatisfied dependency expressed through field 'crawler'; nested exception is org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'crawler' defined in class path resource [com/societegenerale/githubcrawler/config/GitHubCrawlerAutoConfiguration.class]: Unsatisfied dependency expressed through method 'crawler' parameter 0; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'remoteGitHub' defined in class path resource [com/societegenerale/githubcrawler/config/GitHubConfiguration.class]: Bean instantiation via factory method failed; nested exception is org.springframework.beans.BeanInstantiationException: Failed to instantiate [com.societegenerale.githubcrawler.remote.RemoteSourceControl]: Factory method 'remoteGitHub' threw exception; nested exception is java.lang.NullPointerException: name`


## Expected Behavior

I am expecting that the github-crawler application is doing the crawler, but for right now it is not able to do it so.



I am definitely doing something wrong, but I cannot figure out what it is.
Could you please help me on that, since I cannot figure out from the documentation what else I am missing.

If you need more information, please do not hesitate to contact me!