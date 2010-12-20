# engage

engage is a helper command to setup an already existent ruby(or rails) app on your current environment. It expects that you use [rvm](http://rvm.beginrescueend.com/) and [git](http://git-scm.com/) - [bundler](http://gembundler.com/) is supported but not required.

### What?

Some common steps to start working on a project (in your company or a open source one) is:

* Clone it's git repository;
* Create a new gemset to isolate the project dependencies;
* Let bundler install all the needed gems.

Engage aims to provide a single command to run all those tasks. All you need to do is provide the project's name and it's git server.

### Usage
First, you can set your common git servers - the default list include only `git@github.com`.
    engage --sources git@git.acme.com

After that you can engage on a project by just running:

    engage some_project

Behind the curtains, engage will: 

* Prompt the git server to use - either "github.com" or "acme.com";
* Clone the some_project repository form the chosen server - `git@git.acme.com/some_project.git`;
* Creates a gemset name `some_project` and a .rvmrc file;
* Install gems based on project's `Gemfile`, if needed.