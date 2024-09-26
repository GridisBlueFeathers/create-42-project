#!/bin/bash

echo "Project name:"
read project_name

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
echo "#ifndef "

touch Makefile
