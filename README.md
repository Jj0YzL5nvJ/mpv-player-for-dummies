# mpv-player for Dummies: Batch Installer


## Datos técnicos que explican bajo que condiciones trabaja el script:

- El script esta pensado para funcionar en sistemas español e ingles, de Windows XP a 8.1, teóricamente incluso podría funcionar de Windows 2000 a Windows 10, pero no metería las menos al fuego.
- El script requiere de una instalación nativa de [7-Zip][1] en su ruta predeterminada... usa variables de entrono. Con nativa me refiero a que si tienes un SO de 64-bits, tengas la versión de 7-Zip para 64-bits...
- El script fue pensado para ser utilizado con cualquier versión del [mpv del siguiente enlace][2], recomiendo que no alteren al nombre original del fichero comprimido.
- El script y el reproductor comprimido tienen que estar en la misma carpeta y solo detectara el fichero correspondiente a la arquitectura de su SO. En caso de existir mas de un paquete, se tomara el ultimo fichero por orden alfanumérico...
- El script por defecto correrá con los permisos locales del usuario. Si quieran instalarlo para "todos" los usuarios, recomiendo que ejecuten el batch como administradores. Lo mismo al momento de desinstalar.
- Si el script es instalado como administrador para todos los usuarios, agregara una nuevo opción al dar clic derecho a unidades y carpetas del sistema para facilitar el uso de mpv en "Símbolo del sistema".
- Si [youtube-dl][3] esta en la misma ruta que el script, sera copiado automáticamente al descomprimir el ``mpv*.7z``.
- Si el entorno de Python y ``youtube-dl*.py`` están disponibles, ``youtube-dl*.py`` sera agregado en caso de que ``youtube-dl*.exe`` no este presente, pero a esta fecha, mpv solo se integra con el ``youtube-dl*.exe``.


## Código estable:

 **Archivo:** ``mpv_install_v0.61-RC2.cmd``

 **Tamaño:**  ``8968 bytes``

 **Formato:** ``DOS\Windows ANSI``


 **CRC32:** ``33111767``

 **MD5:** ``4af8e66befed2a6fb331fbd25747c383``

 **SHA1:** ``d5472eddb5062a11a8df60cb7e6fc08fd91d3d64``

 **TIGER:** ``47638b3d15ee7a72824de7980bf3cb51e48cadde2629e60d``

 **SHA256:** ``65af6249e20c9854e1ffa1d207f97f763f59bba0b437ecb64122bb8eb3d780dd``

 **SHA512:** ``14261ae7c4437f023c0334d12163a28b08a392fe9510910bb1e4ce60cd37f8749e729e220d150772cc916abfd6ec93ed9a2e145599c42fb426fb67c1c75d17ce``


 En Ghostbin: [mpv_install_v0.61-RC2][4]


## Bugs conocidos:

 Por la forma en que mpv llama las listas de reproducción, es muy posible que la asociación de archivos no funcione correctamente con listas de  reproducción.

 En el caso de los archivos de audio pasa algo similar...

 Absténganse de asociar listas y archivos de audio por ahora. Esto sera probado y corregido en futuras versiones.


## Código de versiones anteriores:


 Proporcionare el código de algunas versiones anteriores solo con fines didácticos, no recomiendo que los sigan usando.

- [mpv_install_v0.14.1][5]
- [mpv_install_v0.50][6]
- [mpv_install_v0.60-RC3][7]


**Nota:** Si en RAW ven dobles espacios o palabras incompletas en el código, posiblemente uno de los "espacios" sea en realidad un ``"á"``, en DOS ANSI el ``"á"`` equivale a ``[Alt+0160]``. En los exploradores web el ``[Alt+0160]`` es un carácter ilegal y es sustituido por un espacio ``" "``, en Windows este se ve aparentemente como una carácter vacío.

--------

## Changelogs:


**Changelog: v0.13 a v0.48**

- Rescrito casi desde cero, ahora esta mejor organizado y es más fácil de leer para los curiosos.
- Mayor resistencia a "fallas" de entorno.
- Cambio del nombre del directorio "mpv" por "mpv-player" para prevenir posibles conflictos.
- La elevación de privilegios deberá de hacerse manualmente, si la falta de privilegios genera un error, este sera notificado.
- La opción para llamar "Símbolo del sistema" desde clic derecho solo sera agregada si se cuanta con derechos administrativos.
- Si youtube-dl.exe esta presente junto con el "mpv*.7z" también sera agregado a la carpeta de mpv-player.
- El Path environment de usuario sera modificado de forma "violenta", para prevenir conflictos... es por su bien.
- Si existe un Path environment previo, este sera "respaldado" en un archivo llamado "path_backup.txt".
- Los usuarios limitados podrán elegir solo agregar la variable de entorno si existe una instalación "global".
- El script cdmpv.bat seguirá siendo generado por funcionalidad y retrocompatibilidad...
- Desinstalación forzada, borra todo lo que "se deje borrar" de versiones posteriores del script y la actual. Si utilizaron la versión anterior del script, recomiendo ejecutar la desinstalación forzada con privilegios administrativos.
- El parámetro -noadmin ya no es valido ni necesario.
- Se agregaron dos nuevos parámetros, -runas y -uac. Estos parámetros tienen el único propósito de facilitar la ejecución del script para administradores de sistemas, no son de uso común.


**Changelog: v0.48 a v0.50**

- Arreglado el bug que impedía la adecuada detección del entorno al utilizar -runas, -uac, etc. en modo "multiusuario".
- Arreglados los bugs que aparecieron después de arreglar el anterior ya mencionado, y así y así.
- El código ahora en menos legible (más "goto") y se removió mucho código redundante, más del necesario...
- Otros cambios menores que son literalmente visibles.


**Changelog: v0.50 a v0.61-RC2**

- Agregada la opción "Asociar extensiones de archivo...", los dos scripts anteriores ahora son uno solo
- Agradados mensajes "auxiliares" en la parte superior...
- Script cdmpv.bat eliminado, ya no tiene razón de existencia
- La ruta de instalación para todos los usuarios ahora apunta dentro de Program Files y requiere derechos administrativos forzosamente. La instalación como usuario limitado aun es posible...
- Desinstalación forzada ahora puede hacer rollback relacionada con la asociación de extensiones de archivo
- El criterio para buscar youtube-dl ahora soporta un comodín, youtube-dl*. Se agrego compatibilidad con la extensión *.py, pero mpv a fecha de hoy no parece soportarlo.
- Al momento de actualizar, solo se sobrescribe la información anterior, no elimina la ruta completa como lo hacia el script anterior.
- Solo se forzara el cierre de sesión en caso de que se modifique la variable Path, es posible que la variable no funcione correctamente hasta reiniciar la sesión en algunos casos...
- Desinstalación forzada no borrara las rutas del anterior script, ni restaurara las extensiones modificadas por los scripts anteriores.
- Código más alienificado que nunca, algunas partes pueden causar dolor de cabeza, pero podrían encontrarlas muy didácticas =P
- Funcionalmente hablando, v0.60-RC3 y v0.61-RC2 hacen exactamente lo mismo.


[1]: http://www.7-zip.org/
[2]: http://mpv.srsfckn.biz/
[3]: http://rg3.github.io/youtube-dl/
[4]: https://ghostbin.com/paste/zcw73
[5]: https://ghostbin.com/paste/o9asv
[6]: https://ghostbin.com/paste/wxjaj
[7]: https://ghostbin.com/paste/95wed
