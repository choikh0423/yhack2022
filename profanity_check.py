# 1. Profanity Check
# Setup:
# pip install better-profanity
# pip install nltk
from better_profanity import profanity
import nltk

nltk.download('punkt')
en_text = "fuck Fuck"


# 문장 토큰화 작업
words_list=[]
from nltk.tokenize import word_tokenize
words_list.append(word_tokenize(en_text))

# profanity 검출
def check_profanity(words_list):
    for word in words_list:
        if profanity.contains_profanity(word) == True:
            return True

    return False


print(check_profanity("fuck"))