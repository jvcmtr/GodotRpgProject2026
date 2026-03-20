> **Referencia :** https://macoratti.net/22/01/c_templatemethod1.htm

Basicamente, definir diferentes partes do fluxo de um algoritimo em diferentes partes da hierarquia de herança. Permite modularidade e diminui a quantidade de codigo escrito nas classes filhas.

**Abstract Classe Pai**
- Define fluxo (privado)
- Define Partes Modulares (abstratas/virtual para serem obrigatorias/opcionais)

**Concrete Classe filha**
- Só implementa as partes modulares
- Pode usar o comportamento default dos metodos virtuais
- É obrigada a implementar os metodos abstratos

### Implementação
``` c#
// Pseudocodigo
abstract class Pai{
	string private GetValue(){
		var a = calcular();		
		return formatar(a);
	}
	protected abstract int calcular();
	protected virtual string formatar(int i){ 
		return "valor da classe:" + i.ToString();
	}
}

// Só altera a parte nescessaria da classe fiha
public class Filho122{
	protected override int calcular() => 122;
}

// Pode alterar também outras funções se nescessario
public class FilhoDinamico{
	public int valor;
	protected override int calcular() => valor;
	protected override string formatar(int i) => "valor dinamico : " + i.toString();
}
```

---
#### Other reference
> **ref : ** https://www.dofactory.com/net/template-method-design-pattern

**we can do even better in the final example:**
``` c#
namespace Template.NetOptimized;

using static System.Console;

/// <summary>
/// Template Design Pattern
/// </summary>
public class Program
{
    public static void Main()
    {
        var categories = new CategoryAccessor();
        categories.Run(5);

        var products = new ProductAccessor();
        products.Run(3);

        // Wait for user
        ReadKey();
    }
}

public record Category
{
    public string CategoryName { get; set; } = null!;
}

public record Product
{
    public string ProductName { get; set; } = null!;
}

/// <summary>
/// The 'AbstractClass' abstract class
/// </summary>
public abstract class DataAccessor<T> where T : class, new(){
    protected List<T> Items { get; set; } = [];
    protected abstract string implementationName {get;} // added for 'Process' method

    // The 'Template Method' 
    public void Run(int top)
    {
        Connect();
        Select();
        Process(top);
        Disconnect();
    }

    public virtual void Connect(){
        Items.Clear();
    }
    public abstract void Select();
    public abstract void GetInfo(T); // Added this new method
    public virtual void Process(int top){ // So that this method can become virtual
		WriteLine(implementationName + " ---- ");
        for (int i = 0; i < top; i++)
        {
            WriteLine(GetInfo(Items[i]));
        }
        WriteLine();
    }
    public virtual void Disconnect(){
        Items.Clear();
    }
}

/// <summary>
/// A 'ConcreteClass' class
/// </summary>
public class CategoryAccessor : DataAccessor<Category>
{
	protected override string implementationName = "Categories";
    public override void Select()
    {
        Items.Add(new() { CategoryName = "Red" }); // removed some for consiseness
        Items.Add(new() { CategoryName = "Green" });
        Items.Add(new() { CategoryName = "Blue" });
    }

    public override void GetInfo(Category item)
    {
		return item.CategoryName;
    }
}

/// <summary>
/// A 'ConcreteClass' class
/// </summary>
public class ProductAccessor : DataAccessor<Product>
{
	protected override string implementationName = "Products";
    public override void Select()
    {
        Items.Add(new Product { ProductName = "Car" });// removed some for consiseness
        Items.Add(new Product { ProductName = "Bike" });
    }
    public override void GetInfo(Category item)
    {
		return Items[i].ProductName
    }
}

```