# termux pasos para zsh

Actualizar el sistema
```bash
pkg update && upgrade -y
```
instalar programas necesarios
```bash
pkg install zsh which chsh vim wget -y
```
Colocar zsh como predeterminado 
```bash
chsh -s zsh
```
Cerrar todas las secciones de termux y volver abrir termux. 

Descargar oh my zsh
```bash
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
editar el archivo de configuracion de zsh para cambiar el tema predeteminado por el tema fino
```bash
vim ~/.zshrc
```
Cambiar el tema que viene por defecto por la  palabra fino  
```
ZSH_THEME="fino"
```
Si quiere escoger otro tema y sabes el nombre con  el comando 'omz theme list'.

Para más personalizaciones de oh-my-zsh
```
https://github.com/ohmyzsh/ohmyzsh
```

# pasos para cambiar color y fuente

De la siguiente página descargar la última versión del apk

```
https://f-droid.org/es/packages/com.termux.styling/
```

Luego de descargado he instalarlo, reiniciar termux, luego mantener oprimida la pantalla hasta que salgan las opciones (copy, paste, more...) escoger `more...` de la ventana emergente escoger Style. Hay llegamos a los boten es para escoger fuente y para escoger el color de la terminal

# cambiar el motd (mensaje de inicio de termux) 

```
cd

cd ../usr/etc/

vim motd.sh
```

Estando en vim elimime su contenido y cree un mensaje a su medida