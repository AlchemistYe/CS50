import csv
import sys


def main():
    # TODO: Check for command-line usage
    file_csv = sys.argv[1]
    file_txt = sys.argv[2]
    with open(file_csv, 'r') as csvfile:
        reader = csv.reader(csvfile)
        names = [row for row in reader]
    names[0] = names[0][1:]

    with open(file_txt, 'r') as file:
        sequence = file.read()

    STR_l = []
    # TODO: Find longest match of each STR in DNA sequence
    for str in names[0]:
        STR_l.append(longest_match(sequence, str))
    # TODO: Check database for matching profiles
    for i, row in enumerate(names[1:]):
        nums = row[1:]
        nums = [int(x) for x in nums]
        if nums == STR_l:
            break

    if i + 1 < len(names) - 1:
        print(names[i + 1][0])
    else: print("No match")

    return


def longest_match(sequence, subsequence):
    """Returns length of longest run of subsequence in sequence."""

    # Initialize variables
    longest_run = 0
    subsequence_length = len(subsequence)
    sequence_length = len(sequence)

    # Check each character in sequence for most consecutive runs of subsequence
    for i in range(sequence_length):

        # Initialize count of consecutive runs
        count = 0

        # Check for a subsequence match in a "substring" (a subset of characters) within sequence
        # If a match, move substring to next potential match in sequence
        # Continue moving substring and checking for matches until out of consecutive matches
        while True:

            # Adjust substring start and end
            start = i + count * subsequence_length
            end = start + subsequence_length

            # If there is a match in the substring
            if sequence[start:end] == subsequence:
                count += 1

            # If there is no match in the substring
            else:
                break

        # Update most consecutive matches found
        longest_run = max(longest_run, count)

    # After checking for runs at each character in seqeuence, return longest run found
    return longest_run


main()
