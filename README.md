# 🧪 Laboratorio 6 - Comandos de Linux

## 👣 Parte I: Comandos Básicos

### 🗂️ Ejercicio 1: Manipulación de Archivos y Directorios

```bash
# Me desplacé entre directorios
cd

# En el directorio entrada, creé tres archivos vacíos
touch datos1.txt datos2.txt config.cfg

# Copié datos1.txt al directorio respaldo
cp datos1.txt ../respaldo/

# Moví config.cfg al directorio raíz del laboratorio
mv config.cfg ../

# Eliminé datos2.txt
rm datos2.txt
```
![prueba](https://github.com/luisvalenzuela25/LABORATORIO-SO/blob/main/imagen_so_lab/4.png?raw=true)

📝 Ejercicio 2: Registros y Edición de Archivos
```bash

# Generé un archivo con 20 líneas
for i in {1..20}; do echo "Línea $i" >> registro.log; done

# Mostré las primeras 5 líneas
head -n 5 registro.log

# Mostré las últimas 3 líneas
tail -n 3 registro.log

# Edité el archivo con nano y agregué al inicio: # ARCHIVO DE REGISTRO

# Verifiqué el contenido completo
cat registro.log
```
![prueba](https://github.com/luisvalenzuela25/LABORATORIO-SO/blob/main/imagen_so_lab/1.png?raw=true)
![prueba](https://github.com/luisvalenzuela25/LABORATORIO-SO/blob/main/imagen_so_lab/2.png?raw=true)

 Parte II: Comandos Intermedios
Ejercicio 3: Búsqueda y Procesamiento de Archivos
```bash
# Buscar archivos .txt en todo el laboratorio
find . -name "*.txt"

# Crear archivo de números
seq 1 100 > numeros.txt

# Números pares
awk '$1 % 2 == 0' numeros.txt

# Números divisibles por 3
awk '{for(i=1;i<=NF;i++) if ($i % 3 == 0) print $i}' numeros.txt

# Cantidad de números divisibles por 5
awk '{for(i=1;i<=NF;i++) if ($i % 5 == 0) print $i}' numeros.txt | wc -l

# Ordenar números de mayor a menor
sort -nr numeros.txt > numeros_ordenados.txt
```
![prueba](https://github.com/luisvalenzuela25/LABORATORIO-SO/blob/main/imagen_so_lab/3.png?raw=true)
![prueba](https://github.com/luisvalenzuela25/LABORATORIO-SO/blob/main/imagen_so_lab/5.png?raw=true)

🧵 Ejercicio 4: Redirección y Tuberías
```bash
# Guardar lista de procesos
ps aux > todos_los_procesos.txt

# Filtrar procesos del usuario
ps -u $USER > procesos_mi_usuario.txt

# Procesos que más memoria consumen
ps aux --sort=-%mem | head -n 6 > top_procesos.txt

# Contar archivos en /laboratorio
find laboratorio -type f | wc -l
```
![prueba](https://github.com/luisvalenzuela25/LABORATORIO-SO/blob/main/imagen_so_lab/7.png?raw=true)
![prueba](https://github.com/luisvalenzuela25/LABORATORIO-SO/blob/main/imagen_so_lab/8.png?raw=true)
![prueba](https://github.com/luisvalenzuela25/LABORATORIO-SO/blob/main/imagen_so_lab/9.png?raw=true)

🔐 Parte III: Comandos Avanzados
🛡️ Ejercicio 5: Permisos y Usuarios
```bash
# Crear carpeta privada y proteger archivo
mkdir privado
touch privado/confidencial.txt
chmod 600 privado/confidencial.txt

# Crear carpeta compartida con acceso limitado
mkdir compartido
chmod 755 compartido

```
![prueba](https://github.com/luisvalenzuela25/LABORATORIO-SO/blob/main/imagen_so_lab/13.png?raw=true)
![prueba](https://github.com/luisvalenzuela25/LABORATORIO-SO/blob/main/imagen_so_lab/14.png?raw=true)

📊 Ejercicio 6: Monitoreo de Procesos
```bash
# Ejecutar ping en segundo plano
ping google.com > ping_log.txt &

# Usar top:
# - Presionar 'P' para ordenar por CPU
# - Presionar 'M' para ordenar por memoria
# - Presionar 'u' y escribir tu usuario para filtrar

# Identificar PID y finalizar el proceso
kill PID
📎 Evidencia: Archivo ping_log.txt y captura del uso de top.
```
![prueba]()
![prueba](https://github.com/luisvalenzuela25/LABORATORIO-SO/blob/main/imagen_so_lab/15.png?raw=true)

💾 Ejercicio 7: Script de Respaldo
Archivo: backup.sh

```bash
Copiar
Editar
#!/bin/bash
fecha=$(date +%Y%m%d_%H%M%S)
nombre=$(basename $1)
tar -czf ~/laboratorio/respald/${nombre}_${fecha}.tar.gz $1
echo "Respaldo exitoso: $(du -h ~/laboratorio/respald/${nombre}_${fecha}.tar.gz)"
Probado con varios directorios.

Genera nombres únicos basados en la fecha y hora.

```
![prueba]()
![prueba](https://github.com/luisvalenzuela25/LABORATORIO-SO/blob/main/imagen_so_lab/16.png?raw=true)

🧠 Ejercicio 8: Reto Final - Análisis de Logs
Archivo: analisis_logs.sh

```bash
#!/bin/bash
fecha=$(date '+%Y-%m-%d %H:%M:%S')
mkdir -p ~/laboratorio/datos/salida
logfiles=$(find /var/log -type f -name "*.log" 2>/dev/null)
top5=$(du -h $logfiles 2>/dev/null | sort -rh | head -n 5)

echo "# Informe de Análisis de Logs" > ~/laboratorio/datos/salida/informe_logs.md
echo "**Fecha del análisis:** $fecha" >> ~/laboratorio/datos/salida/informe_logs.md
echo "| Archivo | Tamaño | Errores encontrados |" >> ~/laboratorio/datos/salida/informe_logs.md
echo "|---------|--------|---------------------|" >> ~/laboratorio/datos/salida/informe_logs.md

mayor_archivo=""
max_errores=0

for archivo in $(echo "$top5" | awk '{print $2}'); do
  errores=$(grep -i "error" "$archivo" 2>/dev/null | wc -l)
  size=$(du -h "$archivo" | cut -f1)
  echo "| $archivo | $size | $errores |" >> ~/laboratorio/datos/salida/informe_logs.md

  if [ "$errores" -gt "$max_errores" ]; then
    mayor_archivo="$archivo"
    max_errores=$errores
  fi
done

echo "## Últimos errores en: $mayor_archivo" >> ~/laboratorio/datos/salida/informe_logs.md
grep -i "error" "$mayor_archivo" 2>/dev/null | tail -n 3 >> ~/laboratorio/datos/salida/informe_logs.md

echo "✅ Análisis completado. Informe guardado en ~/laboratorio/datos/salida/informe_logs.md"
```
![prueba](https://github.com/luisvalenzuela25/LABORATORIO-SO/blob/main/imagen_so_lab/17.png?raw=true)
![prueba](https://github.com/luisvalenzuela25/LABORATORIO-SO/blob/main/imagen_so_lab/18.png?raw=true)
