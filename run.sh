#!/bin/bash
# Скрипт для запуска игры (Linux/Mac)
# Предполагается, что исполняемый файл godot находится в PATH как 'godot' или 'godot4'

if command -v godot4 &> /dev/null
then
    godot4 --path . "$@"
elif command -v godot &> /dev/null
then
    godot --path . "$@"
else
    echo "Не удалось найти Godot 4. Убедитесь, что godot или godot4 находится в вашем PATH."
    exit 1
fi
