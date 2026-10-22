@echo off
:: Скрипт для запуска игры (Windows)
:: Предполагается, что исполняемый файл godot находится в PATH как 'godot' или 'godot4'

where godot4 >nul 2>nul
if %errorlevel% equ 0 (
    godot4 --path . %*
    goto end
)

where godot >nul 2>nul
if %errorlevel% equ 0 (
    godot --path . %*
    goto end
)

echo Не удалось найти Godot 4. Убедитесь, что godot или godot4 находится в вашей переменной среды PATH.
pause

:end
