using System;
using System.Linq;
class Program
{
    static void Main()
    {
        Console.OutputEncoding = System.Text.Encoding.UTF8;
        Enumerable.Range(0, 10)
        .Select(i => new string('■', i + 1))
        .ToList()
        .ForEach(bar => {
            // ConsoleColor は 0〜15 の 16 値の列挙型。bar.Length(1〜10)を 16 で割った余りを
            // ConsoleColor にキャストして、行ごとに異なる色を割り当てている。
            // 16 で剰余を取るのは、長さが 16 以上になっても列挙範囲を超えないようにするための保険。
            Console.ForegroundColor = (ConsoleColor)(bar.Length % 16);
            Console.WriteLine(bar);
        });
    }
}
