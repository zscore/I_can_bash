gams_program="/home/zblanton/Downloads/gams24.2_linux_x64_64_sfx"
hw_dir="/media/Storage/Dropbox/STOR415/HW8/HW8/"
cd $hw_dir 
submission="Submission attachment(s)"


IFS='
'
hw_dir="/media/Storage/Dropbox/STOR415/HW8/HW8/"
cd $hw_dir 


dir_list=$(find $1 -mindepth 1 -maxdepth 1 -type d)
for dir in $dir_list
do 
	dir_better=$(echo $dir | tr -d [' '\(\)])
	echo $dir_better
	mv $dir $dir_better
	cd $dir_better
	mv Submission\ attachment\(s\) Submission
	cd Submission
	gams_list=$(find . -name "*.gms")
	for gams in $gams_list
	do
		gams_better=$(echo $gams | tr -d [' '\(\)])
		echo $gams_better
		mv $gams $gams_better
	done
	cd $hw_dir
done

dir_list=$(find $1 -mindepth 1 -maxdepth 1 -type d)
for dir in $dir_list
do
	cd $dir
	cd Submission
	gams_list=$(find . -name "*.gms")
	for gams in $gams_list
	do
		dir_temp="${dir#./}"
		gams_temp="${gams#./}"
		gams_name="${gams_temp%%.gms}" 
		gams_path="$hw_dir$dir_temp/Submission/$gams_temp"
		path="$hw_dir$dir_temp/Submission/"
		cd $gams_program
		sudo ./gams $gams_path -suppress=1 -savepoint=1 -output="$path/$gams_name.lst" -gdx="$path/$gams_name.gdx"
		./gdxdump "$path/$gams_name.gdx" Output = "$path/output_$gams_name.txt"
	done
	cd $hw_dir
done
