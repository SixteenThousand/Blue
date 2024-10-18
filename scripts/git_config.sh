read -p 'What is your name?: ' NAME
read -p 'What is email that you use with git?: ' EMAIL
git config --global user.email={$EMAIL}
git config --global user.name={$NAME}
echo 'Personal details added!'

git config --global init.defaultBranch main
git config --global alias.goto checkout
git config --global alias.st status
git config --global alias.diffs 'diff --cached'
echo 'Aliases added!'

if which dnf
then
	sudo dnf install git-credential-oauth
elif which go
then
	go install github.com/hickfordgit-credential-oauth@latest
fi
if git credential-oauth configure
	echo 'git-crendential-oauth installed & configured!'
fi

cat <<- EOF
You should now use 'gpg --gen-keys' (or something like that) to generate a 
signing key for commits; use
	git config --global user.signingkey={GnuPG signing key}
to register this with git.
EOF
