In Cloud 9’s terminal, cd into the sheql-start folder.

Type the following commands into terminal.

```
$ git remote add upstream https://github.com/Gmfholley/sheql-start.git
$ git fetch upstream
$ git merge upstream/master
```

This will:
1. add a connection between your forked repo and the original repo
1. fetch the original repo
1. merge it with your repo

Cool, huh!