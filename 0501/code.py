# Python ではこの処理を再帰で書くと RecursionError になる場合があるため、反復で実装する
def pfac_rec(d, n, acc):
    while True:
        if n == 1:
            return acc
        if n % d == 0:
            acc = [d] + acc
            n = n // d
            d = 2
        else:
            d = d + 1


def pfac(n):
    return pfac_rec(2, n, [])


print(pfac(40))
print(pfac(1986))
print(pfac(2026))
