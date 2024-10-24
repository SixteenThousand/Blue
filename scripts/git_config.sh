read -p 'What is your name?: ' NAME
read -p 'What is email that you use with git?: ' EMAIL
git config --global user.email $EMAIL
git config --global user.name $NAME
echo 'Personal details added!'

git config --global init.defaultBranch main
if which nvim > /dev/null
then
	git config --global core.editor nvim
fi
if which vim > /dev/null
then
	git config --global core.editor vim
fi
echo 'Options set!'

git config --global alias.goto checkout
git config --global alias.st status
git config --global alias.diffs 'diff --cached'
echo 'Aliases added!'

if which dnf > /dev/null
then
	sudo dnf install git-credential-oauth
elif which go > /dev/null
then
	go install github.com/hickfordgit-credential-oauth@latest
fi
if git credential-oauth configure
then
	echo 'git-crendential-oauth installed & configured!'
else
	cat <<- EOF
	git-credential-oauth failed to install.
	Please do one of the following:
	1) Install go and try this again.
	2) Install manually some other way.
	3) Use a system with DNF.
	4) Give up.
	
	EOF
fi


cat <<- EOF
You should now use 'gpg --gen-keys' (or something like that) to generate a 
signing key for commits; use
	git config --global user.signingkey={GnuPG signing key}
to register this with git.
EOF
