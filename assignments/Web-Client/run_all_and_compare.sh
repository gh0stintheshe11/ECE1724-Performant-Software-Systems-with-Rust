#!/bin/bash

# Create output directory if it doesn't exist
mkdir -p outputs

# un archive the a2-marking-tests.tar.gz file
tar -xzf a2-marking-tests.tar.gz

# Command 1: Help
echo "Running command 1: cargo run -- -h"
cargo run -- -h > outputs/output_1.txt

# Command 2: Single file search
echo "Running command 2: cargo run -- Utility a2-marking-tests/tests/grep.md"
cargo run -- Utility a2-marking-tests/tests/grep.md > outputs/output_2.txt

# Command 3: Multiple specific files
echo "Running command 3: cargo run -- Utility a2-marking-tests/tests/grep.md a2-marking-tests/tests/recursive/grep.md"
cargo run -- Utility a2-marking-tests/tests/grep.md a2-marking-tests/tests/recursive/grep.md > outputs/output_3.txt

# Command 4: Wildcard search
echo "Running command 4: cargo run -- Utility a2-marking-tests/tests/*.md a2-marking-tests/tests/recursive/*.md"
cargo run -- Utility a2-marking-tests/tests/*.md a2-marking-tests/tests/recursive/*.md > outputs/output_4.txt

# Command 5: Case insensitive search
echo "Running command 5: cargo run -- Utility a2-marking-tests/tests/grep.md -i"
cargo run -- Utility a2-marking-tests/tests/grep.md -i > outputs/output_5.txt

# Command 6: Line number display
echo "Running command 6: cargo run -- Utility a2-marking-tests/tests/grep.md -n"
cargo run -- Utility a2-marking-tests/tests/grep.md -n > outputs/output_6.txt

# Command 7: Invert match
echo "Running command 7: cargo run -- Utility a2-marking-tests/tests/grep.md -v"
cargo run -- Utility a2-marking-tests/tests/grep.md -v > outputs/output_7.txt

# Command 8: Recursive search
echo "Running command 8: cargo run -- Utility a2-marking-tests/tests -r"
cargo run -- Utility a2-marking-tests/tests -r > outputs/output_8.txt

# Command 9: Recursive search with filename
echo "Running command 9: cargo run -- Utility a2-marking-tests/tests -r -f"
cargo run -- Utility a2-marking-tests/tests -r -f > outputs/output_9.txt

# Command 10: Complex search
echo "Running command 10: cargo run -- Utility a2-marking-tests/torch/*.py a2-marking-tests/torch/*/*.py -r -f -i"
cargo run -- Utility a2-marking-tests/torch/*.py a2-marking-tests/torch/*/*.py -r -f -i > outputs/output_10.txt

echo "All commands have been executed. Check outputs/ for results." 

# Normalize paths in output files by removing "a2-marking-tests/" prefix (macOS compatible version)
for i in {1..10}; do
    sed -i '' 's|a2-marking-tests/||g' outputs/output_${i}.txt
done

# generate a compare.txt file to compare the outputs with the correct outputs
diff outputs/output_1.txt a2-marking-tests/correct-outputs/1-output.txt > compare.txt
diff outputs/output_2.txt a2-marking-tests/correct-outputs/2-output.txt >> compare.txt
diff outputs/output_3.txt a2-marking-tests/correct-outputs/3-output.txt >> compare.txt
diff outputs/output_4.txt a2-marking-tests/correct-outputs/4-output.txt >> compare.txt
diff outputs/output_5.txt a2-marking-tests/correct-outputs/5-output.txt >> compare.txt
diff outputs/output_6.txt a2-marking-tests/correct-outputs/6-output.txt >> compare.txt
diff outputs/output_7.txt a2-marking-tests/correct-outputs/7-output.txt >> compare.txt
diff outputs/output_8.txt a2-marking-tests/correct-outputs/8-output.txt >> compare.txt
diff outputs/output_9.txt a2-marking-tests/correct-outputs/9-output.txt >> compare.txt
diff outputs/output_10.txt a2-marking-tests/correct-outputs/10-output.txt >> compare.txt
