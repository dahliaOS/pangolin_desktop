# Contributing

dahliaOS is open to contributions. Any contribution is appreciated, whether it is a documentation update, localization, bug fix or a new feature. Anyone can contribute as long as they follow this guideline and obey the dahliaOS Code of Conduct.
To make sure your contributions go as smooth as possible, here are all the things you need to know.

## Table of contents

1. **[Communication](#communication)**
1. **[Code of Conduct](#code-of-conduct)**
1. **[Contribute](#contribute)**
    1. [Bug report](#bug-report)
        1. [Before submitting a bug report](#before-submitting-a-bug-report)
        1. [Writing a good bug report](#writing-a-good-bug-report)
        1. [Submitting a bug report](#submitting-a-bug-report)
    1. [Feature request](#feature-request)
        1. [Before submitting a feature request](#before-submitting-a-feature-request)
        1. [Submitting a feature request](#submitting-a-feature-request)
    1. [Pull request](#pull-request)
        1. [Before submitting a pull request](#before-submitting-a-pull-request)
        1. [How to submit a proper pull request](#how-to-submit-a-proper-pull-request)
        1. [After submitting a pull request](#after-submitting-a-pull-request)
    1. [Translations](#translations)
        1. [Before making a translation](#before-making-a-translation)
        1. [How to translate](#how-to-translate)
    1. [Code contributions](#code-contributions)
        1. [First code contribution](#first-code-contribution)
    1. [Design contributions](#design-contributions)
    1. [Financial contributions](#financial-contributions)
    1. [Finding tasks](#finding-tasks)
1. **[License](#license)**

## Communication

Communication with core dahliaOS development team is crucial for any successful participation in dahliaOS development. There are several methods to communicate with the core team:

* [Discord](https://dahliaos.io/discord) - We use Discord for pinging people, sharing updates, quick and informal discussions, questions and answers, etc. It is OK to discuss your contribution, planned contribution, development idea, localization, documentation updates and similar topics in this server. Anyone interested in the project is welcome to join our Discord server and hang around.
* [Telegram](https://dahliaos.io/telegram) - Same as Discord.
* [Issues / pull requests](https://github.com/dahliaOS) - Most of the work is discussed here, including upgrades and proposals for upgrades, bug fixing and feature requests. For any of these, open an issue in the corresponding repository. If you are proposing code change, open a pull request.

Each of them is intended for an specific purpose. Please understand that you may be redirected to some other mean if the communication you intend to have is considered to fit better elsewhere.

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct and no one is exempt.
By participating, you are expected to respect and value this code.
dahliaOS Code of Conduct can be found [here](CODE_OF_CONDUCT.md).
If you notice any unacceptable behaviour, we encourage you to report it to integrity@dahliaos.io

## Contribute

In this document we've explained how you can contribute to our project, if you'd like to help out in a different way that is not documented here, you're always free to join our Discord and discuss other options you have in mind with our team.

You can contribute to the project by:

* Reporting a bug.
* Proposing new features.
* Translating to your native language.
* Submitting a fix.
* Discussing the current state of code.
* Becoming a maintainer.
* Making a financial contribution.

### Bug report

If you've experienced a bug and you'd like to report it, we highly recommend that you read [Before submitting a bug report](#before-submitting-a-bug-report) and [Writing a good bug report](#writing-a-good-bug-report) first, and that you also use our issue template.

There are 2 ways you can report a bug, either in our Discord server by **opening a ticket** or by **creating an issue** using the **bug report template** on GitHub.

#### Before submitting a bug report

Before submitting a bug report, there are a few things you need to take in consideration:

* Do a bit of research and check if a similar bug has already been reported.
  * If it has been reported already, add a comment to the existing one instead of submitting a new one.

#### Writing a good bug report

We have a few short tips for you on how to properly write a bug report so the developers can understand it better:

* Use a clear and descriptive title for the issue.
* Describe the steps to reproduce the bug.
* Describe what behaviour you observed after the bug occurred.
* Explain what behaviour you expected to see instead and why.
* If the problem wasn't triggered by a specific action, describe what you were doing before it happened.
* Include screenshots of the bug.
* Write what version of dahliaOS you were using.

And the most important of all make sure to fill in as many fields as possible in our bug report template.

#### Submitting a bug report

* **GitHub**:
    1. Click the **Issues** tab
    1. Click **New issue**
    1. Select the **Bug report** template
    1. Fill in the fields
* **Discord**:
    1. Go to the **#bug-report** channel
    1. Open a **ticket** and copy the **form**
    1. Paste and fill in the form

### Feature request

If you'd like to see something added to dahliaOS, we highly recommend that you read [Before submitting a feature request](#before-submitting-a-feature-request) and [Submitting a feature request](#submitting-a-feature-request) first, and that you also use our feature request template.

To submit a feature request, **create an issue** using the **feature request template** on GitHub.

#### Before submitting a feature request

Before submitting a feature request, here are a few things you need to know:

* Make sure the feature isn't already added.
* Don't hesitate to express your knowledge.
* Write a clear and descriptive title for the request.
* Explain how the project could benefit of your request.

#### Submitting a feature request

* **GitHub**:
    1. Click the **Issues** tab
    1. Click **New issue**
    1. Select the **Feature request** template
    1. Fill in the fields

### Pull request

Pull requests to our repositories are always welcome and can be a quick way to get your fix or improvement slated for the next release. In general, pull requests should:

* Fix an existing issue or add a new feature.
* Be accompanied by a complete pull request template (loaded automatically when a pull request is created).

For changes that address core functionality or would require breaking changes (e.g. a major release), it's best to open an issue to discuss your proposal first. This is not required but can save time creating and reviewing changes.

#### Before submitting a pull request

To make sure that the pull request you want to submit is up to our standards, we've written a few dos and don'ts:

**Dos**:

* Provide a meaningful commit message.
* The first line of the commit message should have the format "Category: Brief description of what's being changed". The "category" can be a subdirectory, but also something like "POSIX compliance" or "ClassName".
* Write your commit messages in proper English, with care and punctuation.
* Use the present tense ("Add feature" not "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit the first line to 72 characters or less
* You may want to create a topic branch for larger contributions.
* Split your changes into separate commits.

**Don'ts**:

* Touch anything outside the stated scope of the pull request.
* Use weasel-words like "refactor" or "fix" to avoid explaining what's being changed.

#### How to submit a proper pull request

1. **Fork** the repository to your own GitHub account
1. **Clone** the project to your machine
1. Make your **changes**
1. **Push** changes to your fork
1. **Open a pull request** in our repository and **fill** in the pull request template

#### After submitting a pull request

We kindly ask everyone who has submitted a pull request to be patient, we notice every new pull request so don't worry about it being ignored, we'll be on it as soon as possible.

### Translations

We aim to provide our software in as many languages as possible so everyone could experience it in their own native language.
For submitting translations, we use Crowdin so please do not edit the files found in the repositories.
If you're interesting in translating our project, click [here](https://translate.dahliaos.io).
**Note**: If the language you're looking to translate to is not added, let us know and we'll add it right away.

#### Before making a translation

Before making a translation, please make sure that:

* You're fluent in the language you're translating to.
* You pay close attention to grammar.
* You read the context (comments) some strings have.
* You used the same punctuation as the source strings.

#### How to translate

1. Create a **Crowdin** account (if you already don't have one)
1. Join our **workspace**
1. Pick a **project** to translate
1. Apply translations to the available strings

### Code contributions

To make sure that the code you want to contribute is up to our standards, we've written a few dos and don'ts:

**Dos**:

* Choose expressive variable, function and class names, make it as obvious as possible of what the code is doing.

**Don'ts**:

* Submit code that's incompatible with the project license (Apache 2.0).
* Include commented-out code.

#### First code contribution

If you're not yet familiar with the development of dahliaOS, you can tackle tasks labeled with the "good first issue" label on our GitHub as they are more suited for newcomers looking to gain some experience.

### Design contributions

Apart from code contributions, we also accept various kinds of design contributions.

Here are a few repositories where you can contribute designs:

* [wallpapers](https://github.com/dahliaos/wallpapers)
  * Contribute your own wallpapers made for dahliaOS.
* [icons](https://github.com/dahliaos/icons)
  * Contribute/propose new or modified icons for dahliaOS.
* [brand](https://github.com/dahliaos/brand)
  * Contribute/propose new or modified logos of our brand.
* [press-kit](https://github.com/dahliaos/press-kit)
  * Contribute mockups, screenshots, graphics, marketing material and such for dahliaOS.

We love seeing concepts and designs, feel free to share them with us on our social media!

### Financial contributions

dahliaOS is an Apache 2.0-licensed free open source project that financially relies mainly on donations.
Donations helps us pay the bills (web hosts, domains, software/hardware, etc.) to keep this project on its feet as long as possible.
If you're interested in sending a donation to dahliaOS, click [here](https://dahliaos.io/donate) to find out where you can do so. Another way you can find donation links is by clicking the Sponsors button in most of our GitHub repositories.

### Finding tasks

If you're interested in contributing to dahliaOS but don't know what you can assist us with, you can find available tasks by:

* Peeking at GitHub issues / projects
* Asking in our Discord or Telegram

## License

By contributing to dahliaOS, you agree that your contributions will be licensed under the [Apache 2.0](LICENSE) license.
