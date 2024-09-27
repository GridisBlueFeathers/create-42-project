#!/bin/bash

echo "Project name:"
read project_name

if [ -f ~/create-42-project.json ]
then
	echo "Config file found"
fi

printf "Use libft? [y/n]: "
read -n1 libft_response

if [[ $libft_response == "y" ]]; then
	printf "\nwill be using libft\n"
	libft_usage=1
elif [[ $libft_response == "n" ]]; then
	printf "\nwill not be using libft\n"
	libft_usage=0
else
	printf "\nValue not recognized. Aborting...\n"
	exit 1
fi

if [ $libft_usage ]; then
	libft_git=$(jq .libft.git ~/create-42-project.json)

	echo "libft git $libft_git"
fi

rm -rf $project_name # DEV DELETE LATER

if [ -d $project_name ]
then
	echo "$project_name exists"
	exit 1
else
	echo "Creating project: $project_name"
fi

mkdir $project_name
cd $project_name

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


touch Makefile
