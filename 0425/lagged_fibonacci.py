# Lagged Fibonacci Generator（遅延フィボナッチ法） という方式で擬似乱数列を生成するための関数
# a, b は「何個前の値を参照するか」を表すラグ
# m は生成値の範囲を制御する法
# seed_list は初期値列、n_samples は生成したい乱数の個数
def lagged_fibonacci_generator(a, b, m, seed_list, n_samples):
    # 最初の b 個を初期シードとして利用する
    random_numbers = seed_list[:b]
    # 指定された数の乱数を生成
    for i in range(b, n_samples + b):
        # ラグaとbの位置にある要素を取得
        term1 = random_numbers[i - a]
        term2 = random_numbers[i - b]
        # X_i = (X_(i-a) + X_(i-b)) mod m の式で新しい値を計算
        new_number = (term1 + term2) % m
        # 新しい乱数をリストに追加
        random_numbers.append(new_number)
    # 先頭のシード部分を除き、生成した乱数列のみ返す
    return random_numbers[b:]  # シード値を除いたリストを返す


# 使用例
# 7個前と10個前の値を使い、32bit整数の範囲で乱数列を生成する
a_val, b_val, m_val = 7, 10, 2**32
# 初期シードは 10 個用意する（この例では b=10 なので 10 個必要）
seed_data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# 生成したい乱数の個数
num_to_generate = 20
generated_list = lagged_fibonacci_generator(
    a=a_val, b=b_val, m=m_val, seed_list=seed_data,
    n_samples=num_to_generate)
# 生成結果を表示
print(generated_list)
