namespace MathLibrary
{
    public class Calculator
    {
        private static readonly string logFilePath = "log.txt";

        public int Add(int a, int b)
        {
            return a + b;
        }

        public int Subtract(int a, int b)
        {
            return a - b;
        }

        public double Divide(int a, int b)
        {
            if (b == 0)
            {
                LogError("Division by zero error.");
                return double.NaN;
            }
            return (double)a / b;
        }

        private void LogError(string message)
        {
            File.AppendAllText(logFilePath, $"{DateTime.Now}: {message}{Environment.NewLine}");
        }
    }
}
