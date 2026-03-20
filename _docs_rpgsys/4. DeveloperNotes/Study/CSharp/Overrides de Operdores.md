> Com Excessão do operador / (divisão) onde ocorre o cast para `double` (impedindo o c# de truncar o numero para um inteiro na hora da divisão). Tanto o **Override individual de cada operador** como **Tratando um tipo como um Primitivo** possuem a mesma funcionalidade

## Tratando um tipo como um Primitivo
os seguintes metodos permitem que o compilador do c# converta os tipos implicitamente
``` c#
	// O c# vai implicitamente Converter Atributo para para Int
    public static implicit operator int(Attribute a)
    {
        return a.CurrentValue;
    }

	// OPCIONAL
	// Vai implicitamente Converter Int para Atributo
	public static implicit operator Attribute(int value)
    {
        return new Attribute(value);
    }
```

## Override individual de cada operador
``` cs
 //____ ARITHMETIC ____________________________________

    // Arithmetic Attribute -> int 
    public static int operator +(Attribute a, int b) => a.CurrentValue + b;
    public static int operator -(Attribute a, int b) => a.CurrentValue - b;
    public static int operator *(Attribute a, int b) => a.CurrentValue * b;
    public static double operator /(Attribute a, int b) => a.CurrentValue / (double)b;
    public static int operator %(Attribute a, int b) => a.CurrentValue % b;

    // Arithmetic int -> Attribute  [symmetric]
    public static int operator +(int a, Attribute b) => a + b.CurrentValue;
    public static int operator -(int a, Attribute b) => a - b.CurrentValue;
    public static int operator *(int a, Attribute b) => a * b.CurrentValue;
    public static double operator /(int a, Attribute b) => a / (double)b.CurrentValue;
    public static int operator %(int a, Attribute b) => a % b.CurrentValue;

    public static float operator +(Attribute a, float b) => a.CurrentValue + b;
    public static float operator -(Attribute a, float b) => a.CurrentValue - b;
    public static float operator *(Attribute a, float b) => a.CurrentValue * b;
    public static double operator /(Attribute a, float b) => a.CurrentValue / b;
    public static float operator %(Attribute a, float b) => a.CurrentValue % b;

    // Arithmetic float -> Attribute  [symmetric]
    public static float operator +(float a, Attribute b) => a + b.CurrentValue;
    public static float operator -(float a, Attribute b) => a - b.CurrentValue;
    public static float operator *(float a, Attribute b) => a * b.CurrentValue;
    public static double operator /(float a, Attribute b) => a / b.CurrentValue;
    public static float operator %(float a, Attribute b) => a % b.CurrentValue;

     // Arithmetic Attribute -> double 
    public static double operator +(Attribute a, double b) => a.CurrentValue + b;
    public static double operator -(Attribute a, double b) => a.CurrentValue - b;
    public static double operator *(Attribute a, double b) => a.CurrentValue * b;
    public static double operator /(Attribute a, double b) => a.CurrentValue / b;
    public static double operator %(Attribute a, double b) => a.CurrentValue % b;

    // Arithmetic double -> Attribute  [symmetric]
    public static double operator +(double a, Attribute b) => a + b.CurrentValue;
    public static double operator -(double a, Attribute b) => a - b.CurrentValue;
    public static double operator *(double a, Attribute b) => a * b.CurrentValue;
    public static double operator /(double a, Attribute b) => a / b.CurrentValue;
    public static double operator %(double a, Attribute b) => a % b.CurrentValue;

    // Arithmetic Attribute -> Attribute
    public static int operator +(Attribute a, Attribute b) => a.CurrentValue + b.CurrentValue;
    public static int operator -(Attribute a, Attribute b) => a.CurrentValue - b.CurrentValue;
    public static int operator *(Attribute a, Attribute b) => a.CurrentValue * b.CurrentValue;
    public static double operator /(Attribute a, Attribute b) => a.CurrentValue / (double) b.CurrentValue;
    public static int operator %(Attribute a, Attribute b) => a.CurrentValue % b.CurrentValue;

    //____ COMPARISON _____________________________________________

    // Comparison Attribute -> int 
    public static bool operator ==(Attribute a, int b) => a.CurrentValue == b;
    public static bool operator !=(Attribute a, int b) => a.CurrentValue != b;
    public static bool operator <(Attribute a, int b) => a.CurrentValue < b;
    public static bool operator >(Attribute a, int b) => a.CurrentValue > b;
    public static bool operator <=(Attribute a, int b) => a.CurrentValue <= b;
    public static bool operator >=(Attribute a, int b) => a.CurrentValue >= b;

    // Comparison int -> Attribute  [symmetric]
    public static bool operator ==(int a, Attribute b) => a == b.CurrentValue;
    public static bool operator !=(int a, Attribute b) => a != b.CurrentValue;
    public static bool operator <(int a, Attribute b) => a < b.CurrentValue;
    public static bool operator >(int a, Attribute b) => a > b.CurrentValue;
    public static bool operator <=(int a, Attribute b) => a <= b.CurrentValue;
    public static bool operator >=(int a, Attribute b) => a >= b.CurrentValue;

    // Comparison Attribute -> float 
    public static bool operator ==(Attribute a, float b) => a.CurrentValue == b;
    public static bool operator !=(Attribute a, float b) => a.CurrentValue != b;
    public static bool operator <(Attribute a, float b) => a.CurrentValue < b;
    public static bool operator >(Attribute a, float b) => a.CurrentValue > b;
    public static bool operator <=(Attribute a, float b) => a.CurrentValue <= b;
    public static bool operator >=(Attribute a, float b) => a.CurrentValue >= b;

    // Comparison float -> Attribute  [symmetric]
    public static bool operator ==(float a, Attribute b) => a == b.CurrentValue;
    public static bool operator !=(float a, Attribute b) => a != b.CurrentValue;
    public static bool operator <(float a, Attribute b) => a < b.CurrentValue;
    public static bool operator >(float a, Attribute b) => a > b.CurrentValue;
    public static bool operator <=(float a, Attribute b) => a <= b.CurrentValue;
    public static bool operator >=(float a, Attribute b) => a >= b.CurrentValue;

    // Comparison Attribute -> double 
    public static bool operator ==(Attribute a, double b) => a.CurrentValue == b;
    public static bool operator !=(Attribute a, double b) => a.CurrentValue != b;
    public static bool operator <(Attribute a, double b) => a.CurrentValue < b;
    public static bool operator >(Attribute a, double b) => a.CurrentValue > b;
    public static bool operator <=(Attribute a, double b) => a.CurrentValue <= b;
    public static bool operator >=(Attribute a, double b) => a.CurrentValue >= b;

    // Comparison double -> Attribute  [symmetric]
    public static bool operator ==(double a, Attribute b) => a == b.CurrentValue;
    public static bool operator !=(double a, Attribute b) => a != b.CurrentValue;
    public static bool operator <(double a, Attribute b) => a < b.CurrentValue;
    public static bool operator >(double a, Attribute b) => a > b.CurrentValue;
    public static bool operator <=(double a, Attribute b) => a <= b.CurrentValue;
    public static bool operator >=(double a, Attribute b) => a >= b.CurrentValue;
    
    
    // Comparison Attribute -> Attribute
    public static bool operator ==(Attribute a, Attribute b) => a.CurrentValue == b.CurrentValue;
    public static bool operator !=(Attribute a, Attribute b) => a.CurrentValue != b.CurrentValue;
    public static bool operator <(Attribute a, Attribute b) => a.CurrentValue < b.CurrentValue;
    public static bool operator >(Attribute a, Attribute b) => a.CurrentValue > b.CurrentValue;
    public static bool operator <=(Attribute a, Attribute b) => a.CurrentValue <= b.CurrentValue;
    public static bool operator >=(Attribute a, Attribute b) => a.CurrentValue >= b.CurrentValue;
```