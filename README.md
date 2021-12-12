# Description

This repo can be used as a boilerplate for Python scripts running in AWS Lambda.

To run a Python script in a lambda function, we need:
- packages (saved in layers)
- the script (`lambda_function.py`)

We are using Python 3.8 for this project.

The packages that we will install here are:
- pillow
- psycopg2-binary

Those packages are only used as an example.
Please feel free to try other packages if you won't use them in your project.

# Structure

Structure of the project:
- /python (this folder contains Python packages)
- /venv (this folder contains our virtual environment)

# Prerequisites

## Manage multiple versions of Python

To manage multiple versions of Python, I use a combination of:
- pyenv
- and virtualenv

`pyenv` allows us to control the version we are running on a global level.

The only issue is that we need to create a specific environment for a particular project.
That's why we also need to:
1. first make sure we are running the correct version of Python (3.8 for example)
2. and then we would use virtualenv to create a new environment:
```
python -m venv ./venv
```
This will create a specific environment using Python 3.8.

We can activate this by typing in:
```
source venv/bin/activate
```
And to deactivate this environment, we can simply type in:
```
deactivate
```
Usually `pip` needs to be updated:
```
pip install --upgrade pip
```

## Install pillow

Let's create a `python` folder and `cd` in.
This is important to name it `python` since we need to follow a specific [structure](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html).
```
mkdir python
cd python
pip install pillow -t .
```

## Install psycopg2-binary

```
pip install psycopg2-binary -t .
```

## Save packages

Return in your root project folder:
```
cd ..
```
And type in:
```
pip freeze --path ./python > requirements.txt
```

## Install packages

We need to install packages a second time otherwise Python won't find them in `PATH`:
```
pip install -r requirements.txt
```

## Zip packages in `python` folder

Run the `zip_layer.sh` shell script.

Check content of the zip with:
```
unzip –l <filename>
```

## Install AWS CLI

[Installing or updating the latest version of the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

```
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"

sudo installer -pkg ./AWSCLIV2.pkg -target /Applications/
```

> #### This bit below didn't work. Instead we need to run `aws configure` with a new `id` and new `secret` from a new user created in IAM.
> 
> ---
> In your `.zshrc` (or `.bashrc`) file, add:
> ```
> export AWS_KEY_ID=<your_aws_key_id>
> export AWS_SECRET=<your_aws_secret>
> ```
> Then refresh `zsh` profile from the users home directory:
> ```
> source ~/.zshrc
> ```

## Install and Configure the AWS CLI on a Mac

Follow this [tutorial](https://graspingtech.com/install-and-configure-aws-cli/) to create a new IAM user to use AWS CLI on a Mac.

Run [`aws configure`](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html).

## Publish Layers

[publish-layer-version](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/lambda/publish-layer-version.html#publish-layer-version)

## Installing the AWS SAM CLI on macOS

[Installing the AWS SAM CLI on macOS](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install-mac.html#serverless-sam-cli-install-mac-docker)

## Installing Docker

We need to install docker to create our layer zip file.
This will ensure our packages to be compatible with target environment runtime.

https://aws.amazon.com/premiumsupport/knowledge-center/lambda-layer-simulated-docker/

https://stackoverflow.com/a/63973954/7246315

Once you are done installing and configuring Docker, run in the terminal:
```
cd python
docker run -v "$PWD":/var/task "lambci/lambda:build-python3.8" /bin/sh -c "pip install -r ../requirements.txt -t .; exit"
```

## Export compressed file to lambda layer

Run this shell script to export the zip file (modify the script according to your own settings):
```
sh export_layer.sh
```