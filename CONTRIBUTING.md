# Contributing

First of all, we appreciate you considering contributing to the dahliaOS project!

To make sure your contributions go as smooth as possible, here are all the things you need to know.

## Table of contents

- [Code of Conduct](#code-of-conduct)
- [How can I contribute?](#how-can-i-contribute)
  - [Reporting bugs](#reporting-bugs)
    - [Before submitting a bug report](#before-submitting-a-bug-report)
    - [How do I write a good bug report?](#how-do-i-write-a-good-bug-report)
    - [How do I submit a bug report?](#how-do-i-submit-a-bug-report)
  - [Feature request](#feature-request)
    - [Before submitting a feature request](#before-submitting-a-feature-request)
    - [How do I submit a feature request?](#how-do-i-submit-a-feature-request)
  - [Translations](#translations)
    - [Before making a translation](#before-making-a-translation)
    - [How to translate](#how-to-translate)
  - [Code contributions](#code-contributions)
    - [First code contribution](#first-code-contribution)
  - [Design contributions](#design-contributions)
- [Pull requests](#pull-requests)
  - [How to make a proper pull request](#how-to-make-a-proper-pull-request)
  - [What do I do after I submitted a PR?](#what-do-i-do-after-i-submitted-a-pr)
- [License](#license)

## Code of Conduct

- dahliaOS' Code of Conduct can be found [here](CODE_OF_CONDUCT.md).

- This project and everyone participating in it is governed by dahliaOS' Code of Conduct and no one is exempt.

- By participating, you are expected to respect and value this code. 

- If you notice any unacceptable behaviour, you can report it to integrity@dahliaos.io

## How can I contribute?

Here we've explained how you can contribute to our project on GitHub but there are also many other ways to help us outside of GitHub, if you'd like to find even more ways to help us, you're always free to join our Discord and ask our team.

You can contribute to the project by:

* Reporting a bug.
* Proposing new features.
* Translating to your native language.
* Submitting a fix.
* Discussing the current state of code.
* Becoming a maintainer.

**Some repositories also have Projects which contain either a to-do list or a roadmap**

## Reporting bugs

If you've experienced a bug and you'd like to report it, we highly recommend that you read [Before submitting a bug report](#before-submitting-a-bug-report), [How do I write a good bug report?](#how-do-i-write-a-good-bug-report) and that you use our issue template.

There are 2 ways you can report a bug, either in our Discord server by opening a ticket or by creating an issue on GitHub.

### Before submitting a bug report

Before submitting a bug report, there are a few things you need to take in consideration:

* Do a bit of research and check if a similar bug has already been reported.
  * If it has been reported already, add a comment to the existing one instead of submitting a new one.

### How do I write a good bug report?

We have a few short tips for you on how to properly write a bug report so the developers can understand it better:

* **Use a clear and descriptive title for the issue.**
* **Describe the steps to reproduce the bug.**
* **Describe what behaviour you observed after the bug occured.**
* **Explain what behaviour you expected to see instead and why.**
* **If the problem wasn't triggered by a specific action, describe what you were doing before it happened.**
* **Include screnshots of the bug.**
* **Write what version of dahliaOS you were using.**

And the most important of all, make sure to fulfill all fields in our bug report template.

### How do I submit a bug report?

* **GitHub**:
  1. Go to the Issues section
  2. Click **New issue**
  3. Select the **Bug report** template
  4. Fill in the fields
* **Discord**:
  1. Go to the #bug-report channel
  2. Open a ticket and copy the form
  3. Paste and fill in the form

## Feature request

If you'd like to see something added to our OS, we highly recommend you read [Before submitting a feature request](#before-submitting-a-feature-request), [How do I submit a feature request?](#how-do-i-submit-a-feature-request) and use our feature request template.

There are 2 ways you can submit a feature request, either by make a suggestion in our Discord server or by creating an issue with the feature request template on GitHub.

### Before submitting a feature request

Before submitting a feature request, here are a few things you need to know:

* **Make sure the feature isn't already added.**
* **Don't hesitate to express your knowledge.**
* **Write a clear and descriptive title for the request.**
* **Explain how the project could benefit of your request.**

### How do I submit a feature request?

* **GitHub**:
  1. Go to the Issues section
  2. Click **New issue**
  3. Select the **Feature request** template
  4. Fill in the fields
* **Discord**:
  1. Go to the #bot-commands channel
  2. Type !suggestion [suggestion]

## Translations

- We aim to provide our software in as many languages as possible so everyone could experience it in their own native language.

- For submitting translations, we use Crowdin so please do not edit the files found in the repositories.

- If you're interesting in translating our project, click [this link](https://translate.dahliaos.io)

- If your language is not added, let us know and we'll add it.

### Before making a translation

Before making a translation, please make sure that:

* **You're fluent in the language you're translating to.**
* **You pay close attention to its grammar.**
* **You read the context (comments) some strings have.**
* **You used the same punctuation as the source strings.**

### How to translate

1. Make a Crowdin account (if you already don't have one)
2. Join our workspace
3. Pick a project to translate (Pangolin, one of the applications etc.)
4. Apply translations to the available strings

## Code contributions

To make sure that the code you want to contribute is up to our standards, here we've written a few do's and don'ts:

**Do's:**

* Choose expressive variable, function and class names, make it as obvious as possible of what the code is doing.
* The first line of the commit message should have the format "Category: Brief description of what's being changed". The "category" can be a subdirectory, but also something like "POSIX compliance" or "ClassName".
* Split your changes into separate commits.
* Write your commit messages in proper English, with care and punctuation.

**Don'ts:**

* Submit code that's incompatible with the project licence (Apache 2.0).
* Touch anything outside the stated scope of the PR.
* Use weasel-words like "refactor" or "fix" to avoid explaining what's being changed.
* Include commented-out code.

### First code contribution

If you're new to the project, you can look at repositories' issues section and the issues labeled with the "good first issue" label are perfect for your first code contribution.

## Design contributions

Apart from code contributions, we also accept any kind of design contributions.

**Here are a few repos where you can contribute designs**:

* [Wallpapers](https://github.com/dahliaos/wallpapers)
  * Here you can contribute your own wallpapers, make sure to read the instructions.
* [Icons](https://github.com/dahliaos/icons)
  * Here you can contribute either modified version of existing icons or new ones.
* [Brand](https://github.com/dahliaos/brand)
  * Here you can contribute new logos or modified current one for our project.

We also love seeing UI concepts and such designs, you can share any kind of designs in our Discord server.

## Pull requests

PRs to our repositories are always welcome and can be a quick way to get your fix or improvement slated for the next release. In general, PRs should:

* Fix an existing issue **OR** add a new feature.
* Be accompanied by a complete pull request template (loaded automatically when a PR is created).

For changes that address core functionality or would require breaking changes (e.g. a major release), it's best to open an issue to discuss your proposal first. This is not required but can save time creating and reviewing changes.

### How to make a proper pull request

1. Fork the repository to your own GitHub account
2. Clone the project to your machine
3. Make your changes
4. Push changes to your fork
5. Open a PR in our repository and follow the PR template so that we can efficiently review the changes

### What do I do after I submitted a PR?

We kindly ask everyone who has submitted a pull request to be patient and that's really all, we notice every singe new pull request so don't worry about it being ignored.

## License

By contributing, you agree that your contributions will be licensed under the [Apache 2.0](LICENSE) license
