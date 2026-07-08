(actually using vscodium)

---
###### REF: 
Basic settup:
https://www.youtube.com/watch?v=Lh9xOh7nhLo&list=WL&index=2

Settup workspace in vscode (so that docs, git, etc.. apears):
https://www.youtube.com/watch?v=0KuF8tq15_A

---
## Project Root (WORKING)

##### 1. Basic settup
Siga as seguintes instruções: fornescidas em Basic settup. 
##### 2. Aditional configuration

> [!note] Porque precisamos de configurações adicionais:
> Quando configuramos o vscode para abrir a raiz do projeto (segundo o git) o godot tenta abrir a raiz do projeto (segundo o godot) ao iniciar o editor (o que exclui o .vscode, .git, docs etc...)
>
> Para solucionar isso, temos que passar o caminho do projeto (hardcoded, apartir da raiz do sistema) nas configurações de lauch do external text editor.

configurar no godot:
Editor Settings >  Text Editor > External > Exec Flags
```
full/path/to/project --goto {file}:{line}:{col}
```

configurar no vscode:
```json
// .vscode/launch.json
{
    // (almost) Default godot tools lauching
    "version": "0.2.0", 
    "configurations": [
        
        {
            "name": "GDScript: Launch Project",
            "type": "godot",
            "request": "launch",
            // set path to godot project inner folder
            "project": "${workspaceFolder}/rpg-try-2026",
            "debug_collisions": false,
            "debug_paths": false,
            "debug_navigation": false,
            "additional_options": ""
        }
    ]
}
```

---
## Workspace (ISSUES)

> [!warning]
> Trabalhando com workspace ctrl+click não funciona

configurar no godot:
Editor Settings >  Text Editor > External > Exec Flags
```
{project}/rpg_try_2026.code-workspace --goto {file}:{line}:{col}
```

workspace files:
- Incluir diretorio pai (para que docs, gitignore etc sejam exibidos)
- Incluir diretorio do godot (para que `file:line:col` funcione)
- Esconder diretorio godot da exibição para não ficar duplicado
- Incluir excludes para não mostrar os `uuids` do godot
- Incluir launching configurations
```json
// ./rpg_try_2026/rpg_try_2026.code-workspace

// TO USE THIS FILE AND SET UP A VSCODE WORKSPACE + GODOT :
// Open the godot project and make the following configuration
//  In: Editor Settings >  Text Editor > External > Exec Flags
//  Paste: `{project}/rpg_try_2026.code-workspace --goto {file}:{line}:{col}`
{
    "folders":[
        {
	        // So that other project related files show in workspace
            "name": "workspace",
            "path": ".."
        },
        {
            // makes the correct file open in vscode when using godot
            "name": "rpg-try-2026",
            "path": "." 
        }
    ],
    "settings": {
        "files.exclude": {
            // hide the folder so that it isnt duplicated in workspace
            "rpg-try-2026/": true, 
            
            // Hide godot 4.6 uuids
            "**/*.svg.import": true, 
            "**/*.png.import": true,
            "**/*.cs.uid": true,
            "**/*.gd.uid": true,
        }
    },
    "launch": {
        // (almost) Default godot tools lauching
        "version": "0.2.0", 
        "configurations": [
            
            {
                "name": "GDScript: Launch Project",
                "type": "godot",
                "request": "launch",
		        // set witch workspace folder to run from
                "project": "${workspaceFolder:rpg-try-2026}",
                "debug_collisions": false,
                "debug_paths": false,
                "debug_navigation": false,
                "additional_options": ""
            }
        ]
    }
}
```