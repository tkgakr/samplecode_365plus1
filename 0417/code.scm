;; 継続を使ってライプニッツの公式で円周率を計算する
(define (make-pi)
    (let ((return ()))
    (letrec ((continue
        (lambda ()
        (let loop ((sign 1) (n 1) (acc 0))
            (call/cc
            (lambda (dd)
                (set! continue (lambda () (dd 'restart))) ; 次の値を計算する直前の継続を保存
                (return (exact->inexact (* 4 acc))))  ; 中断して現在の円周率の値を返す
            )
            (loop (- 0 sign) (+ 2 n) (+ (* sign (/ 1 n)) acc)) ; 次の値を計算して再帰
        ))))
        (lambda ()                    ; make-piで返される関数(以下でpに束縛している)
        (call/cc (lambda (cc)
                    (set! return cc)  ; 呼び出し元に戻る継続を保存
                    (continue))))     ; 円周率計算を再開
    )
    )
)

(let ((p (make-pi)))
    (define (show-pi)
    (display (p))                        ; 円周率の次の値を表示
    (if (not (string=? (read-line) "q")) ; qで終了、Enterで続行
        (show-pi)
        ()
    ))
    (show-pi)
)
