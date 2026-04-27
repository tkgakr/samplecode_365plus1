"""RSA による公開鍵暗号方式の最小サンプル。

公開鍵暗号方式では、暗号化に使う鍵と復号に使う鍵を分けます。

- 公開鍵: 他人に渡してよい鍵。メッセージを暗号化するときに使う。
- 秘密鍵: 自分だけが持つ鍵。暗号文を復号するときに使う。

この仕組みによって、相手の公開鍵さえ分かればメッセージを安全に送れます。
ただし復号できるのは、対応する秘密鍵を持つ相手だけです。

このコードは RSA の基本的な流れを学ぶための教材であり、実用的な安全性を
そのまま満たす実装ではありません。
"""

import math
import random


def generate_key_pair(p, q):
    """2つの素数から RSA の公開鍵と秘密鍵を作る。

    RSA では最初に素数 `p` と `q` を選び、その積 `n = p * q` を作ります。
    `n` は公開鍵と秘密鍵の両方で共通して使われる重要な値です。

    次に `phi = (p - 1) * (q - 1)` を計算し、これと互いに素な数 `e` を
    公開指数として選びます。さらに、`e` から逆元 `d` を求めると、
    これが秘密指数になります。

    返り値は以下の2組です。

    - 公開鍵: `(e, n)`
    - 秘密鍵: `(d, n)`
    """
    modulus = p * q
    phi = (p - 1) * (q - 1)
    public_exponent = random.randrange(2, phi)
    g = math.gcd(public_exponent, phi)
    while g != 1:
        public_exponent = random.randrange(2, phi)
        g = math.gcd(public_exponent, phi)
    private_exponent = pow(public_exponent, -1, phi)
    return ((public_exponent, modulus), (private_exponent, modulus))


def encrypt_rsa(pk, plaintext):
    """公開鍵で文字列を暗号化する。

    公開鍵 `(e, n)` を使って、各文字を整数に変換してから
    `c = m^e mod n` を計算します。

    ここでのポイントは、暗号化には公開鍵を使うため、送り手は秘密鍵を
    知っている必要がないことです。相手が公開している鍵だけで暗号文を
    作れます。
    """
    key, n = pk
    cipher = [(ord(char) ** key) % n for char in plaintext]
    return cipher


def decrypt_rsa(sk, ciphertext):
    """秘密鍵で暗号文を復号する。

    秘密鍵 `(d, n)` を使って各整数に対し `m = c^d mod n` を計算すると、
    元の文字コードに戻せます。

    公開鍵は誰に見られてもよい一方で、秘密鍵は本人だけが保持します。
    そのため、暗号文を元の平文に戻せるのは秘密鍵を持つ受信者だけです。
    """
    key, n = sk
    plain = [chr((char ** key) % n) for char in ciphertext]
    return ''.join(plain)


def main():
    """RSA の鍵生成、暗号化、復号の流れを順に確認する。"""
    p, q = 61, 53
    public_key, private_key = generate_key_pair(p, q)
    print(f"公開鍵:{public_key}, 秘密鍵:{private_key}")

    message = "Hello, RSA!"
    print("\n元のメッセージ:", message)

    encrypted_msg = encrypt_rsa(public_key, message)
    print("暗号化されたメッセージ:", encrypted_msg)

    decrypted_msg = decrypt_rsa(private_key, encrypted_msg)
    print("復号されたメッセージ:", decrypted_msg)


if __name__ == '__main__':
    main()
