#!/bin/bash

printf "Project name: "
read project_name

if [ -f ~/create-42-project.json ]; then
	printf "Config file found"
	config_present=1
else
	config_present=0
fi

printf "\nUse libft? [y/n]: "
read -n1 libft_response

if [[ $libft_response == "y" ]]; then
	libft_usage=1
elif [[ $libft_response == "n" ]]; then
	libft_usage=0
else
	printf "\nValue not recognized. Aborting...\n"
	exit 1
fi

if [ $libft_usage -eq 1 ] && [ $config_present -eq 1 ]; then
	libft_git=$(jq -r .libft.git ~/create-42-project.json)
elif [ $libft_usage -eq 1]; then
	printf "\nPlease provide libft remote repo link: "
	read libft_git
fi

rm -rf $project_name # DEV DELETE LATER

if [ -d $project_name ]
then
	printf "\n$project_name exists"
	exit 1
else
	printf "\nCreating project: $project_name"
fi

printf "\nCreating $project_name directory"
mkdir $project_name
cd $project_name


printf "\nInitializing repository\n"
git init
git branch -m main
if [ $libft_usage -eq 1 ]; then
	printf "Adding libft submodule\n"
	git submodule add $libft_git
fi

mkdir src
cd src
touch main.c

echo "#include \"$project_name.h\"" >> main.c
echo "" >> main.c
echo "int	main(int argc, char **argv)" >> main.c
echo "{" >> main.c
echo "	(void)argc;" >> main.c
echo "	(void)argv;" >> main.c
echo "}" >> main.c

cd ../
mkdir include
cd include
touch $project_name.h
echo "#ifndef ${project_name^^}_H" >> $project_name.h
echo "# define ${project_name^^}_H" >> $project_name.h
echo "" >> $project_name.h
echo "#endif" >> $project_name.h

cd ../

touch Makefile
