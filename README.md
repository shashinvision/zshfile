# ~/.zshrc

Mi configuración personalizada de ZSH

---

## 🚀 Instalación y uso

### 1. Clonar el repositorio

```bash
git clone https://github.com/shashinvision/zshfile.git ~/zshfile
```

### 2. Crear un enlace simbólico

Esto permite usar la configuración directamente desde el repositorio clonado:

```bash
ln -s ~/zshfile/.zshrc ~/.zshrc
```

> ⚠️ Si ya tienes un `.zshrc`, respáldalo primero:

```bash
mv ~/.zshrc ~/.zshrc.backup
ln -s ~/zshfile/.zshrc ~/.zshrc
```

---

## ⚙️ Funciones útiles en este `.zshrc`

Incluye funciones como `tat` para gestionar sesiones `tmux` automáticamente:

```bash
function tat {
  name=$(basename `pwd` | sed -e 's/\.//g')
  if tmux ls 2>&1 | grep "$name"; then
    tmux attach -t "$name"
  elif [ -f .envrc ]; then
    direnv exec / tmux new-session -s "$name"
  else
    tmux new-session -s "$name"
  fi
}
```

---

## 🔁 Recarga de configuración

Después de crear el symlink o modificar `.zshrc`, recarga tu shell con:

```bash
source ~/.zshrc
```

---

¡Listo! Ahora tienes una configuración de ZSH personalizada y vinculada a tu repo para mantenerla centralizada y versionada. 🧑‍💻💥
