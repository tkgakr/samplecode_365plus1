class Program
{
    static void Main()
    {
        const int width = 40;
        const int height = 20;
        var rand = Random.Shared;

        Span<char> line = stackalloc char[width];

        for (int y = 0; y < height; y++)
        {
            for (int x = 0; x < width; x++)
                line[x] = rand.Next(10) < 2 ? '*' : ' ';
            Console.WriteLine(new string(line));
        }
    }
}