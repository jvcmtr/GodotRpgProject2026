> **Ref**: https://giannisakritidis.com/blog/Compile-Time-Polymorphism/
## Sobre
Este documento não só fala do Polimorfismo de classes estaticas mas mais especificamente do **Compile Time Dispatch** (Um dispatch é quando deixamos a cargo da linguagem decidir qual sobrecarga de um metodo vai ser chamada, quando varias se encaixam)que podemos fazer a partir dele
## Resumo
Basicamente, quando criamos uma classe estatica que recebe argumento do tipo (classe com `static` e `<T>`)  na hora da compilação sobrecargas dela são criadas e cada referencia a ela é mapeada para uma das sobrecargas (em tempo de compilação).

Na pratica, isso permite mapear tipos em tempo de **compilação** (em vez de usar `dynamic` e `casting` que geram overheads em tempo de **Execução** ) 

Mapeamos Tipos para Metodos, ou seja, fazemos uma chamada a um metodo genérico `MyMetod(T arg)` e em tempo de compilação esta chamada é traduzida para uma implementação real do metodo com um tipo restrito (aka fortemente tipado) `MyMetod(int arg)`
## Exemplo
**Este codigo não foi testado**
By GPT:
``` c#
// 1
// Implementações para cada tipo
public class IntSerializer : ISerializer<int>{
    public string Serialize(int value) => $"Int: {value}";
}

public class StringSerializer : ISerializer<string>{
    public string Serialize(string value) => $"String: {value}";
}

public class DefaultSerializer<T> : ISerializer<T>{
    public string Serialize(T value) => $"Default: {value?.ToString()}";
}


public static class Serializer<T>
{
	// 3
	// Com base no tipo, esta variavel vai ser inicializada (em tempo de compilação)
    public static readonly ISerializer<T> Instance = SerializerImpl<T>.Instance;

    public static string Serialize(T value) => Instance.Serialize(value);
}

// 2
// Cada uma dessas mapeia uma implementação para um tipo
static class SerializerImpl<T>{
    public static readonly ISerializer<T> Instance = new DefaultSerializer<T>();
}

static class SerializerImpl<int>{
    public static readonly ISerializer<int> Instance = new IntSerializer();
}

static class SerializerImpl<string>{
    public static readonly ISerializer<string> Instance = new StringSerializer();
}

```