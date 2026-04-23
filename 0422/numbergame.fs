// NumberGuess.fs
open System

[<EntryPoint>]
let main argv =
    let rng = Random()
    let secret = rng.Next(1, 21)
    let mutable guess = 0
    let mutable attempts = 0

    printfn "1～20の数字を当ててね！"

    while guess <> secret do
        printf "入力: "
        let input = Console.ReadLine()
        if String.IsNullOrWhiteSpace(input) then
            printfn "無効な入力です。数字を入力してください。"
        else
            let mutable value = 0
            if Int32.TryParse(input.Trim(), &value) then
                guess <- value
                attempts <- attempts + 1
                if guess < secret then 
                    printfn "もっと大きいよ"
                elif guess > secret then
                    printfn "もっと小さいよ"
            else
                printfn "無効な入力です。数字を入力してください。"

    printfn "正解！ 🎉 試行回数: %d" attempts
    0 // Exit code