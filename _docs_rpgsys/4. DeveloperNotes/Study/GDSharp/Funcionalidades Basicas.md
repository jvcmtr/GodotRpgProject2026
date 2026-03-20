

# 🔹 `preload()` (compile-time loading)
**GDScript:**
```gdscript
var bullet_scene = preload("res://Bullet.tscn")
```

**C#:**
```csharp
PackedScene bulletScene = (PackedScene)GD.Load("res://Bullet.tscn");
```

---

# 🔹 `export` (expose variables in the editor)
**GDScript:**
```gdscript
@export var speed: float = 200.0
```

**C#:**
```csharp
[Export]
public float Speed = 200.0f;
```

---

# 🔹 `signal` (custom event declaration)
**GDScript:**
```gdscript
signal hit
```

**C#:**
```csharp
[Signal]
public delegate void HitEventHandler();
```

---

# 🔹 Connecting signals
**GDScript:**
```gdscript
button.pressed.connect(_on_button_pressed)
```

**C#:**
```csharp
button.Connect("pressed", this, nameof(OnButtonPressed));
```

---

# 🔹 `_ready()` (node lifecycle hook)
**GDScript:**
```gdscript
func _ready():
    print("Ready!")
```

**C#:**
```csharp
public override void _Ready()
{
    GD.Print("Ready!");
}
```

---

# 🔹 Resource files (`.tres` or `.res`)
**GDScript:**
```gdscript
var config = preload("res://MyData.tres")
```

**C#:**
```csharp
var config = GD.Load("res://MyData.tres") as Resource;
```

---

# 🔹 `yield` for coroutines (simplified wait)
**GDScript:**
```gdscript
await get_tree().create_timer(1.0).timeout
```

**C#:**
```csharp
await ToSignal(GetTree().CreateTimer(1.0f), "timeout");
```

---

# 🔹 Groups
**GDScript:**
```gdscript
add_to_group("enemies")
```

**C#:**
```csharp
AddToGroup("enemies");
```

---

# 🔹 Input Handling (`_input()` or `Input.is_action_pressed`)
**GDScript:**
```gdscript
func _process(delta):
    if Input.is_action_pressed("ui_right"):
        position.x += 100 * delta
```

**C#:**
```csharp
public override void _Process(float delta)
{
    if (Input.IsActionPressed("ui_right"))
        Position += new Vector2(100 * delta, 0);
}
```

---

# 🔹 Scene Instancing
**GDScript:**
```gdscript
var bullet = preload("res://Bullet.tscn").instantiate()
add_child(bullet)
```

**C#:**
```csharp
var bullet = (PackedScene)GD.Load("res://Bullet.tscn");
AddChild(bullet.Instantiate());
```

---

# 🔹 Autoloads (Singletons)
> Autoloads are added via **Project Settings → Autoload**, so usage is the same in both languages.

**GDScript (accessing):**
```gdscript
Global.score += 1
```

**C# (accessing):**
```csharp
((Global)GetNode("/root/Global")).Score += 1;
```

---

# 🔹 Timers (one-shot or repeated)
**GDScript:**
```gdscript
var timer = Timer.new()
timer.wait_time = 2.0
timer.one_shot = true
add_child(timer)
timer.start()
```

**C#:**
```csharp
var timer = new Timer { WaitTime = 2.0f, OneShot = true };
AddChild(timer);
timer.Start();
```

---

# 🔹 Custom Editor Tools (tool scripts)
> These run inside the editor, useful for visual tools, previews, etc.

**GDScript:**
```gdscript
@tool
func _process(delta):
    rotation += 0.1
```

**C#:**
```csharp
[Tool]
public override void _Process(float delta)
{
    Rotation += 0.1f;
}
```

---
