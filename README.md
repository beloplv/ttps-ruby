# README

# REQUISITOS TECNICOS

- Una versión reciente de Ruby (2.7 o superior). 
- La versión estable más reciente del framework Ruby on Rails (7.0.4 al momento de escribir este documento). 
- Una base de datos SQL (puede ser SQLite, PostgreSQL o MySQL). 


# COMANDOS PARA LEVANTAR LA APP

pararse en la carpeta del proyecto

- bundle install 
- rake db:create
- rake db:migrate
- rake db:seed
- rails s


# UML MODELOS Y ASOCIACIONES

https://drive.google.com/file/d/1fr5qEjTA-4yDjTkEBAL8JpgXNVfDtysU/view?usp=sharing

# RESTRICCIONES DE FUNCIONALIDAD

---------------------------------------------------------------------------------------------------------------
* TABLA Usuarios
---------------------------------------------------------------------------------------------------------------
- new: los clientes se pueden registrar mediante el sing up de la pagina (email, contraseña), los administradores pueden crear usuarios administradores (email, contraseña, rol: administrador) y usuarios empleados (email, contraseña, rol: empleado, sucursal: id)

- update: los clientes pueden modificar su perfil (email y/o contraseña), los empleados pueden modificar su perfil (email, contraseña), los administradores pueden modificar su perfil (email y/o contraseña) ademas pueden modificar el email y/o contraseña de los demas usuarios (clientes – empleados) y adicional pueden cambiar la sucursal del empleado. El rol no se modifica.

- destroy: el administrador puede eliminar a todos los usuarios menos a el mismo sin restricciones.
En el caso de eliminar un cliente o un empleado y este tiene turnos, estos tambien seran eliminados.

- index: los clientes solo pueden ver su usuario, el empleado puede ver a los clientes y a el mismo, los administradores pueden ver todos los usuarios

email: unico y formato valido
contraseña minimo de 6 caracteres
los campos no pueden estar en blanco

----------------------------------------------------------------------------------------------------------------
* TABLA Sucursales
----------------------------------------------------------------------------------------------------------------
- new: el administrador puede crear sucursales (nombre, direccion, telefono y localidad)

- update: el administrador puede modificar una sucursal (sin restricciones)

- destroy: el administrador puede eliminar las sucursales siempre y cuando estas no tengan empleados asignados, ni turnos en estado pendiente

- index: los administradores y empleados pueden ver las sucursales

nombre unico
los campos no pueden estar en blanco

----------------------------------------------------------------------------------------------------------------
* TABLA Horarios
----------------------------------------------------------------------------------------------------------------
- new: los administradores pueden crear horarios (dia, hora desde, hora hasta) la hora desde debe ser menor a la hora hasta (minimo una hora de diferencia)

- update: el administrador puede cambiar el horario (sin restricciones)

- destroy: el admnistrador puede eliminar los horarios si este no esta relacionado con una sucursal

- index: los administradores pueden ver los horarios 

la hora debe ser unica para el dia: es decir no puede haber 2 horarios con lunes de 8 a 12.
los campos no pueden estar en blanco

---------------------------------------------------------------------------------------------------------------
* TABLA Turnos
---------------------------------------------------------------------------------------------------------------
- new: el cliente puede crear un turno (sucursal, fecha, hora, motivo) la hora y la fecha debe coincidir con un horario de la sucursal seleccionada

- update: el cliente puede editar el turno si este no esta en estado atendido, de igual manera un empleado puede atender un turno editandolo, agregando el resultado

- destroy: el cliente puede cancelar el turno siempre y cuando este no esta en estado atendido

- index: el cliente puede ver sus turnos, y el empleado puede ver los turnos de la sucursal a la cual pertenece

los campos no pueden estar en blanco

----------------------------------------------------------------------------------------------------------------
* TABLA Localidades
----------------------------------------------------------------------------------------------------------------
- new: los administradores pueden crear localidades (provincia, nombre de localidad)

- update: el administrador puede cambiar la localidad (sin restricciones)

- destroy: el administrador puede eliminar una localidad siempre y cuando esta no este relacionada con una sucursal

- index: los administradores pueden ver las sucursales

nombre unico dentro de la provincia
los campos no pueden estar en blanco

--------------------------------------------------------------------------------------------------------------------
* TABLA Sucurales con Horarios
--------------------------------------------------------------------------------------------------------------------
- new: los administradores pueden agregar horarios a las sucursales, siempre y cuando no se repitan los dias para una misma sucursal

- update: los administradores pueden cambiar el horario, siempre y cuando no se repitan los dias para una misma sucursal y ademas si es que el horario seleccionado para editar no tiene turnos pendientes

- destroy: el administrador puede eliminar esta relacion sucursal – horario, siempre y cuando no haya un turno pendiente en esa sucursal con ese horario

- index: los administradores y empleados pueden ver los horarios de las sucursales

los campos no pueden estar en blanco
