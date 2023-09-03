# TODO
from cs50 import get_string
import re
text = get_string("Text: ")
sentences = [x for x in re.split("[!.?]", text) if x and re.findall(r'[a-zA-Z]', x)]
l_s = len(sentences)
l_w = 0
l_c = 0
for sentence in sentences:
    words = sentence.split()
    l_w += len(words)
    for word in words:
        letters = re.findall(r'[a-zA-Z]', word)
        l_c += len(letters)
L = l_c / l_w
S = l_s / l_w
g = round(5.88 * L - 29.6 * S - 15.8)
if g >= 16:
    print("Grade 16+")
elif g < 1:
    print("Before Grade 1")
else: print(f"Grade {g}")