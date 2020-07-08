# crack
### data
`make data`

Анализ исполняемого файла вручную при помощи дебаггера выявил непосредственную близость в памяти буфера считывания и строки, содержащей верный пароль. Вместе с небезопасным считыванием это позволяет сделать проверку тривиальной при помощи перезаписи сравниваемых строк.

### patch
`make patch`

Тот же анализ выявил код проверки, что позволило заменить его весь на выполнение команды `nop`.

### dynamic
`make dynamic`

Всё тот же анализ выявил, какая функция была использована для считывания. Она загружается динамически, что даёт возможность
предоставить вместо неё свою функцию, просто возвращающую верный пароль, который так же был найден при анализе файла. Это происходит без изменения самого исполняемого файла.

# mine

Исходный код исполняемого файла, который был отправлен моему партнёру для выполнения аналогичной работы.