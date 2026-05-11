# 5/9 黒板の日：チョークで書くアニメーション
import time

text = "今日は5月9日、黒板の日です！"
chalk = ""

for c in text:
    print("\r\033[1;37;40m" + chalk + "・" + "\033[0m", end="", flush=True)  # 黒板(黒背景)＋白チョーク色
    time.sleep(0.1)
    chalk += c
    print("\r\033[1;37;40m" + chalk + "\033[0m", end="", flush=True)  # 黒板(黒背景)＋白チョーク色
    time.sleep(0.2)

print("\n黒板に書き終わりました！")
