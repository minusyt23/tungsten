# Makes an open prompt
# No checks, fuck off
# arg1: title
# arg2: return variable

prompt_answer () {
	title=$1

	echo $title
	read result

	eval "$2=$result"
}

# Makes a closed prompt
# arg1: Title
# arg2: list of choices

prompt_choice () {
	title=$1
	shift
	array=($@)

	finish=0

	while [ $finish -eq 0 ]; do
		echo $title

		for i in ${!array[@]}; do
			echo "[$(expr $i + 1)] ${array[$i]}"
		done

		len=$(expr $i + 1)

		read result
		if [ $result -le $len ] && [ $result -gt 0 ]; then
			finish=1
		else
			echo "Wrong!"
		fi
	done

	return $result
}
