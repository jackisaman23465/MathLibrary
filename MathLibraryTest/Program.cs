using System;
using MathLibrary;

class Program
{
    static void Main()
    {
        Calculator calc = new Calculator();

        Console.WriteLine($"Add(5, 3) = {calc.Add(5, 3)}");
        Console.WriteLine($"Subtract(10, 4) = {calc.Subtract(10, 4)}");
        Console.WriteLine($"Divide(10, 2) = {calc.Divide(10, 2)}");
        Console.WriteLine($"Divide(5, 0) = {calc.Divide(5, 0)}");

        Console.WriteLine("Test complete. Check log.txt for errors.");
    }
}
