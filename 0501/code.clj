;;; 因数分解をする関数
(defn pfac-rec [d n acc]
    (cond
    ;; nが1になったらaccを返す
    (= n 1) acc
    ;; nがdで割り切れるならdをaccに追加し、nをn/d、dを2にして再帰する
    (= 0 (rem n d)) (pfac-rec 2 (/ n d) (cons d acc))
    ;; それ以外はdを+1して再帰する
    :else (pfac-rec (inc d) n acc)))

(defn pfac [n] (pfac-rec 2 n '()))

(println (pfac 40))     ; => (5 2 2 2)
(println (pfac 1986))   ; => (331 3 2)
(println (pfac 2026))   ; => (1013 2)
