# Directories
TEST_DIR=test
BIN_DIR=build/test

echo "Root folder:" $1

# Go to root folder
cd $1

pwd

# Make all tests
for entry in "$TEST_DIR"/*.c
do
	e=${entry#*Test}
	e=${e%.*}
	make clean
	make test TEST=$e
done

echo
echo

# Execute all tests
for entry in "$TEST_DIR"/*.c
do
	e=${entry#*Test}
	e=${e%.*}
	echo $e
	echo "================================"
	$BIN_DIR/$e.out
	echo "================================"
done